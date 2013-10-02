require "rectangle"
require "camera"
require "hud"

Scene = {}
Scene.__index=Scene

function  Scene.new(width,height,camera_width,camera_height)
	local inst = {
			_name="Scene"
		}
	inst._size=Dimension.new(width,height)
	inst._pos=Point.new(0,0)
	inst._scale={}
	inst._scale[0]=width/camera_width
	inst._scale[1]=height/camera_height
	inst._objects={}
	inst._camera=Camera.new(0.0,0.0,camera_width,camera_height)
	inst._world={}
	inst._size=0
	inst._hud=Hud.new({width,height},{camera_width,camera_height})
	setmetatable(inst,Scene)
	return inst
end

setmetatable(Scene,{__index = Rectangle})

function Scene:initialize(  )
  love.physics.setMeter(1) --the height of a meter our worlds will be 64px
  self._world= love.physics.newWorld(0, 9.81, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
end

function Scene:draw(  )
	love.graphics.push()
	camera = self._camera

	love.graphics.translate(-camera:x()*self._scale[0],-camera:y()*self._scale[1])

	for i=0, table.getn(self._objects) do
		self._objects[i]:draw()
	end

	love.graphics.pop()
	self._hud:draw()

end

function Scene:camera( )
	return self._camera
end

function Scene:addObject( object )
	object:setScale(self._scale[0],self._scale[1])
	self._objects[self._size]=object
	self._size=self._size+1
end

function Scene:objects()
	return self._objects
end

function Scene:world(  )
	return self._world
end

function Scene:update( dt )
	self._world:update(dt)
	self._camera:update()
end

function Scene:setHud( hud )
	self._hud=hud
end

function Scene:hud(  )
	return self._hud
end