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

        label: hyprland.active.client.bind('class').as(label => label.length === 0 ? 'Desktop' : label),
/*
        setup: (self) => self.hook(hyprland.active.client, label => { // hyprland.active.client
          label.label = hyprland.active.client.class.length === 0 ? 'Desktop' : hyprland.active.client.class;
        }), */
      }),
      Widget.Label({
        class_name: 'client_title',

        xalign: 0,
        truncate: 'end',
        maxWidthChars: 1, // Doesn't matter, just needs to be non negative

        setup: (self) => self.hook(hyprland.active.client, label => { // hyprland.active.client
          label.label = hyprland.active.client.title.length === 0 ? `Workspace ${hyprland.active.workspace.id}` : hyprland.active.client.title;
        }),
      })
    ]
  })
});
