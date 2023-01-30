local STI = require("sti")

require("player")
require("gui")


function love.load()
    Map = STI("map/map.lua", {"box2d"})
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(BeginContact, EndContact)
    Map:box2d_init(World)
    Map.layers.solid.visible = false
    Time = 0

    love.graphics.setBackgroundColor(0, 191 / 255, 1) -- Deep sky blue

    Player:load()
    GUI:load()
end


function love.update(dt)
    World:update(dt)
    Player:update(dt)
    GUI:update()
    UpdateTimer(dt)
end


function love.draw()
    Map:draw(0, 0, 1, 1)
    Player:draw()
    GUI:draw(Time)
end


function love.keypressed(key) -- Is called when a key is pressed
    QuitGame(key)
end


function BeginContact(a, b, collision)
    Player:beginContact(a, b, collision)
end

function EndContact(a, b, collision)
    Player:endContact(a, b, collision)
end


function UpdateTimer(dt)
    Time = Time + dt
end


function QuitGame(key)
    if key == "escape" then
        love.event.quit()
    end
end