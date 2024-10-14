import Workspaces from "../widgets/workspaces"
import ClientTitle from "../widgets/client_title"
import Clock from "../widgets/clock"
import Notifications from "../widgets/notifications"
import NowPlaying from "../widgets/now_playing"
import Volume from "../widgets/volume_slider"
import Battery from "../widgets/battery_monitor"
import SystemTray from "../widgets/system_tray"

const LeftWidgets = () => Widget.Box({
  spacing: 8,

  children: [
    // workspaces
    Workspaces(),
    // client title
    ClientTitle()
  ]
})

const MiddleWidgets = () => Widget.Box({
  spacing: 8,

  children: [
    // currently playing
    NowPlaying(),
    // notifications
    Notifications(),
  ]
})

const RightWidgets = () => Widget.Box({
  hpack: 'end',

  spacing: 8,

  children: [
    // volume
    Volume(),
    // battery
    Battery(),
    // clock
    Clock(),
    // system tray
    SystemTray()
  ]
})

export default (monitor: number = 0) => Widget.Window({
  name: `bar-${monitor}`,
  // class_name: 'main_bar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    start_widget: LeftWidgets(),
    center_widget: MiddleWidgets(),
    end_widget: RightWidgets(),
  })
})
