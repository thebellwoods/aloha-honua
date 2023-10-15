import "CoreLibs/graphics"
import "CoreLibs/sprites"

-- performance shortcut
local gfx = playdate.graphics

-- let's set up a "game sprite" to put in the background
local s = gfx.sprite.new()
s:setImage(gfx.image.new("leaf"))
s:setZIndex(100)
s:moveTo(100,100)
s:add()

-- now let's put together the textbox sprite

textbox = gfx.sprite.new()
textbox:setSize(220, 180)
textbox:moveTo(200, 120)
textbox:setZIndex(900)
textbox.text = "" -- this is blank for now; we can set it at any point
textbox.currentChar = 1 -- we'll use these for the animation
textbox.currentText = ""
textbox.typing = true


-- this function will calculate the string to be used. 
-- it won't actually draw it; the following draw() function will.
function textbox:update()
	
	self.currentChar = self.currentChar + 1
	if self.currentChar > #self.text then
		self.currentChar = #self.text
	end
	
	if self.typing and self.currentChar <= #self.text then
		textbox.currentText = string.sub(self.text, 1, self.currentChar)		
		self:markDirty() -- this tells the sprite that it needs to redraw
	end
	
	-- end typing
	if self.currentChar == #self.text then
		self.currentChar = 1
		self.typing = false		
	end	
end

-- this function defines how this sprite is drawn
function textbox:draw()
	
	-- pushing context means, limit all the drawing config to JUST this block
	-- that way, the colors we set etc. won't be stuck
	gfx.pushContext()
	
		-- draw the box				
		gfx.setColor(gfx.kColorWhite)
		gfx.fillRect(0,0,220,180)
		
		-- border
		gfx.setLineWidth(4)
		gfx.setColor(gfx.kColorBlack)
		gfx.drawRect(0,0,220,180)
		
		-- draw the text!
		gfx.drawTextInRect(self.currentText, 10, 10, 200, 160)
		print("drawing")
	
	gfx.popContext()
	
end

-- note that we're NOT add()-ing the textbox yet, because we don't want it visible from the start

-- To see the textbox in action, we'll make the text animate in when A is pressed
function playdate.AButtonUp()
	textbox.text = "Hello from the text sprite!"
	textbox:add()
end


function playdate.update()

	gfx.sprite.update()
	
end