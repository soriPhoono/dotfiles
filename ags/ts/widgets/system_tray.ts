const system_tray = await Service.import('systemtray')

export default () => Widget.Box({
  class_name: 'system_tray',

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
})
