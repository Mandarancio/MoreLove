require "gobject"
require "rectangle"

Voxel = {}
Voxel.__index=Voxel

function  Voxel.new(type,bounds,world)
	local inst = {
			_name="Voxel"
		}
	inst._bounds=Rectangle.new(bounds:x(),bounds:y(),bounds:width(),bounds:height())
	inst._visible=true
	inst._scale={}
	inst._scale[0]=1.0
	inst._scale[1]=1.0
	inst._body=love.physics.newBody(world,bounds:x()+bounds:width()/2,bounds:y()+bounds:height()/2, type) --place the body in the center of the world and make it dynamic, so it can move around
 	inst._shape = love.physics.newRectangleShape(bounds:width(),bounds:height()) --the ball's shape has a radius of 20
  	inst._fixture = love.physics.newFixture(inst._body, inst._shape, 1) -- Attach fixture to body and give it a density of 1.
  	inst._fixture:setRestitution(0.4) --let the ball bounce
	setmetatable(inst,Voxel)
	return inst
end

setmetatable(Voxel,{__index = GObject})

function Voxel:bounds( )
	points = {self._fixture:getBoundingBox()}
	return Rectangle.new(points[1],points[2],(points[3]-points[1]),(points[4]-points[2]))
end

function Voxel:drawObject(  )
  	love.graphics.setColor(150, 150, 150) -- set the drawing color to grey for the blocks
  	points = {self._body:getWorldPoints(self._shape:getPoints())}
	for i=1, table.getn(points) do
		points[i]=points[i]*self._scale[(i-1)%2]
	end

  	love.graphics.polygon("fill",points)
  	love.graphics.polygon("line",points)

end

