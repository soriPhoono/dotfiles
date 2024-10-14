const hyprland = await Service.import('hyprland')

export default () => Widget.Box({
  // class_name: "workspaces",
  children: hyprland.bind("workspaces")
    .as(ws => ws.map(({ id }) => Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Label(`${id}`),
      // class_name: hyprland.active.workspace.bind("id").as(i => `${i === id ? "focused" : ""}`),
    })))
})
