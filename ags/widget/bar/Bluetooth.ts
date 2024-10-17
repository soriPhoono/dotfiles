const bluetooth = await Service.import('bluetooth')

export default () => Widget.EventBox({
  on_primary_click: () => Utils.execAsync('blueberry').catch(console.error),
  on_secondary_click: () => bluetooth.toggle(),

  setup: self => {
    const devices = Widget.Revealer({
      reveal_child: false,
      transition_duration: 1000,
      transition: 'slide_right',

      child: Widget.Box({
        children: bluetooth.bind('connected_devices').as(devices => {
          if (devices.length > 0) {
            return devices.map(device =>
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
            )
          } else {
            return [
              Widget.Label({
                label: 'No devices connected'
              })
            ]
          }
        })
      })
    })

    self.on_hover = () => devices.reveal_child = true
    self.on_hover_lost = () => devices.reveal_child = false

    self.child = Widget.Box({
      children: [
        Widget.Icon({
          icon: bluetooth.bind('connected_devices').as(connected_devices => connected_devices.length > 0
            ? 'bluetooth-symbolic'
            : 'bluetooth-disconnected-symbolic')
        }),
        devices
      ]
    })
  }
})
