local Cave, super = Class(Map)

function Cave:onEnter()
	super.onEnter(self)
	ELEVATOR_TRANSITION = nil
	if Game:getFlag("pit_unlocked", false) then
		local shape = Game.world.map:getHitbox("pit_lock")
		shape.collidable = false
		Game.world.map:getTileLayer("LockedPit").visible = false
	end
end

return Cave