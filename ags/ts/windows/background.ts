import Clock from '../widgets/clock'

export default (monitor: number = 0) => Widget.Window({
  name: 'background',
  class_name: 'background',
  monitor,
  anchor: ['top', 'left', 'right', 'bottom'],
  exclusivity: 'ignore',
  layer: 'background',
  child: Clock(),
})
