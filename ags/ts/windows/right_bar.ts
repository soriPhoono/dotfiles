import SystemTray from '../widgets/system_tray';
import Volume from "../widgets/volume"

export default (monitor: number = 0) => Widget.Window({
  name: 'right_bar',
  class_name: 'right_bar',
  monitor,
  anchor: ['top', 'right'],
  exclusivity: 'exclusive',
  layer: 'top',
  child: Widget.Box({
    class_name: 'right_bar_body',
    spacing: 8,

    children: [
      // system tray
      SystemTray(),
      // Volume slider
      Volume(),
    ]
  }),
})
