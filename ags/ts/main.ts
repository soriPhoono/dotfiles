import Background from "./windows/background"
import MainBar from "./windows/main_bar"

App.config({
  style: '/tmp/ags/style.css',

  windows: [
    Background(2),
    MainBar(2)
  ]
})

export { }
