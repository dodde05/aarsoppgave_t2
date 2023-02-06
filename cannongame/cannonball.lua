local Cannonball = {}
Cannonball.__index = Cannonball

function Cannonball:new(side, height, speed)
    local instance = setmetatable({}, Cannonball)

    if side == 1 then
        instance.x = 0 - self.radius*2
        instance.speed = speed
    elseif side == 2 then
        instance.x = MapWidth
        instance.speed = -speed
    end
    instance.y = height

    instance.physics = {}
    instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "kinematic")
    instance.physics.body:setFixedRotation(true)
    instance.physics.shape = love.physics.newCircleShape(self.radius)
    instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
    instance.physics.fixture:setSensor(true)

    table.insert(self.balls, instance)
end


function Cannonball:load()
    self.balls = {}
    self.fireChance = 500
    self.radius = 25 / 2
    self.diameter = self.radius * 2
    self.minSpeed = 400
    self.maxSpeed = 650
end


function Cannonball:update(dt)
    self:selection(dt)
    self:updateBalls()
    self:deleteBalls()
end


function Cannonball:draw()
    love.graphics.setColor(0, 0, 0)
    for i,instance in ipairs(self.balls) do
        love.graphics.circle("fill", instance.x, instance.y, self.radius)
    end
end


function Cannonball:selection(dt)
    if math.random(self.fireChance) == self.fireChance then
        local side = math.random(2)
        local height = math.random(0, MapHeight - self.diameter)
        local speed = math.random(self.minSpeed, self.maxSpeed)

        self:new(side, height, speed)
    end
end


function Cannonball:updateBalls()
    for i,instance in ipairs(self.balls) do
        self:updateBall(instance)
    end
end

function Cannonball:updateBall(instance)
    instance.x, instance.y = instance.physics.body:getPosition()
    instance.physics.body:setLinearVelocity(instance.speed, 0)
end


function Cannonball:deleteBalls()
    for i,instance in ipairs(self.balls) do
        if (instance.speed > 0 and instance.x > MapWidth) or (instance.speed < 0 and instance.x < 0 - self.diameter) then
            instance.physics.body:destroy()
            table.remove(self.balls, i)
        end
    end
end


function Cannonball:beginContact(a, b, collision, playerFixture)
    for i,instance in ipairs(self.balls) do
        if a == instance.physics.fixture or b == instance.physics.fixture then
            if a == playerFixture or b == playerFixture then
                -- love.event.quit()
                print("loss")
                return true
            end
        end
    end
end


return Cannonball