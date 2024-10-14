const battery = await Service.import('battery')

export default () => Widget.Box({
  class_name: "battery",
  visible: battery.bind("available"),
  children: [
    Widget.Icon({
      icon: battery.bind('percent').as(p =>
        `battery-level${Math.floor(p / 10) * 10}-symbolic`)
    }),
    Widget.LevelBar({
      widthRequest: 140,
      vpack: "center",
      value: battery.bind("percent").as(p => p > 0 ? p / 100 : 0),
    }),
  ],
})
