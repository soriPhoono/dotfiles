export default (monitor: number = 0) => Widget.Window({
  name: 'background',
  class_name: 'background',
  monitor,
  anchor: ['right', 'bottom'],
  exclusivity: 'ignore',
  layer: 'background',
  child: Widget.Box({
    children: [
      // TODO: Add cpu and ram usage
    ]
  }),
})
