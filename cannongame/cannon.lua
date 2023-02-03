Cannon = {}

function Cannon:load()
    self.balls = {}
    self.fireChance = 60
    self.ballDiameter = 25
    self.ballMinSpeed = 400
    self.ballMaxSpeed = 650

    Cannonball = {}
    Cannonball.__index = Cannonball

    function Cannonball.new(side, height, speed)
        local instance = setmetatable({}, Cannonball)

        if side == 1 then
            instance.x = 0 - Cannon.ballDiameter
        elseif side == 2 then
            instance.x = MapWidth
        end
        instance.y = height
        instance.speed = speed

        instance.physics = {}
        instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "kinematic")
        instance.physics.body:setFixedRotation(true)
        instance.physics.shape = love.physics.newCircleShape(Cannon.ballDiameter / 2)
        instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)

        return instance
    end
end


function Cannon:update(dt)
    
end


function Cannon:selection()
    local chance = math.random(self.fireChance)

    if chance == self.fireChance then
        local side = math.random(2)
        local height = math.random(0, MapHeight - self.ballSize)
        local speed = math.random(self.ballMinSpeed, self.ballMaxSpeed)

        Cannonball.new(side, height, speed)
    end
end


function Cannon:draw()
    
end