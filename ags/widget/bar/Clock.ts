const time = Variable("", {
  poll: [1000, 'date "+%H:%M"']
})

const date = Variable("", {
  poll: [1000, 'date "+%A, %d/%m"']
})

export default () => Widget.Box({
  children: [
    Widget.Label({
      label: time.bind(),
    }),

    Widget.Label({
      label: date.bind(),
    }),
  ]
})
