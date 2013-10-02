require "class"

Hud = {}
Hud.__index=Hud

function  Hud.new(res,size)
	local hud = {
			_name="Hud",
			_resolution={res[1],res[2]},
			_size={size[1],size[2]}
		}
	setmetatable(hud,Hud)
	return hud
end

setmetatable(Hud,{__index = Class})

function Hud:draw(  )
	-- extend this class to draw something here!
end
