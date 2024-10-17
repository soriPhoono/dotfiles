import Workspaces from "./Workspaces";
import SystemTray from "./SystemTray";
import Network from './Network';
import Volume from "./Volume";
import Battery from "./Battery";
import Clock from "./Clock";
import Bluetooth from "./Bluetooth";
import ClientTitle from "./ClientTitle";

const LeftWidgets = () => Widget.Box({
  children: [
    Widget.Box({
      class_name: 'left_main_bar',

      children: [
        // Session management
        ClientTitle(),
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
        Bluetooth(),
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
  monitor,

  child: Widget.CenterBox({
    start_widget: LeftWidgets(),
    center_widget: CenterWidgets(),
    end_widget: RightWidgets(),
  })
})
