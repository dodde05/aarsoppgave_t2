local STI = require("sti")

local Level = {}

function Level:load()
    love.graphics.setBackgroundColor(0/255, 191/255, 255/255) -- Deep sky blue
    
    Map = STI("map/map.lua", {"box2d"})
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(BeginContact, EndContact)
    Map:box2d_init(World)
    self:makePlatforms()
    Map.layers.solid.visible = false
    Map.layers.platform.visible = false

    MapWidth = Map.width * Map.tilewidth
    MapHeight = Map.height * Map.tileheight
end

function Level:makePlatforms()
    self.platforms = {}
    for i,v in ipairs(Map.layers.platform.objects) do
        local instance = {}

        instance.x = v.x
        instance.y = v.y

        instance.physics = {}
        instance.physics.body = love.physics.newBody(World, v.x + v.width/2, v.y + v.height/2, "static")
        instance.physics.shape = love.physics.newRectangleShape(v.width, v.height)
        instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)

        table.insert(self.platforms, instance)
    end
end


function Level:platformCheck(fixture)
    for i,instance in ipairs(self.platforms) do
        if instance.physics.fixture == fixture then
            return true, instance
        end
    end
    return false
end


return Level