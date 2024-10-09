const Bar = () => Widget.Window({
    name: 'Bar',
    child: Widget.Label("Bar")
})

App.config({
    windows: [
        Bar()
    ]
})