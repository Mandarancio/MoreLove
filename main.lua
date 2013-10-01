require "scene"
-- require "gobject"
require "voxel"
require "rectangle"
    
function love.load(  )
    love.graphics.setLineStyle("smooth")
	scene = Scene.new(1600,1200,8.0,6.0)
	scene:initialize()
    object=Voxel.new("dynamic",Rectangle.new(4,3,0.3,0.3),scene:world())
	-- test scene
	scene:addObject(object)
	scene:addObject(Voxel.new("static",Rectangle.new(4.2,5,0.1,0.1),scene:world()))
	scene:addObject(Voxel.new("static",Rectangle.new(0,5.9,8.0,0.5),scene:world()))
    --camera follow
    scene:camera():addFollow(object,1)
end

function love.draw(  )
	scene:draw()
end

function love.keypressed(key)   -- we do not need the unicode, so we can leave it out
   	if key == "escape" then
    	love.event.push("quit")   -- actually causes the app to quit
   	end
end

function love.update(dt)
	scene:update(dt)  
    if love.keyboard.isDown("up") then
    	scene:camera():move(0,-0.05)
   	end
    if love.keyboard.isDown("down") then
    	scene:camera():move(0,0.05)
    end
    if love.keyboard.isDown("right") then
    	scene:camera():move(0.05,0)
    end
    if love.keyboard.isDown("left") then
    	scene:camera():move(-0.05,0)
    end
end