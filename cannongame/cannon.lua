Cannon = {}

function Cannon:load()
    self.balls = {}

    Cannonball = {}
    Cannonball.__index = Cannonball

    function Cannonball.new(side, x, y)
        local instance = setmetatable({}, Cannonball)

        instance.x = x
        instance.y = y
    end
end


function Cannon:update(dt)
    self.fireChance = math.random(0, )
end


function Cannon:draw()
    
end