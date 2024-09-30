const Bar = () =>
  Widget.Window({
    name: "bar",
    anchor: ["top", "left", "right"],
    child: Widget.Label().poll(
      1000,
      (label) => (label.label = Utils.exec("date")),
    ),
  });

App.config({
  windows: [Bar(0)],
});
