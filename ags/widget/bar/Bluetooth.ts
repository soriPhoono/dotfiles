const bluetooth = await Service.import('bluetooth')

export default () => Widget.EventBox({
  on_primary_click: () => Utils.exec('blueman'),
  on_secondary_click: () => bluetooth.toggle(),

  setup: self => {
    const devices = Widget.Revealer({
      visible: bluetooth.bind('connected_devices').as(connected => connected.length > 0),

      reveal_child: bluetooth.bind('connected_devices').as(connected => connected.length > 0),
      transition_duration: 1000,
      transition: 'slide_right',

      child: Widget.Box({
        children: bluetooth.connected_devices.map(device =>
          Widget.Box({
            children: [
              Widget.Icon({
                icon: device.bind('icon_name')
              }),
              Widget.Label({
                label: device.bind('battery_percentage').as(percentage => `${percentage}%`)
              })
            ]
          })
        )
      })
    })

    self.on_hover = () => devices.reveal_child = true
    self.on_hover_lost = () => devices.reveal_child = false

    self.child = Widget.Box({
      children: [
        Widget.Icon({
          icon: bluetooth.bind('enabled').as(enabled => enabled ? 'bluetooth-connected-symbolic' : 'bluetooth-disabled-symbolic')
        }),
        devices
      ]
    })
  }
})
