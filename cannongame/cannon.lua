Cannon = {}

function Cannon:load()
    self.balls = {}
    self.fireChance = 60
    self.ballRadius = 25 / 2
    self.ballMinSpeed = 400
    self.ballMaxSpeed = 650

    Cannonball = {}
    Cannonball.__index = Cannonball

    function Cannonball.new(side, height, speed)
        local instance = setmetatable({}, Cannonball)

        if side == 1 then
            instance.x = 0 - Cannon.ballRadius*2
            instance.speed = speed
        elseif side == 2 then
            instance.x = MapWidth
            instance.speed = -speed
        end
        instance.y = height
        instance.toBeRemoved = false

        instance.physics = {}
        instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "kinematic")
        instance.physics.body:setFixedRotation(true)
        instance.physics.shape = love.physics.newCircleShape(Cannon.ballRadius)
        instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
        instance.physics.fixture:setSensor(true)

        function instance:beginContact()

        end

        table.insert(self.balls, instance)
    end
end


function Cannon:update(dt)
    self:selection(dt)
    self:updateBalls()
    print(#self.balls)
end


function Cannon:draw()
    love.graphics.setColor(0, 0, 0)
    for i,ball in ipairs(self.balls) do
        love.graphics.circle("fill", ball.x, ball.y, self.ballRadius)
    end
end


function Cannon:selection(dt)
    local chance = math.random(self.fireChance)

    if chance == self.fireChance then
        local side = math.random(2)
        local height = math.random(0, MapHeight - self.ballRadius*2)
        local speed = math.random(self.ballMinSpeed, self.ballMaxSpeed)

        Cannonball.new(side, height, speed)
    end
end


function Cannon:updateBalls()
    for i,ball in ipairs(self.balls) do
        ball.x, ball.y = ball.physics.body:getPosition()
        ball.physics.body:setLinearVelocity(ball.speed, 0)

        if ball.speed > 0 and ball.x > MapWidth then
            ball.toBeRemoved = true
        end
    end
end