local blips = {}

InsertBlip = function(title, colour, id, scale, coords, shortRange)
    table.insert(blips, {
        title = tostring(title),
        colour = tonumber(colour),
        id = tonumber(id),
        scale = tonumber(scale),
        coords = coords,
        shortRange = shortRange
    })
end

CreateThread(function()
    if Config.EnableCustomFont then
        RegisterFontFile('firesans')
        RegisterFontId('Fire Sans')
    end
    for k, v in pairs(Config.Blips) do
        InsertBlip(v.title, v.colour, v.id, v.scale, v.coords, v.shortRange)
    end
    for k, v in pairs(blips) do
        local c = v.coords
        local blip = AddBlipForCoord(c.x, c.y, c.z)
        SetBlipSprite(blip, v.id)
        SetBlipColour(blip, v.colour)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.scale)
        SetBlipAsShortRange(blip, v.shortRange)
        BeginTextCommandSetBlipName("STRING")
        if Config.EnableCustomFont then
            AddTextComponentString('<font face="Fire Sans">' .. v.title .. '</font>')
        else
            AddTextComponentString(v.title)
        end
        EndTextCommandSetBlipName(blip)
        v.blip = blip
    end
end)

exports('CreateBlip', function(title, colour, id, scale, coords, shortRange)
    InsertBlip(title, colour, id, scale, coords, shortRange)
end)

exports('GetBlips', function()
    return blips
end)