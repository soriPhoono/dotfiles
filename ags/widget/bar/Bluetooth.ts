import HoverRevealer from "lib/HoverRevealer"

const bluetooth = await Service.import('bluetooth')

export default () => HoverRevealer({
  class_name: 'bluetooth',

  on_primary_click: () => Utils.execAsync('blueberry').catch(console.error),
  on_secondary_click: () => bluetooth.toggle(),
},
  Widget.Icon({
    icon: bluetooth.bind('connected_devices').as(connected_devices => connected_devices.length > 0
      ? 'bluetooth-symbolic'
      : 'bluetooth-disconnected-symbolic')
  }),
  Widget.Box({
    children: bluetooth.bind('connected_devices').as(devices => devices.map(device =>
      Widget.Box({
        children: [
          Widget.Icon({
            icon: device.bind('icon_name').as(icon_name => `${icon_name}-symbolic`)
          }),
          Widget.Label({
            label: device.bind('battery_percentage').as(percentage => `${percentage}%`)
          })
        ]
      })
    ))
  })
)

