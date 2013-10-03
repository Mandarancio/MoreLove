require "hud"

BasicHud = {}
BasicHud.__index=BasicHud

function  BasicHud.new(res,size)
	local hud = {
			_name="BasicHud",
			_resolution={res[1],res[2]},
			_size={size[1],size[2]}
		}
	setmetatable(hud,BasicHud)
	return hud
end

setmetatable(BasicHud,{__index = Hud})

function BasicHud:draw(  )
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("line",20,20,self._resolution[1]-40,self._resolution[2]-40)
end
