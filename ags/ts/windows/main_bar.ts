import Workspaces from "../widgets/workspaces"
import NowPlaying from "../widgets/now_playing"
import Volume from "../widgets/volume"

const LeftWidgets = () => Widget.Box({
  class_name: 'main_bar_left',
  spacing: 8,

  children: [
    // session controls
    // workspaces
    Workspaces()
  ]
})

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
  name: 'main_bar',
  class_name: 'main_bar',
  monitor: 2,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    start_widget: LeftWidgets(),
    center_widget: MiddleWidgets(),
    end_widget: RightWidgets(),
  })
})
