const network = await Service.import('network')

export default () => Widget.EventBox({
  class_name: "network",

  on_primary_click: () => Utils.exec('nm-applet'),
  on_secondary_click: () => network.toggleWifi(),

  setup: self => {
    const slider = Widget.Revealer({
      reveal_child: false,
      transition_duration: 1000,
      transition: 'slide_left',
    })
  }
})
