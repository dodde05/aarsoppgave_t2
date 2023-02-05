Player = {}

function Player:load()
    self.width = 20
    self.height = 20
    self.x = 400
    self.y = 400
    self.xVel = 0
    self.yVel = 0
    self.maxSpeed = 400
    self.acceleration = 3700
    self.friction = 3500
    self.grounded = false
    self.gravity = 3600
    self.jumpForce = 1000

    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
end


function Player:update(dt)
    self:syncPhysics()
    self:jump()
    self:movement(dt)
    self:applyGravity(dt)
end


function Player:draw()
    love.graphics.setColor(255/255, 255/255, 0/255)
    love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
end


function Player:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.xVel, self.yVel)
end


function Player:movement(dt)
    local leftInput = love.keyboard.isDown("a", "left")
    local rightInput = love.keyboard.isDown("d", "right")

    if (not leftInput and not rightInput) or (leftInput and rightInput) then
        self.xVel = 0 -- Function applyFriction can be called here alternatively
    else
        if leftInput then -- If left input is pressed
            self.xVel = -self.maxSpeed
            -- if self.xVel > -self.maxSpeed then -- If x velocity is below max speed
            --     if self.xVel - self.acceleration * dt > -self.maxSpeed then -- If x velocity still is below max speed after acceleration
            --         self.xVel = self.xVel - self.acceleration * dt
            --     else
            --         self.xVel = -self.maxSpeed
            --     end
            -- end
        end
        if rightInput then
            self.xVel = self.maxSpeed
            -- if self.xVel < self.maxSpeed then -- If x velocity is below max speed
            --     if self.xVel + self.acceleration * dt < self.maxSpeed then -- If x velocity still is below max speed after acceleration
            --         self.xVel = self.xVel + self.acceleration * dt
            --     else
            --         self.xVel = self.maxSpeed
            --     end
            -- end
        end
    end
    
end


function Player:applyFriction(dt)
    if self.xVel > 0 then
        if self.xVel - self.friction * dt > 0 then
            self.xVel = self.xVel - self.friction * dt
        else
            self.xVel = 0
        end
    elseif self.xVel < 0 then
        if self.xVel + self.friction * dt < 0 then
            self.xVel = self.xVel + self.friction * dt
        else
            self.xVel = 0
        end
    end
end


function Player:applyGravity(dt)
    if not self.grounded then
        self.yVel = self.yVel + self.gravity * dt
    end
end


function Player:jump()
    if love.keyboard.isDown("space") and self.grounded then
        self.yVel = -self.jumpForce
    end
end


function Player:beginContact(a, b, collision)
    local nx, ny = collision:getNormal()

    -- self:platformCollision(a, b, collision, nx, ny)
    self:groundCollision(a, b, collision, nx, ny)
    self:topCollision(a, b, nx, ny)
end

function Player:endContact(a, b, collision)
    if a == self.physics.fixture or b == self.physics.fixture then
        if self.currentGroundCollision == collision then
            self.grounded = false
        end
    end
end


function Player:platformCollision(a, b, collision, nx, ny)
    
end


function Player:groundCollision(a, b, collision, nx, ny)
    if self.grounded then return end

    if a == self.physics.fixture then
        if ny > 0 then
            self:land(collision)
        end
    elseif b == self.physics.fixture then
        if ny < 0 then
            self:land(collision)
        end
    end
end

function Player:land(collision)
    self.currentGroundCollision = collision
    self.grounded = true
    self.yVel = 0
end


function Player:topCollision(a, b, nx, ny)
    if a == self.physics.fixture then
        if ny < 0 then
            self.yVel = 0
        end
    elseif b == self.physics.fixture then
        if ny > 0 then
            self.yVel = 0
        end
    end
end