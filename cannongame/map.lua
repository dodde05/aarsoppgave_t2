local STI = require("sti")

Map = {}

function Map:load()
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

function Map:makePlatforms()
    self.platforms = {}
    for i,v in ipairs(Map.layers.platform.objects) do
        local instance = {}

        instance.body = love.physics.newBody(World, v.x + v.width/2, v.y + v.height/2, "static")
        instance.shape = love.physics.newRectangleShape(v.width, v.height)
        instance.fixture = love.physics.newFixture(instance.body, instance.shape)

        table.insert(self.platforms, instance)
    end
end