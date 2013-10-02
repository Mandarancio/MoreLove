require "scene"
require "conf"

require "voxel"

require "rectangle"
    
function love.load(  )
    -- set anti alaising for lines
    love.graphics.setLineStyle("smooth")
    -- init scene
	scene = Scene.new(S_WIDTH,S_HEIGHT,8.0,6.0)
	scene:initialize()
    -- create a new dynamic object
    object=Voxel.new("dynamic",Rectangle.new(4,3,0.3,0.3),scene:world())
	-- add objects to the scene
	scene:addObject(object)
	scene:addObject(Voxel.new("static",Rectangle.new(4.2,5,0.1,0.1),scene:world()))
	scene:addObject(Voxel.new("static",Rectangle.new(0,5.9,8.0,0.5),scene:world()))
    --camera follow
    scene:camera():addFollow(object,30)
end

-- love draw event
function love.draw(  )
	scene:draw() -- use the scene:draw method
end

-- love key pressed event
function love.keypressed(key)   -- we do not need the unicode, so we can leave it out
   	if key == "escape" then
    	love.event.push("quit")   -- actually causes the app to quit
   	end
end

-- love update 
function love.update(dt)
	scene:update(dt) -- update scene (physics and camera) 
    -- look for arrows pressed 
    -- NOTHING TO DO COUSE THE CAMERA IS FOLLOWING AN OBJECT
   
end