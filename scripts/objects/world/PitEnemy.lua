---@class PitEnemy : ChaserEnemy
---@overload fun(x: number, y: number, properties: table?) : PitEnemy
local PitEnemy, super = Class(ChaserEnemy, "PitEnemy")

function PitEnemy:init(x, y, properties)
    super.init(self, "dummy", x, y, properties)
	
	self.encounter = "battle_" .. Game:getFlag("pit_floorcount", 1)
	
	local encounter_instance = Registry.createEncounter(self.encounter)
	
	self:setActor(encounter_instance.mascot)
	
	self.sprite.aura = true
	
	if properties["aura"] == nil then
        self.sprite.aura = Game:getConfig("enemyAuras")
    else
        self.sprite.aura = properties["aura"]
    end
end

function PitEnemy:onCollide(player)
	if self:isActive() and player:includes(Player) then
		Game.world:startCutscene(function(cutscene)
			self.world.encountering_enemy = true
			self.sprite:setAnimation("hurt")
			self.sprite.aura = false
			Assets.playSound("tensionhorn")
			cutscene:wait(8/30)
			local src = Assets.playSound("tensionhorn")
			src:setPitch(1.1)
			cutscene:wait(12/30)
			self.world.encountering_enemy = false
			cutscene:startEncounter(self.encounter, true, self)
			self:remove()
			cutscene:wait(1/30)
			cutscene:wait(cutscene:walkTo(Game.world.player, "mover", 1, "up"))
			-- 240, 120
			Assets.playSound("impact")
			Game.world:spawnObject(PitFloorWarpBin(260, 120, 120, 40, {}))
		end)
	end
end

return PitEnemy
