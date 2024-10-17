import HoverRevealer from "lib/HoverRevealer"

const audio = await Service.import('audio')

const getIcon = () => {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  }

  const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
    threshold => threshold <= audio.speaker.volume * 100
  )

  if (icon === undefined) {
    console.error(`Unknown volume level: ${audio.speaker.volume * 100}%`)

    throw new RangeError(`Unknown volume level: ${audio.speaker.volume * 100}%`)
  }

  return `audio-volume-${icons[icon]}-symbolic`
}

export default () => HoverRevealer({
  on_primary_click: () => Utils.execAsync('pavucontrol').catch(console.error),
  on_secondary_click: () => audio.speaker.is_muted = !audio.speaker.is_muted,

  on_scroll_up: () => audio.speaker.volume = Math.max(0, audio.speaker.volume - 0.1),
  on_scroll_down: () => audio.speaker.volume = Math.min(1, audio.speaker.volume + 0.1),
}, Widget.Icon({
  icon: Utils.watch(getIcon(), audio.speaker, getIcon)
}), Widget.Slider({
  hexpand: true,
  draw_value: false,
  width_request: 140,
  on_change: ({ value }) => audio.speaker.volume = value,
  setup: self => self.hook(audio.speaker, () => {
    self.value = audio.speaker.volume || 0
  })
}))

/* export default () => Widget.EventBox({
  on_primary_click: () => Utils.execAsync('pavucontrol').catch(console.error),
  on_secondary_click: () => audio.speaker.is_muted = !audio.speaker.is_muted,

  on_scroll_up: () => audio.speaker.volume = Math.max(0, audio.speaker.volume - 0.1),
  on_scroll_down: () => audio.speaker.volume = Math.min(1, audio.speaker.volume + 0.1),

  setup: self => {
    const slider = Widget.Revealer({
      reveal_child: false,
      transition_duration: 1000,
      transition: 'slide_right',
      child: Widget.Slider({
        hexpand: true,
        draw_value: false,
        width_request: 140,
        on_change: ({ value }) => audio.speaker.volume = value,
        setup: self => self.hook(audio.speaker, () => {
          self.value = audio.speaker.volume || 0
        })
      })
    })

    self.on_hover = () => slider.reveal_child = true
    self.on_hover_lost = () => slider.reveal_child = false

    self.child = Widget.Box({
      children: [
        Widget.Icon({
          icon: Utils.watch(getIcon(), audio.speaker, getIcon)
        }),
        slider,
      ]
    })
  }
})

 */
