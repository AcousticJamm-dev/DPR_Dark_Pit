function Mod:init()
    Game:registerEvent("pit_enemy", function(data)
        return PitEnemy(data.x, data.y, data.properties)
    end)
    Game:registerEvent("nextfloor", function(data)
        return PitFloorWarpBin(data.x, data.y, data.width, data.height, data.properties)
    end)
    print("Loaded "..self.info.name.."!")
end
