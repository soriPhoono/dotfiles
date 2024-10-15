const time = Variable("", {
  poll: [1000, 'date "+%H:%M %p"']
})

const date = Variable("", {
  poll: [1000, 'date "+%B %d, %A"']
})

export default () => Widget.CenterBox({
  center_widget: Widget.CenterBox({
    vertical: true,

    center_widget: Widget.Box({
      vertical: true,

      children: [
        Widget.Label({
          class_name: "time",
          label: time.bind(),
        }),
        Widget.Label({
          class_name: "date",
          label: date.bind(),
        })
      ]
    })
  })
})
