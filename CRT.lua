if #app.sprites < 1 then
    return app.alert "You should have at least one sprite opened"
end
local sprite = app.activeSprite
local bounds = sprite.bounds

local color1 = 0
local color2 = 0

local function getTitle(filename) return filename:match("^.+/(.+)$") end

local cel
local newSprite = Sprite(bounds.width, bounds.height)
local firstLayer = newSprite.layers[1]
newSprite:deleteCel(newSprite.cels[1])

newSprite:newEmptyFrame()
local newLayer = newSprite:newLayer()
newLayer.name = getTitle(sprite.filename)
cel = newSprite:newCel(newLayer, frame)
cel.image:drawSprite(sprite, frame)

newSprite:deleteLayer(firstLayer)
newSprite:resize(bounds.width * 3, bounds.height)
for i = 0, bounds.width * 3 do
    for j = 0, bounds.height do
        local pixelValue = cel.image:getPixel(i, j)
        if i % 3 == 0 then
            cel.image:drawPixel(i, j, pixelValue & 0xFF0000FF)
        elseif i % 3 == 1 then
            cel.image:drawPixel(i, j, pixelValue & 0xFF00FF00)
        else
            cel.image:drawPixel(i, j, pixelValue & 0xFFFF0000)
        end
    end
end
-- local pixelValue = cel.image:getPixel(162, 19)
newSprite:resize(bounds.width * 3, bounds.height * 3)

local LineLayer = newSprite:newLayer()
LineLayer.name = "Line"
cel = newSprite:newCel(LineLayer, 1)
for i = 0, bounds.width * 3 do
    for j = 2, bounds.height * 3, 3 do cel.image:drawPixel(i, j, 0x6E000000) end
end

app.activeFrame = 1

