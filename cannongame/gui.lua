GUI = {}

function GUI:load()

end


function GUI:update()

end


function GUI:draw(Time)
    love.graphics.setColor(255/255, 64/255, 0/255)
    love.graphics.print("Time: " .. Time, 20, 20)
end