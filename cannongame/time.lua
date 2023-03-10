local Time = {}

function Time:load()
    self.timer = 0
end


function Time:update(dt)
    self.timer = self.timer + dt
end


function Time:draw(difficulty)
    love.graphics.setColor(255/255, 64/255, 0/255)
    love.graphics.print("Time: " .. self.timer, 20, 20)
    love.graphics.print("Difficulty: " .. difficulty, 20, 40)
end


return Time