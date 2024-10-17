const hyprland = await Service.import('hyprland')

import MainBar from "widget/bar/Bar"
import { applauncher } from "widget/launcher/AppLauncher"

const monitor_id = hyprland.monitors.filter(
  m => m.name.includes('DP-4') || m.name.includes('eDP-1')
)[0]

console.log(`Using monitor ${monitor_id.name}`)

App.config({
  style: '/tmp/ags/style.css',

  windows: [
    MainBar(monitor_id.id),

    applauncher,
  ]
})

export { }
