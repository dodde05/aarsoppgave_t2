local STI = require("sti")

Map = {}

function Map:load()
    Map = STI("map/map.lua", {"box2d"})
    -- self:makePlatforms()
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(BeginContact, EndContact)
    Map:box2d_init(World)
    Map.layers.solid.visible = false
    Map.layers.platform.visible = false

    MapWidth = Map.width * Map.tilewidth
    MapHeight = Map.height * Map.tileheight
end

function Map:makePlatforms()
    for i,v in ipairs(Map.layers.platform.objects) do
        
    end
end