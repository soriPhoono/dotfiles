const time = Variable("", {
  poll: [1000, 'date "+%H:%M"']
})

const date = Variable("", {
  poll: [1000, 'date "+%A, %d/%m"']
})

export default () => Widget.Box({
  vertical: true,

  children: [
    Widget.Label({
      class_name: 'time',

      label: time.bind(),
    }),
    Widget.Label({
      class_name: 'date',

      label: date.bind(),
    }),
  ]
})