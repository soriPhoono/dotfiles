import Workspaces from "../widgets/workspaces"
import NowPlaying from "../widgets/now_playing"
import Volume from "../widgets/volume"

const MiddleWidgets = () => Widget.Box({
  class_name: 'main_bar_middle',
  spacing: 8,

  children: [
    // currently playing
    NowPlaying(),
  ]
})

const RightWidgets = () => Widget.Box({
  class_name: 'main_bar_right',
  hpack: "end",

  spacing: 8,

  children: [
    Volume(),
  ]
})

export default (monitor: number = 0) => Widget.Window({
  name: 'left_bar',
  class_name: 'left_bar',
  monitor,
  anchor: ['top', 'left'],
  exclusivity: 'exclusive',
  layer: 'top',
  child: Widget.Box({
    class_name: 'left_bar_body',
    spacing: 8,

    children: [
      // session controls
      // workspaces
      Workspaces(),
    ]
  }),
})
