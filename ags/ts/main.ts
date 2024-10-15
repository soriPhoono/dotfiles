import Background from "./windows/background"
import MainBar from "./windows/left_bar"

App.config({
  style: '/tmp/ags/style.css',

  windows: [
    Background(),
    MainBar()
  ]
})

export { }
