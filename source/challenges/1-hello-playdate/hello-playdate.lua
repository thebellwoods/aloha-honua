-- Name this file `main.lua`. Your game can use multiple source files if you wish
-- (use the `import "myFilename"` command), but the simplest games can be written
-- with just `main.lua`.

-- You'll want to import these in just about every project you'll work on.

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

--- common practice to create a class for each module so that you can use this code base from you main.lua
HelloPlaydate = {
	isRunning = false,
	assets = "challenges/1-hello-playdate/assets/", -- relative path seems to be difficult so that you create the path from the source 
	A = playdate.kButtonA,
	B = playdate.kButtonB,
	UP = playdate.kButtonUp,
	DOWN = playdate.kButtonDown,
	LEFT = playdate.kButtonLeft,
	RIGHT = playdate.kButtonRight
}



-- Declaring this "gfx" shorthand will make your life easier. Instead of having
-- to preface all graphics calls with "playdate.graphics", just use "gfx."
-- Performance will be slightly enhanced, too.
-- NOTE: Because it's local, you'll have to do it in every .lua source file.

local gfx <const> = playdate.graphics

-- Here's our player sprite declaration. We'll scope it to this file because
-- several functions need to access it.

local playerSprite = nil
local screenHeight = 240
local screenCentre = screenHeight / 2
local playerSpriteStartY = 80
local playerSpriteMaxY = playerSpriteStartY * 3 -- hardcode to 3 options for now 
local playerSpriteY = playerSpriteStartY -- the player sprite starts on the same y position as the first menu item 
local menuOptionHeight = 40



local menuOptions = {
	{
		y = 80,
		option = "option a",
		height=  menuOptionHeight
	},
	{
	   y = 80 + menuOptionHeight,
	   option =  "option b",
	   height = menuOptionHeight
	},
	{
	   y = 80 + menuOptionHeight * 2,
	   option = "option c",
	   height = menuOptionHeight
	},
}

-- A function to set up our game environment.

function HelloPlaydate.myGameSetUp()


	local playerImage = gfx.image.new(HelloPlaydate.assets .. "wanda")
	assert( playerImage ) -- make sure the image was where we thought

	playerSprite = gfx.sprite.new( playerImage )
	playerSprite:moveTo( 200, playerSpriteStartY ) -- this is where the center of the sprite is placed; (200,120) is the center of the Playdate screen
	playerSprite:add() -- This is critical!

	-- We want an environment displayed behind our sprite.
	-- There are generally two ways to do this:
	-- 1) Use setBackgroundDrawingCallback() to draw a background image. (This is what we're doing below.)
	-- 2) Use a tilemap, assign it to a sprite with sprite:setTilemap(tilemap),
	--       and call :setZIndex() with some low number so the background stays behind
	--       your other sprites.

	local backgroundImage = gfx.image.new(HelloPlaydate.assets .. "background")
	assert( backgroundImage )

	gfx.sprite.setBackgroundDrawingCallback(
		function( x, y, width, height )
			-- x,y,width,height is the updated area in sprite-local coordinates
			-- The clip rect is already set to this area, so we don't need to set it ourselves
			backgroundImage:draw( 0, 0 )
		end
	)

end

-- Now we'll call the function above to configure our game.
-- After this runs (it just runs once), nearly everything will be
-- controlled by the OS calling `playdate.update()` 30 times a second.


-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.
	
 	
local function getSpritePostion()
	
	for i, obj in ipairs(menuOptions) do
		-- which menu item is the player beside?
		local menuOptionYMin = obj.y
		local menuOptionYMax = menuOptionYMin + menuOptionHeight
		
		if playerSpriteY >= menuOptionYMin and playerSpriteY <  menuOptionYMax then 
			print('listing to sprite update y', obj.option)
		end
	end
	
	print('listing to sprite update y', "" .. playerSpriteY)

end

local function resetPlayerSprite()
	playerSpriteY = playerSpriteStartY
	playerSprite:moveTo( 200, playerSpriteStartY )
end 	

local function reset()
	resetPlayerSprite()
end	


local function helloPlaydateUpate()
	-- Poll the d-pad and move our player accordingly.
	-- (There are multiple ways to read the d-pad; this is the simplest.)
	-- Note that it is possible for more than one of these directions
	-- to be pressed at once, if the user is pressing diagonally.
	
	-- we only need up and down for this challenge
	
	-- UP
	if playdate.buttonIsPressed( HelloPlaydate.UP ) then
		playerSprite:moveBy( 0, -menuOptionHeight )
		
		if playerSpriteY > playerSpriteStartY then
			playerSpriteY = playerSpriteY - menuOptionHeight
		else 
			playerSpriteY = playerSpriteStartY
		end	
		
	end
	
	-- RIGHT
	--[[
	if playdate.buttonIsPressed( playdate.kButtonRight ) then
		playerSprite:moveBy( 2, 0 )
	end]]
	
	-- DOWN
	if playdate.buttonIsPressed( HelloPlaydate.DOWN ) then
		playerSprite:moveBy( 0, menuOptionHeight )
		
		if playerSpriteY < playerSpriteMaxY then
			playerSpriteY = playerSpriteY + menuOptionHeight
		else
			playerSpriteY = playerSpriteStartY
		end
			 
	end
	
	-- LEFT
	--[[
	if playdate.buttonIsPressed( playdate.kButtonLeft ) then
		playerSprite:moveBy( -2, 0 )
	end]]
	
	-- Call the functions below in playdate.update() to draw sprites and keep
	-- timers updated. (We aren't using timers in this example, but in most
	-- average-complexity games, you will.)
	
	-- we can use B to reset 
	if playdate.buttonIsPressed( HelloPlaydate.B ) then
		reset()
	end	
	
	gfx.sprite.update()
	playdate.timer.updateTimers()
	
	getSpritePostion()
	
end


function playdate.update()
	if HelloPlaydate.isRunning then
		helloPlaydateUpate()
	end 
end