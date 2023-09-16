-- CoreLibs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "challenges/6-effects/Lightening"
import "challenges/6-effects/Player"

TAGS = {
  Player = 1,
  Lightening = 2,
  background = 3
}

Z_INDEXES = {
    Player = 2,
    Lightening = 3,
    background = 1,
}


class('Effects').extends()

local pd <const> = playdate
local gfx <const> = playdate.graphics
local targetX, targetY = 170, 240 / 2
local playerSprite = nil

local currentX = 40
local currentY = 220

local currentOrlaX = 40
local currentOrlaY = 210
local orlaHeight = 60

local effectsState = {
    hasLighteningAppeared = false,
}

function Effects:init()
    -- self:addLightening()


	local playerImage = gfx.image.new("challenges/6-effects/assets/images/wanda_dark")
	assert( playerImage ) -- make sure the image was where we thought
	
	playerSprite = gfx.sprite.new( playerImage )
	playerSprite:moveTo(currentX, currentY )
	playerSprite:add() 

    self.player = Player(currentOrlaX, currentOrlaY, self)

    -- Call the animation function to start the animation
    -- animateSpriteToCenter()

    local backgroundImage = gfx.image.new("challenges/6-effects/assets/images/background")
	assert( backgroundImage )

    gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
            -- x,y,width,height is the updated area in sprite-local coordinates
            -- The clip rect is already set to this area, so we don't need to set it ourselves
            backgroundImage:draw( 0, 0 )
        end
    )
end


function Effects:addLightening()
   -- self.lighening = Lightening(200, 120, self)
   -- self.lighening:playAnimation()
end

function Effects:lighteningStrike()
    -- I don't want to keep adding it to the scene
    if not effectsState.hasLighteningAppeared then
        self.lighening = Lightening(200, 120, self)
        self.lighening:changeState("strike")
        effectsState.hasLighteningAppeared = true
    end
   
    -- self.lighening:playAnimation()
 end




function Effects:checkSpritePosition()
   -- print("checking...")

    local function onSpriteReachedTarget()
       -- the lighening should manage its own state and only play if it hasn't played yet
        self:lighteningStrike()
    end


    local spriteX, spriteY = playerSprite:getPosition()

    -- print("Sprite spriteX: ", spriteX)
    -- print("Sprite targetX: ", targetX)

    if spriteX >= targetX then
        onSpriteReachedTarget()
    else
        local newCurrentX = currentX + 1
        playerSprite:moveTo(newCurrentX, currentY, 10, onSpriteReachedCenter)
        currentX = newCurrentX
    end
end

local function reset()
    currentX = 40
    currentY = 220
    playerSprite:moveTo(currentX, currentY )
    playOnce = true
end

function Effects:update()
    if pd.buttonJustReleased( pd.kButtonB ) then
		self:reset()
	end	
    self:checkSpritePosition()
end




