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

const slider_revealer = () => Widget.Revealer({
  reveal_child: false,
  transition_duration: 1000,
  transition: 'slide_left',
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

export default () => {
  const slider = slider_revealer()

  return Widget.EventBox({
    class_name: "volume",

    on_hover: () => slider.reveal_child = true,
    on_hover_lost: () => slider.reveal_child = false,

    on_primary_click: () => Utils.exec('pavucontrol'),
    on_secondary_click: () => audio.speaker.is_muted = !audio.speaker.is_muted,

    on_scroll_up: () => audio.speaker.volume = Math.max(0, audio.speaker.volume - 0.1),
    on_scroll_down: () => audio.speaker.volume = Math.min(1, audio.speaker.volume + 0.1),

    child: Widget.Box({
      children: [
        Widget.Icon({
          icon: Utils.watch(getIcon(), audio.speaker, getIcon)
        }),
        slider,
      ]
    })
  })
}
