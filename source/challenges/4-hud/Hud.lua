--[[
-- CoreLibs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "challenges/4-effects/Score"

TAGS = {
    Score = 1,
}

Z_INDEXES = {
    Score = 2,
}


class('Hud').extends()

local pd <const> = playdate
local gfx <const> = playdate.graphics
local targetX, targetY = 170, 240 / 2

local currentX = 40
local currentY = 220

local currentScoreX = 40
local currentScoreY = 210
local scoreHeight = 60

local hudState = {
    score = 0,
    health = 100,
    quest = 25.0
}

function Hud:init()

end


function Hud:onUpdate()
  
end



function Hud:reset()
    
end

function Hud:update()
    if pd.buttonJustReleased( pd.kButtonB ) then
		self:reset()
	end	
    self:onUpdate()
end

--]]