dofile("requirements.lua")
local window_x, window_y = 320, 480

MOAISim.openWindow("whyday", window_x, window_y)

viewport = MOAIViewport.new()
viewport:setSize(window_x, window_y)
viewport:setScale(window_x, window_y)

layer = MOAILayer2D.new()
layer:setViewport(viewport)
MOAISim.pushRenderPass(layer)

gfxQuad = MOAIGfxQuad2D.new()
gfxQuad:setTexture("assets/moai.png")
gfxQuad:setRect(-64, -64, 64, 64)

prop = MOAIProp2D.new()
prop:setDeck(gfxQuad)
prop:setLoc(0, 80)
layer:insertProp(prop)

font = MOAIFont.new()
font:loadFromTTF("assets/arialbd.ttf", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.?!", 12, 163)

textbox = MOAITextBox.new()
local textbox_x, textbox_y = 160, 20
textbox:setFont(font)
textbox:setRect(0, 0, textbox_x, textbox_y)
textbox:setLoc(-textbox_x, (window_y - textbox_y * 2) / 2)
textbox:setYFlip(true)
textbox:setTextSize(12)
textbox:setAlignment(MOAITextBox.LEFT_JUSTIFY)
layer:insertProp(textbox)


local fps = 0

--==============================================================
-- game loop
--==============================================================

local game_loop = function()
  local frames = 0
  local game_over = false
  while not game_over do
    -- show FPS
    frames = frames + 1
    fps = frames / MOAISim.getElapsedTime()
    textbox:setString("<c:0F0>" .. math.round(fps) .. "<c>" )

    coroutine.yield()
  end
end

main_thread = MOAICoroutine.new()
main_thread:run(game_loop)
