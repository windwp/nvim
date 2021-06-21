local animation = require('wlanimation')
local effects = require('wlanimation.effects')

local blue_colors = {
    '#90CAF9',
    '#64B5F6',
    '#42A5F5',
    '#2196F3',
    '#1E88E5',
    '#1976D2',
    '#1565C0',
    '#0D47A1',
}

local function play()
    print(Wind.state.animation)
    if Wind.state.animation==true then
        Wind.state.animation=false
        animation.stop_all()
    else
        animation.stop_all()
        Wind.state.animation=true
        animation.animation({
            data = {
                { 'waveleft1', effects.list_color(blue_colors, 6) },
                { 'waveleft2', effects.list_color(blue_colors, 5) },
                { 'waveleft3', effects.list_color(blue_colors, 4) },
                { 'waveleft4', effects.list_color(blue_colors, 3) },
                { 'waveleft5', effects.list_color(blue_colors, 2) },
            },
            -- timeout = 100,
            delay = 200,
            interval = 150,
        })

        animation.animation({
            data = {
                { 'waveright1', effects.list_color(blue_colors, 2) },
                { 'waveright2', effects.list_color(blue_colors, 3) },
                { 'waveright3', effects.list_color(blue_colors, 4) },
                { 'waveright4', effects.list_color(blue_colors, 5) },
                { 'waveright5', effects.list_color(blue_colors, 6) },
            },
            -- timeout = 100,
            delay = 200,
            interval = 150,
        })
    end
end

return {
    play = play,
}
