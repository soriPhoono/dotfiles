const mpris = await Service.import('mpris')

export default () => Widget.EventBox({
  on_primary_click: () => App.ToggleWindow('player'),
  on_secondary_click: () => Utils.execAsync('playerctl play-pause').catch(console.error),

  on_scroll_up: () => Utils.execAsync('playerctl previous').catch(console.error),
  on_scroll_down: () => Utils.execAsync('playerctl next').catch(console.error),

  child: Widget.Box({
    children: mpris.bind('players').as(players => players.map(player => Widget.EventBox({
      child: Widget.Label({
        label: player.bind('track_title').as(title => title.length > 0 ? title : "nothing is playing")
      })
    })))
  })
})
