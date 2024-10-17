const hyprland = await Service.import('hyprland')

import Background from "./widget/background/Background"
import MainBar from "widget/bar/Bar"

const monitor_id = hyprland.monitors.filter(
  m => m.name.includes('DP-4') || m.name.includes('eDP-1')
)[0]

console.log(`Using monitor ${monitor_id.name}`)

App.config({
  style: '/tmp/ags/style.css',

  windows: [
    Background(monitor_id.id),
    MainBar(monitor_id.id),
  ]
})

export { }
