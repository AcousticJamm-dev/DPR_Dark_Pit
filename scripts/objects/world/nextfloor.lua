---@class PitFloorWarpBin : Event
---@overload fun(x: number, y: number) : PitFloorWarpBin
---@overload fun(x: number, y: number, width: number, height: number) : PitFloorWarpBin
---@overload fun(x: number, y: number, width: number, height: number, properties: table) : PitFloorWarpBin
local WarpBin, super = Class(Event, "PitFloorWarpBin")

function WarpBin:init(x, y, width, height, properties)
    super.init(self, x, y, width or 120, height or 40)

    self.solid = true

    self.properties = properties or {}

    if self.properties["skin"] then
        self.sprite_b = Sprite("world/events/warpbin/".. self.properties["skin"])
    else
        self.sprite_b = Sprite("world/events/warpbin/cyber_city")
    end

    self.sprite_b:setScale(2)
    self.sprite_b.debug_select = false

    self.sprite_b.y = -50
    self:addChild(self.sprite_b)


    --TO-DO: find a way to make these sprites customizable.

    self.sprite_a = Sprite("world/events/warpbin/warp_bin")
    self.sprite_a:setScale(2)
    self.sprite_a.debug_select = false

    self.sprite_a:play(1/6, true)

    --self.sprite_a.x = -1
    self.sprite_a.y = -50
    self:addChild(self.sprite_a)
end

function WarpBin:onInteract()
    Game.world:startCutscene(function(cs)
		Game:addFlag("pit_floorcount", 1)
		if Game:getFlag("pit_floorcount", 1) % 10 ~= 0 then
			cs:mapTransition("area_"..math.ceil(Game:getFlag("pit_floorcount")/10))
		else
			cs:mapTransition("boss_"..Game:getFlag("pit_floorcount")/10)
		end
	end)
end


function WarpBin:draw()
    --Draw.scissor(self.sprite_frame.x, self.sprite_frame.y, self.sprite_frame.width*2-20, self.sprite_frame.height*2)
    super.draw(self)
    --love.graphics.setScissor()
    --love.graphics.draw(Assets.getTexture("world/events/WarpBin/floor1/frame"), 15, -65, 0, 2, 2)
end

return WarpBin
