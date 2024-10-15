const hyprland = await Service.import('hyprland')

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`)

export default () => Widget.EventBox({
  onScrollUp: () => dispatch("+1"),
  onScrollDown: () => dispatch("-1"),

  child: Widget.Box({
    children: Array.from({ length: 6 }, (_, i) => i + 1).map(i => Widget.Button({
      on_clicked: () => dispatch(`${i}`),

      // Class Name should be focused if the current workspace is focused,
      // occupied if it has windows and empty if not
      class_name: hyprland.active.workspace.bind('id').as(id => id === i ? 'focused' : 'empty'),

      label: i.toString(),
    })),
  })
})
