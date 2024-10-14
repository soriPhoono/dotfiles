const hyprland = await Service.import('hyprland')
const notifications = await Service.import('notifications')
const mpris = await Service.import('mpris')
const audio = await Service.import('audio')
const battery = await Service.import('battery')
const system_tray = await Service.import('systemtray')

const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e."']
})

const Workspaces = () => {
  return Widget.Box({
    // class_name: "workspaces",
    children: hyprland.bind("workspaces")
      .as(ws => ws.map(({ id }) => Widget.Button({
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: Widget.Label(`${id}`),
        // class_name: hyprland.active.workspace.bind("id").as(i => `${i === id ? "focused" : ""}`),
      })))
  })
}

const ClientTitle = () => {
  return Widget.Label({
    class_name: "client-title",
    label: hyprland.active.client.bind("title"),
  })
}

const Clock = () => {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  })
}

const Notifications = () => {
  const popups = notifications.bind("popups")
  return Widget.Box({
    class_name: "notifications",
    visible: popups.as(p => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic"
      }),
      Widget.Label({
        label: popups.as(p => p[0]?.summary || ""),
      })
    ]
  })
}

const Media = () => {
  const label = Utils.watch("", mpris, "player-changed", () => {
    if (mpris.players[0]) {
      const { track_artists, track_title } = mpris.players[0]
      return `${track_artists.join(", ")} - ${track_title}`
    } else {
      return "Nothing is playing"
    }
  })

  return Widget.Button({
    class_name: "media",
    on_primary_click: () => mpris.getPlayer("")?.playPause(),
    on_scroll_up: () => mpris.getPlayer("")?.next(),
    on_scroll_down: () => mpris.getPlayer("")?.previous(),
    child: Widget.Label({ label }),
  })
}

const Volume = () => {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  }

  function getIcon() {
    const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
      threshold => threshold <= audio.speaker.volume * 100
    )

    if (icon === undefined) {
      throw new Error(`Invalid volume: ${audio.speaker.volume}`)
    }

    return `audio-volume-${icons[icon]}-symbolic`
  }

  const icon = Widget.Icon({
    icon: Utils.watch(getIcon(), audio.speaker, getIcon)
  })

  const slider = Widget.Slider({
    hexpand: true,
    draw_value: false,
    on_change: ({ value }) => audio.speaker.volume = value,
    setup: self => self.hook(audio.speaker, () => {
      self.value = audio.speaker.volume || 0
    })
  })

  return Widget.Box({
    class_name: "volume",
    css: "min-width: 180px",
    children: [icon, slider],
  })
}

const Battery = () => {
  const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
  const icon = battery.bind('percent').as(p =>
    `battery-level${Math.floor(p / 10) * 10}-symbolic`)

  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    children: [
      Widget.Icon({ icon }),
      Widget.LevelBar({
        widthRequest: 140,
        vpack: "center",
        value,
      }),
    ],
  })
}

const SystemTray = () => {
  const items = system_tray.bind('items')
    .as(items => items.map(item => Widget.Button({
      child: Widget.Icon({ icon: item.bind('icon') }),
      on_primary_click: (_, event) => item.activate(event),
      on_secondary_click: (_, event) => item.openMenu(event),
      tooltip_markup: item.bind('tooltip_markup'),
    })))

  return Widget.Box({
    children: items
  })
}

const left_widgets = () => Widget.Box({
  spacing: 8,

  children: [
    // workspaces
    Workspaces(),
    // client title
    ClientTitle()
  ]
})

const middle_widgets = () => Widget.Box({
  spacing: 8,

  children: [
    // currently playing
    Media(),
    // notifications
    Notifications(),
  ]
})

const right_widgets = () => Widget.Box({
  hpack: 'end',

  spacing: 8,

  children: [
    // volume
    Volume(),
    // battery
    Battery(),
    // clock
    Clock(),
    // system tray
    SystemTray()
  ]
})

const main_bar = (monitor: number = 0) => Widget.Window({
  name: `bar-${monitor}`,
  // class_name: 'main_bar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    start_widget: left_widgets(),
    center_widget: middle_widgets(),
    end_widget: right_widgets(),
  })
})

App.config({
  windows: [
    main_bar()
  ]
})

export {}