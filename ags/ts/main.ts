import Background from "./windows/background"
import LeftBar from "./windows/left_bar"
import RightBar from "./windows/right_bar"

App.config({
  style: '/tmp/ags/style.css',

  windows: [
    Background(),
    LeftBar(),
    RightBar(),
  ]
})

export { }
