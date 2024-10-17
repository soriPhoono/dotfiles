const time = Variable("", {
  poll: [1000, 'date "+%H:%M"']
})

export default () => Widget.Box({
  children: [
    Widget.Label({
      label: ' | ',
    }),
    Widget.Label({
      label: time.bind(),
    }),
  ]
})
