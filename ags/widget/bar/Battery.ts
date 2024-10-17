import HoverRevealer from "lib/HoverRevealer";

const battery = await Service.import('battery')

export default () => HoverRevealer({
  visible: battery.bind('available'),
},
  Widget.Icon({
    icon: battery.bind('icon_name')
  }),
  Widget.Label({
    label: battery.bind('percent').as(p => `${p}%`)
  })
)

/* export default () => Widget.EventBox({
  visible: battery.bind('available'),

  setup: self => {
    const percent = Widget.Revealer({
      reveal_child: false,
      transition_duration: 1000,
      transition: 'slide_right',

      child: Widget.Label({
        label: battery.bind('percent').as(p => `${p}%`)
      })
    })

    self.on_hover = () => percent.reveal_child = true;
    self.on_hover_lost = () => percent.reveal_child = false;

    self.child = Widget.Box({
      children: [
        // Battery icon
        Widget.Icon({
          icon: battery.bind('icon_name')
        }),
        percent
      ]
    })
  }
})
 */
