local blips = {}

InsertBlip = function(title, colour, id, scale, coords, shortRange)
    local c = coords
    if not c then
        return
    end

    title = tostring(title)
    colour = tonumber(colour)
    id = tonumber(id)
    scale = tonumber(scale)
    shortRange = shortRange

    local blip = AddBlipForCoord(c.x, c.y, c.z)
    SetBlipSprite(blip, id)
    SetBlipColour(blip, colour)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, shortRange)

    BeginTextCommandSetBlipName("STRING")
    if Config.EnableCustomFont then
        AddTextComponentString('<font face="Fire Sans">' .. title .. '</font>')
    else
        AddTextComponentString(title)
    end
    EndTextCommandSetBlipName(blip)

    table.insert(blips, {
        title = title,
        colour = colour,
        id = id,
        scale = scale,
        coords = coords,
        shortRange = shortRange,
        blip = blip
    })

    return blip
end

CreateThread(function()
    if Config.EnableCustomFont then
        RegisterFontFile('firesans')
        RegisterFontId('Fire Sans')
    end
    for k, v in pairs(Config.Blips) do
        InsertBlip(v.title, v.colour, v.id, v.scale, v.coords, v.shortRange)
    end
end)

exports('CreateBlip', function(title, colour, id, scale, coords, shortRange)
    return InsertBlip(title, colour, id, scale, coords, shortRange)
end)

exports('GetBlips', function()
    return blips
end)
