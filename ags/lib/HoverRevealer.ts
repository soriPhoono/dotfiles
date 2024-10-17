import { EventBox } from "resource:///com/github/Aylur/ags/widgets/eventbox.js"
import Gtk from "types/@girs/gtk-3.0/gtk-3.0"
import { EventBoxProps } from "types/widgets/eventbox"

export default (props: EventBoxProps<Gtk.Widget, unknown, EventBox<Gtk.Widget, unknown>> | undefined, icon: any, child: any) => Widget.EventBox({
  ...props,

  setup: self => {
    const child_revealer = Widget.Revealer({
      reveal_child: false,
      transition_duration: 1000,
      transition: 'slide_right',
      child
    })

    self.on_hover = () => child_revealer.reveal_child = true
    self.on_hover_lost = () => child_revealer.reveal_child = false

    self.child = Widget.Box({
      children: [icon, child_revealer]
    })
  }
})
