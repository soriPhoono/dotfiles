export const Hud = (monitor_id: number) =>
  Widget.Window({
    name: `Hud-${monitor_id}`,
    child: Widget.Label("hello"),
  });
