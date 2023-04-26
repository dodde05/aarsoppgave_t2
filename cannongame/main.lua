local Level = require("level")
local Time = require("time")
local Player = require("player")
local Cannonball = require("cannonball")
local End = require("end")


function love.load()
    math.randomseed(os.time())
    
    End:load()
    Level:load()
    Time:load()
    Player:load()
    Cannonball:load()
end


function love.update(dt)
    if End.gameOver then
        End:uploadScore(Time.timer)
        love.event.quit()
    end

    World:update(dt)
    Time:update(dt)
    Player:update(dt)
    Cannonball:update(dt)
end


function love.draw()
    love.graphics.setColor(1, 1, 1)
    Map:draw(0, 0, 1, 1)
    Time:draw(Cannonball.difficulty)
    Player:draw()
    Cannonball:draw()
end


function love.keypressed(key) -- Is called when a key is pressed
    QuitGame(key)
end


function BeginContact(a, b, collision)
    if Cannonball:beginContact(a, b, collision, Player.physics.fixture) then
        End.gameOver = true
        return
    end

    Player:beginContact(a, b, collision, Level)
end

function EndContact(a, b, collision)
    if Cannonball:endContact(a, b) then return end
    Player:endContact(a, b, collision)
end


function QuitGame(key)
    if key == "escape" then
        love.event.quit()
    end
end