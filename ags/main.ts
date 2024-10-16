import Background from "./widget/background/Background"
import MainBar from "widget/bar/Bar"

App.config({
  style: '/tmp/ags/style.css',

  windows: [
    Background(),
    MainBar(),
  ]
})

export { }
