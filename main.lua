require "conf"

require "MoreLove"
require "basichud"


function initMenu()
    -- set up menu
    local menu=Menu.new({S_WIDTH,S_HEIGHT},{8.0,6.0},statemachine)
    
    -- create a menu entry 
    local mi=MenuItem.new("Start")
    -- initialize the observer structure
    mi:initRegister()
    -- create a signal
    mi:createSignal("Start")
    -- assign the signal to a specific slot
    mi:register(statemachine,statemachine.forward)
    -- add menu entry to the menu
    menu:addItem(mi)
 
    -- same for other entries
    mi=MenuItem.new("Restart")
    mi:initRegister()
    mi:createSignal("Restart")
    mi:register(nil,restart)
 
    menu:addItem(mi)
    
    mi=MenuItem.new("Exit")
    mi:initRegister()
    mi:createSignal("Exit")
    mi:register(nil,exit)
  
    menu:addItem(mi)

    -- return the menu
    return menu
end

function initScene()
    -- init scene
    local scene = Scene.new(S_WIDTH,S_HEIGHT,8.0,6.0)
    -- initialize the observer structure 
    -- and the physic world parameters
    scene:initialize()
    -- create a new dynamic object
    object=Voxel.new("dynamic",Rectangle.new(4,3,0.3,0.3),scene:world())
    -- add object to the scene
    scene:addObject(object)
    -- add some static objects
    scene:addObject(Voxel.new("static",Rectangle.new(4.2,5,0.1,0.1),scene:world()))
    scene:addObject(Voxel.new("static",Rectangle.new(0,5.9,8.0,0.5),scene:world()))
    --camera follow the dynamic object
    scene:camera():addFollow(object,30) -- the first parameter is the GObject to follow and 
                                        -- the second one is the moving avearage size for 
                                        -- more fluid movements

    --create and connect a signal
    scene:createSignal("Back") 
    scene:register("Back",statemachine,statemachine.back)

    -- set a basic hud
    scene:setHud(BasicHud.new({S_WIDTH,S_HEIGHT},{8,6}))

    return scene

end

-- SLOTS
function exit( subject )
    love.event.push("quit")   -- actually causes the app to quit
end

function restart( subject )
    second:initialize()
    statemachine:forward()
end


function love.load(  )

    -- set anti alaising for lines
    love.graphics.setLineStyle("smooth")
    -- set up state machine
    statemachine = StateMachine.new()

    -- create first state
    first= State.new(nil,nil)
    first:setupFunction(initMenu)
    first:initialize()

    -- add menu state
    statemachine:add(first,"menu")

    -- create and add main (test) scene state
    second= State.new(first,nil)
    second:setupFunction(initScene)
    second:initialize()

    statemachine:add(second,"mainscene")
    
    --set next state of menu to scene    
    first:setNext(second)

end

-- love draw event
function love.draw(  )
    statemachine:draw()
end

-- love key pressed event
function love.keypressed(key)
    statemachine:keypressed(key)
end

-- love update 
function love.update(dt)
    statemachine:update(dt)
end