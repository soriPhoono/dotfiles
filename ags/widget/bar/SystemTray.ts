const system_tray = await Service.import('systemtray')

export default () => Widget.Revealer({
  reveal_child: system_tray.bind('items').as(items => items.length > 0),
  transition: 'slide_right',
  transition_duration: 1000,

  child: Widget.Box({
    children: [
      Widget.Box({
        children: system_tray.bind('items')
          .as(items =>
            items.map(item =>
              Widget.EventBox({
                on_primary_click: (_, event) => item.activate(event),
                on_secondary_click: (_, event) => item.openMenu(event),

                child: Widget.Icon({ icon: item.bind('icon') }),

                tooltip_markup: item.bind('tooltip_markup'),
              })
            )
          )
      }),
      Widget.Label({
        label: ' | ',
      }),
    ]
  })
})
