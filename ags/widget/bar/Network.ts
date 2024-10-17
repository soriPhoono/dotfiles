import HoverRevealer from "lib/HoverRevealer"

const network = await Service.import('network')

export default () => HoverRevealer({
  class_name: 'network',

  on_primary_click: () => Utils.execAsync('nm-connection-editor').catch(console.error),
  on_secondary_click: () => network.toggleWifi(),
},
  Widget.Icon({
    setup: self => self.hook(network, () => {
      if (network.primary === 'wifi') {
        self.icon = network.wifi.icon_name
      } else {
        self.icon = network.wired.icon_name
      }
    })
  }),
  Widget.Label({
    setup: self => self.hook(network, () => {
      if (network.primary === 'wifi') {
        if (network.wifi.ssid) {
          self.label = network.wifi.ssid
        } else {
          self.label = "Unknown"
        }
      } else {
        self.label = network.wired.internet
      }
    })
  })
)

/* export default () => Widget.EventBox({
  class_name: 'network',

  on_primary_click: () => Utils.execAsync('nm-connection-editor').catch(console.error),
  on_secondary_click: () => network.toggleWifi(),

  setup: self => {
    const id = Widget.Revealer({
      reveal_child: false,
      transition_duration: 1000,
      transition: 'slide_right',

      setup: self => {
        if (network.primary === 'wifi') {
          self.child = Widget.Label({
            label: network.wifi.bind('ssid').as(id => `${id}`),
          })
        } else {
          self.child = Widget.Label({
            label: network.wired.bind('internet')
          })
        }
      }
    })

    self.on_hover = () => id.reveal_child = true;
    self.on_hover_lost = () => id.reveal_child = false;

    if (network.primary === 'wifi') {
      self.child = Widget.Box({
        children: [
          Widget.Icon({
            icon: network.wifi.bind('icon_name')
          }),
          id
        ]
      })
    } else {
      self.child = Widget.Box({
        children: [
          Widget.Icon({
            icon: network.wired.bind('icon_name'),
          }),
          id
        ]
      })
    }
  }
})
 */
