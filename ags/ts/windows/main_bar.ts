import workspaces from "ts/widgets/workspaces"

const left_widgets = () => Widget.Box({
  spacing: 8,

  children: [
    // workspaces
    workspaces()
    // client title
  ]
})

const middle_widgets = () => Widget.Box({
  spacing: 8,

  children: [
    // currently playing
    // notifications
  ]
})

const right_widgets = () => Widget.Box({
  hpack: 'end',

  spacing: 8,

  children: [
    // volume
    // battery
    // clock
    // system tray
  ]
})

export default (monitor: number = 0) => Widget.Window({
  name: `bar-${monitor}`,
  class_name: 'main_bar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    start_widget: left_widgets(),
    center_widget: middle_widgets(),
    end_widget: right_widgets(),
  })
})

