require "scene"
require "conf"
require "connector"
require "voxel"
-- require "basichud"
require "rectangle"
require "menu"
require "state"
require "statemachine"

function test( )
    print("ciao")
end
function a( )
    -- body
end

    
function love.load(  )

    -- set anti alaising for lines
    love.graphics.setLineStyle("smooth")
    -- set up state machine
    statemachine = StateMachine.new()

    -- set up menu
    menu=Menu.new({S_WIDTH,S_HEIGHT},{8.0,6.0})
    menu:addItem("Start!")
    menu:addItem("Stop!")
    -- create state
    first= State.new(nil,menu)

    statemachine:add(first)
    statemachine:setCurrentState(first)

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

    second= State.new(first,scene)
    first:setNext(second)

    statemachine:add(second)


    -- set a basic hud
    -- scene:setHud(BasicHud.new({S_WIDTH,S_HEIGHT},{8,6}))

end

-- love draw event
function love.draw(  )
    statemachine:currentState():scene():draw()
end

-- love key pressed event
function love.keypressed(key)   -- we do not need the unicode, so we can leave it out
   	if key == "escape" then
        statemachine:back()
   	end
end

-- love update 
function love.update(dt)

    statemachine:currentState():scene():update(dt)
end