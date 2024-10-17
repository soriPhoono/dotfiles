const hyprland = await Service.import('hyprland')

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`)

export default () => Widget.EventBox({
  class_name: 'workspaces',

  onScrollUp: () => dispatch("+1"),
  onScrollDown: () => dispatch("-1"),

  child: Widget.Box({
    children: Array.from({ length: 6 }, (_, i) => i + 1).map(i => Widget.EventBox({
      on_primary_click: () => dispatch(`${i}`),

      child: Widget.EventBox({
        setup: self => {
          const workspace = Widget.Label({
            class_name: 'workspace',

            label: hyprland.active.workspace.bind('id').as(id => id === i ? '' : ''),

            setup: self => self.hook(hyprland.active.workspace, () => {
              self.toggleClassName('workspace_active', hyprland.active.workspace.id === i)
            })
          })

          self.on_hover = () => workspace.toggleClassName('workspace_hover', true)
          self.on_hover_lost = () => workspace.toggleClassName('workspace_hover', false)

          self.child = workspace
        }
      })
    })),
  })
})
