
local animation = require('wlanimation')
local efffects = require('wlanimation.effects')

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
    if Wind.state.animation==true then
        Wind.state.animation=false
        animation.stop_all()
    else
        animation.stop_all()
        Wind.state.animation=true
        animation.animation({
            data = {
                { 'waveleft1', efffects.list_color(blue_colors, 6) },
                { 'waveleft2', efffects.list_color(blue_colors, 5) },
                { 'waveleft3', efffects.list_color(blue_colors, 4) },
                { 'waveleft4', efffects.list_color(blue_colors, 3) },
                { 'waveleft5', efffects.list_color(blue_colors, 2) },
            },
            -- timeout = 100,
            delay = 200,
            interval = 150,
        })

        animation.animation({
            data = {
                { 'waveright1', efffects.list_color(blue_colors, 2) },
                { 'waveright2', efffects.list_color(blue_colors, 3) },
                { 'waveright3', efffects.list_color(blue_colors, 4) },
                { 'waveright4', efffects.list_color(blue_colors, 5) },
                { 'waveright5', efffects.list_color(blue_colors, 6) },
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
