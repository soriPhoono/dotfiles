const applications = await Service.import("applications")
const WINDOW_NAME = "applauncher"

/** @param {import('resource:///com/github/Aylur/ags/service/applications.js').Application} app */
const AppItem = app => Widget.Button({
  on_clicked: () => {
    App.closeWindow(WINDOW_NAME)
    app.launch()
  },
  attribute: { app },
  child: Widget.Box({
    children: [
      Widget.Icon({
        icon: app.icon_name || "",
        size: 42,
      }),
      Widget.Label({
        class_name: "title",
        label: app.name,
        xalign: 0,
        vpack: "center",
        truncate: "end",
      }),
    ],
  }),
})

const Applauncher = ({ width = 500, height = 500, spacing = 12 }) => {
  // list of application buttons
  let apps = applications.query("").map(AppItem)

  return Widget.Box({
    css: `margin: ${spacing * 2}px;`,

    /*     attribute: {
          apps: applications.query(""),
        }, */

    vertical: true,

    setup: self => {
      const entry = Widget.Entry({
        hexpand: true,
        css: `margin-bottom: ${spacing}px;`,

        // to launch the first item on Enter
        on_accept: () => {
          // make sure we only consider visible (searched for) applications
          const results = apps.filter((item) => item.visible);
          if (results[0]) {
            App.toggleWindow(WINDOW_NAME)
            results[0].attribute.app.launch()
          }
        },

        // filter out the list
        on_change: ({ text }) => apps.forEach(item => {
          item.visible = item.attribute.app.match(text ?? "")
        }),
      })

      self.children = [
        entry,

        Widget.Scrollable({
          hscroll: "never",
          css: `min-width: ${width}px;`
            + `min-height: ${height}px;`,
          child: Widget.Box({
            vertical: true,
            children: apps,
            spacing,
          }),
        }),
      ]

      self.hook(App, (_, windowName, visible) => {
        if (windowName !== WINDOW_NAME)
          return

        // when the applauncher shows up
        if (visible) {
          entry.text = ""
          entry.grab_focus()
        }
      })
    }
  })
}

// there needs to be only one instance
export const applauncher = Widget.Window({
  name: WINDOW_NAME,
  setup: self => self.keybind("Escape", () => {
    App.closeWindow(WINDOW_NAME)
  }),
  visible: true,
  keymode: "exclusive",
  child: Applauncher({
    width: 500,
    height: 500,
    spacing: 12,
  }),
})
