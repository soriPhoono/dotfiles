const hyprland = await Service.import('hyprland')

export default () => Widget.Scrollable({
  hexpand: true,
  vexpand: true,

  hscroll: 'automatic',
  vscroll: 'never',

  child: Widget.Box({
    vertical: true,
    children: [
      Widget.Label({
        class_name: 'client_class',

        xalign: 0,
        truncate: 'end',
        maxWidthChars: 1, // Doesn't matter, just needs to be non negative

        label: hyprland.active.client.bind('class')
          .as(label => label.length > 0 ? label : 'Desktop')
      }),
      Widget.Label({
        class_name: 'client_title',

        xalign: 0,
        truncate: 'end',
        maxWidthChars: 1, // Doesn't matter, just needs to be non negative

        label: hyprland.active.client.bind('title')
          .as(label => label.length > 0 ? label : `Workspace ${hyprland.active.workspace.id}`)
      })
    ]
  })
});
