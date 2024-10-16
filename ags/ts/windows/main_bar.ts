import Workspaces from "ts/widgets/workspaces";
import NowPlaying from "ts/widgets/now_playing";
import SystemTray from "ts/widgets/system_tray";
import Volume from "ts/widgets/volume";

const LeftWidgets = () => Widget.Box({
  children: [
    Widget.Box({
      class_name: 'left_main_bar',

      children: [
        Workspaces(),
      ]
    })
  ]
})

const CenterWidgets = () => Widget.Box({
  children: [
    Widget.Box({
      class_name: 'center_main_bar',

      children: [
        NowPlaying(),
      ]
    })
  ]
})

const RightWidgets = () => Widget.Box({
  hpack: 'end',

  children: [
    Widget.Box({
      class_name: 'right_main_bar',

      children: [
        SystemTray(),
        Volume(),
      ]
    })
  ]
})

export default (monitor: number = 0) => Widget.Window({
  name: 'main_bar',
  class_name: 'main_bar',
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  margins: [20, 20, 20, 0],
  monitor,

  child: Widget.CenterBox({
    start_widget: LeftWidgets(),
    center_widget: CenterWidgets(),
    end_widget: RightWidgets(),
  })
})
