-- Challenge 7 should build on the previous challenges
--[[
Goals 

This file should be no longer than 100 lines of code with a focus on importing code from other files.

]]

-- IMPORTS

-- CoreLibs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "challenges/6-effects/Lightening"
import "challenges/6-effects/Player"
import "challenges/7-levels/libraries/LDtk"

local ldtk <const> = LDtk

-- world
import "challenges/7-levels/World"

-- actors
import "challenges/7-levels/Actor"
import "challenges/7-levels/actors/hero/HeroModel"
import "challenges/7-levels/actors/hero/HeroSprite"

import "challenges/7-levels/Monster"

-- util 
import "challenges/7-levels/Util"

local pd <const> = playdate
local gfx <const> = playdate.graphics


TAGS = {
    HeroSprite = 1,
    MonsterSprite = 2,
    background = 3,
    DragonSprite = 4,
}

Z_INDEXES = {
    background = 1,
    HeroSprite = 2,
    MonsterSprite = 2,
    ActorSprite = 2,
    Dragon = 3,
}


-- for this challenge, let's make Beyond a global class 
-- so that we can call it from main.lua
class('Beyond').extends()

local allScreens = {
    "The East Watch",
    "Plains",
    "Woods",
    "Arrow Mountain",
    "The Frozen Lake",
}

local gameState = {
    currentScreen = allScreens[1],
    day = 1,
}

-- name, hp, attack, defense, speed, lvl, exp, gold, drop, status, weakness, resistance
local jonSnow = HeroModel("Jon Snow",  100, 10, 10, 10, 1, 0, 0, {"longclaw"}, {"normal"}, {"fire"}, {"ice"})
local tormund = HeroModel("Tormund Giantsbane",  100, 10, 10, 10, 1, 0, 0, {"axe"}, {"normal"}, {"fire"}, {"ice"})
local beric = HeroModel("Beric Dondarrion",  100, 10, 10, 10, 1, 0, 0, {"flaming sword"}, {"normal"}, {"fire"}, {"ice"})
local thoros = HeroModel("Thoros of Myr",  100, 10, 10, 10, 1, 0, 0, {"flaming sword"}, {"normal"}, {"fire"}, {"ice"})
local sandor = HeroModel("Sandor Clegane",  100, 10, 10, 10, 1, 0, 0, {"sword"}, {"normal"}, {"fire"}, {"ice"})
local jorah = HeroModel("Jorah Mormont",  100, 10, 10, 10, 1, 0, 0, {"sword", "right dagger", "left dagger"}, {"normal"}, {"fire"}, {"ice"})
local gendry = HeroModel("Gendry",  100, 10, 10, 10, 1, 0, 0, {"hammer"}, {"normal"}, {"fire"}, {"ice"})

local magnificentSeven = {
    jonSnow,
    tormund,
    beric,
    thoros,
    sandor,
    jorah,
    gendry,
}


local guards = {
    "unnamed guard 1", "unnamed guard 2", "unnamed guard 3"
}


local function printGameState()
    print("Day: " .. gameState.day)
    print("Current Screen: " .. gameState.currentScreen)
end

-- I want to move this code into the World class eventually
-- but am failing to get it to work....

local usePrecomputedLevels = not playdate.isSimulator

ldtk.load("challenges/7-levels/assets/world/beyond.ldtk", usePrecomputedLevels)

if playdate.isSimulator then
    ldtk.export_to_lua_files()
end

function Beyond:init()
    printGameState()

    local util = Util()

    -- add 1 Actor to the scene
    --local player = Actor("Jon Snow")
    -- magnificentSeven[1]:tableDump()
    print( magnificentSeven[1].name )

    local jon = util:getActorByName(magnificentSeven, "Jon Snow")
    -- local jorah = util:getActorByName(magnificentSeven, "Jorah Mormont")
    -- print("jorah drops: " .. jorah.drop[3])

    -- local world = World()
    -- world:load()



    self:goToLevel("Level_0")
    self.spawnX = 12 * 16
    self.spawnY = 5 * 16

    self.jon = HeroSprite(self.spawnX, self.spawnY, self, jon)
end

function Beyond:goToLevel(level_name)
    gfx.sprite.removeAll()
  
    self.levelName = level_name
  
    for layer_name, layer in pairs(ldtk.get_layers(level_name)) do
      if layer.tiles then
        local tilemap = ldtk.create_tilemap(level_name, layer_name)
        local layerSprite = gfx.sprite.new()
  
        layerSprite:setTilemap(tilemap)
        layerSprite:setCenter(0, 0)
        layerSprite:moveTo(0, 0)
        layerSprite:setZIndex(layer.zIndex)
        layerSprite:add()
  
        local emptyTiles = ldtk.get_empty_tileIDs(level_name, "Wall", layer_name)
  
        if emptyTiles then
          gfx.sprite.addWallSprites(tilemap, emptyTiles)
        end
      end
    end
end

function Beyond:checkSpritePosition()
    -- print("Beyond checking...")
end

function Beyond:resetPlayer()
    self.jon:moveTo(self.spawnX, self.spawnY)
  end
  
  function Beyond:enterRoom(direction)
    local level = ldtk.get_neighbours(self.levelName, direction)[1]
  
    self:goToLevel(level)
    self.jon:add()
  
    local spawnX, spawnY
  
    if direction == "north" then
      spawnX, spawnY = self.jon.x, 240
    elseif direction == "south" then
      spawnX, spawnY = self.jon.x, 0
    elseif direction == "east" then
      spawnX, spawnY = 0, self.jon.y
    elseif direction == "west" then
      spawnX, spawnY = 400, self.jon.y
    end
  
    self.jon:moveTo(spawnX, spawnY)
    self.spawnX = spawnX
    self.spawnY = spawnY
  end


function Beyond:reset()
    print("Beyond reset")
end

function Beyond:update()
    if pd.buttonJustReleased( pd.kButtonB ) then
		self:reset()
	end	
    self:checkSpritePosition()
end
