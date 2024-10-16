const battery = await Service.import('battery')

export default () => Widget.EventBox({
  class_name: 'battery',

  visible: battery.bind('available'),

  setup: self => {
    console.log(`Battery available: ${battery.available}`)

    const percent = Widget.Revealer({
      reveal_child: false,
      transition_duration: 1000,
      transition: 'slide_left',

      child: Widget.Label({
        label: battery.bind('percent').as(p => `${p}%`)
      })
    })

    self.on_hover = () => percent.reveal_child = true;
    self.on_hover_lost = () => percent.reveal_child = false;

    self.child = Widget.Box({
      children: [
        // Battery icon
        Widget.Icon({
          icon: battery.bind('icon_name')
        }),
        percent
      ]
    })
  }
})
