const hyprland = await Service.import('hyprland')

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`)

export default () => Widget.EventBox({
  class_name: 'workspaces',

  onScrollUp: () => dispatch("+1"),
  onScrollDown: () => dispatch("-1"),

  child: Widget.Box({
    children: Array.from({ length: 6 }, (_, i) => i + 1).map(i => Widget.Button({
      on_clicked: () => dispatch(`${i}`),

      class_names: hyprland.active.workspace.bind('id').as(
        id => id === i ? ['workspace', 'workspace_active'] : ['workspace']
      ),

      label: i.toString(),
    })),
  })
})
