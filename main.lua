require "scene"
require "conf"

require "voxel"

require "menu"
require "scene"

require "test"

require "state"
require "statemachine"
require "menuitem"



function initMenu()
      -- set up menu
    local menu=Menu.new({S_WIDTH,S_HEIGHT},{8.0,6.0},statemachine)
    local mi=MenuItem.new("Start")
    mi:initRegister()
    menu:addItem(mi)
    mi:register(statemachine,statemachine.forward)
    
    mi=MenuItem.new("Restart")
    mi:initRegister()
    mi:register(statemachine,statemachine.restartNext)
    menu:addItem(mi)
    
    mi=MenuItem.new("Exit")
    mi:initRegister()
    mi:register(nil,exit)
    menu:addItem(mi)

    return menu
end

function start(subject)
    statemachine:next()
end

function exit( subject )
    love.event.push("quit")   -- actually causes the app to quit
end

function restart( subject )
    second:initialize()
    statemachine:next()
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
    scene:initRegister()
    --camera follow
    scene:camera():addFollow(object,30)
    scene:register("Scene",statemachine,statemachine.back)

    return scene

end


function love.load(  )
    test = Test.new()
    print(test:toString())

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
    statemachine:draw()
end

-- love key pressed event
function love.keypressed(key)   -- we do not need the unicode, so we can leave it out

        statemachine:keypressed(key)
end

-- love update 
function love.update(dt)

    statemachine:update(dt)
end