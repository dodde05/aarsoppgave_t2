local Level = require("level")
local Time = require("time")
local Player = require("player")
local Cannonball = require("cannonball")


function love.load()
    love.graphics.setBackgroundColor(0/255, 191/255, 255/255) -- Deep sky blue
    Level:load()
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
    -- Player:jump(key)
end


function BeginContact(a, b, collision)
    if Cannonball:beginContact(a, b, collision, Player.physics.fixture) then return end
    Player:beginContact(a, b, collision, Level)
end

function EndContact(a, b, collision)
    Player:endContact(a, b, collision)
end


function QuitGame(key)
    if key == "escape" then
        love.event.quit()
    end
end