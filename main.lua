require "scene"
require "conf"

require "voxel"

require "menu"
require "scene"

require "state"
require "statemachine"

function initMenu()
      -- set up menu
    local menu=Menu.new({S_WIDTH,S_HEIGHT},{8.0,6.0},statemachine)
    menu:addItem("Start!")
    menu:addItem("Stop!")
    return menu
end

function initScene(  )
    -- init scene
    local scene = Scene.new(S_WIDTH,S_HEIGHT,8.0,6.0)
    scene:initialize()
    -- create a new dynamic object
    object=Voxel.new("dynamic",Rectangle.new(4,3,0.3,0.3),scene:world())
    -- add objects to the scene
    scene:addObject(object)
    scene:addObject(Voxel.new("static",Rectangle.new(4.2,5,0.1,0.1),scene:world()))
    scene:addObject(Voxel.new("static",Rectangle.new(0,5.9,8.0,0.5),scene:world()))
    --camera follow
    scene:camera():addFollow(object,30)

    return scene

end


function love.load(  )

    -- set anti alaising for lines
    love.graphics.setLineStyle("smooth")
    -- set up state machine
    statemachine = StateMachine.new()

  
    -- create state
    first= State.new(nil,nil)
    first:setupFunction(initMenu)
    first:initialize()


    statemachine:add(first)
    statemachine:setCurrentState(first)

    
    second= State.new(first,nil)
    second:setupFunction(initScene)
    second:initialize()

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
    else
        statemachine:currentState():scene():keyPressed(key) 
    end
end

-- love update 
function love.update(dt)

    statemachine:currentState():scene():update(dt)
end