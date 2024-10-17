import SystemControls from "./SystemControls";

export default() => Widget.Window({
  name: 'left_panel',
  class_name: 'panel',
  anchor: ['left', 'top', 'bottom'],

  visible: false,

  keymode: 'on-demand',

  child: Widget.Box({
    orientation: 'vertical',

    children: [
      SystemControls(),
    ]
  })
})

/* import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
const { Box, Window } = Widget;


const popup = ({
  name,
  child,
  showClassName = "",
  hideClassName = "",
  ...props
}) => {
  return Window({
    name,
    visible: true,
    layer: 'overlay',
    ...props,

    child: Box({
      setup: (self) => {
        self.keybind("Escape", () => closeEverything());
        if (showClassName != "" && hideClassName !== "") {
          self.hook(App, (self, currentName, visible) => {
            if (currentName === name) {
              self.toggleClassName(hideClassName, !visible);
            }
          });

          if (showClassName !== "" && hideClassName !== "")
            self.class_name = `${showClassName} ${hideClassName}`;
        }
      },
      child: child,
    }),
  });
}

export default () => popup({
  keymode: 'on-demand',
  anchor: ['right', 'top', 'bottom'],
  name: 'sideright',
  layer: 'overlay',
  child: Box({
    children: [

    ]
  })
});
 */
