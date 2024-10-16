const battery = await Service.import('battery')

export default () => Widget.EventBox({
  class_name: 'battery',

  visible: battery.bind('available'),

  child: Widget.Box({
    children: [
      // Battery icon
      Widget.Icon({
        icon: battery.bind('percent').as(p =>
          `battery-level${Math.floor(p / 10) * 10}-symbolic`)
      }),
      Widget.Revealer({
        reveal_child: true,

        child: Widget.Icon({
          icon: battery.bind('charging').as(p => p ? 'battery-charging-symbolic' : 'battery-symbolic')
        })
      })
      // Time till full
    ]
  })
})
