import Workspaces from "./Workspaces";
import SystemTray from "./SystemTray";
import Network from './Network';
import Volume from "./Volume";
import Battery from "./Battery";
import Clock from "./Clock";

const LeftWidgets = () => Widget.Box({
  children: [
    Widget.Box({
      class_name: 'left_main_bar',

      children: [

      ]
    })
  ]
})

const CenterWidgets = () => Widget.Box({
  class_name: 'center_main_bar',

  children: [
    Workspaces(),
  ]
})

const RightWidgets = () => Widget.Box({
  hpack: 'end',

  children: [
    Widget.Box({
      class_name: 'right_main_bar',

      children: [
        SystemTray(),
        Network(),
        Volume(),
        Battery(),
        Clock(),
      ]
    })
  ]
})

export default (monitor: number = 0) => Widget.Window({
  name: 'main_bar',
  class_name: 'main_bar',
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  margins: [20, 20, 0, 20],
  monitor,

  child: Widget.CenterBox({
    start_widget: LeftWidgets(),
    center_widget: CenterWidgets(),
    end_widget: RightWidgets(),
  })
})
