local STI = require("sti")
local mapFile = require("map.map")

require("time")
require("player")
require("cannonball")


function love.load()
    Map = STI("map/map.lua", {"box2d"})
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(BeginContact, EndContact)
    Map:box2d_init(World)
    Map.layers.solid.visible = false
    MapWidth = mapFile.layers[2].objects[1].width
    MapHeight = mapFile.layers[2].objects[2].height

    love.graphics.setBackgroundColor(0/255, 191/255, 255/255) -- Deep sky blue

    Time:load()
    Player:load()
    Cannonball:load()
end


function love.update(dt)
    World:update(dt)
    Time:update(dt)
    Player:update(dt)
    Cannonball:update(dt)
end


function love.draw()
    love.graphics.setColor(1, 1, 1)
    Map:draw(0, 0, 1, 1)
    Time:draw()
    Player:draw()
    Cannonball:draw()
end


function love.keypressed(key) -- Is called when a key is pressed
    QuitGame(key)
end


function BeginContact(a, b, collision)
    Cannonball:beginContact(a, b, collision)
    Player:beginContact(a, b, collision)
end

function EndContact(a, b, collision)
    Player:endContact(a, b, collision)
end


function QuitGame(key)
    if key == "escape" then
        love.event.quit()
    end
end