import { Widget } from '../../imports.js';

import TimeAndLaunchesWidget from './timeandlaunches.js'
import SystemWidget from './system.js'

export default () => Widget.Window({
    name: 'desktopbackground',
    anchor: ['top', 'bottom', 'left', 'right'],
    layer: 'background',
    exclusivity: 'normal',
    visible: true,
    child: Widget.Overlay({
        child: Widget.Box({
            hexpand: true,
            vexpand: true,
        }),
        overlays: [
            // GraphWidget(),
            TimeAndLaunchesWidget(),
            SystemWidget(),
        ],
        setup: (self) => self.set_overlay_pass_through(self.get_children()[1], true),
    }),
});