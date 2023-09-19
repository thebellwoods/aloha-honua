-- Challenge 7 should build on the previous challenges

-- CoreLibs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "challenges/6-effects/Lightening"
import "challenges/6-effects/Player"
import "challenges/7-ldtk-worlds/libraries/LDtk"

local ldtk <const> = LDtk

-- world
import "challenges/7-ldtk-worlds/World"

-- actors
import "challenges/7-ldtk-worlds/Actor"
import "challenges/7-ldtk-worlds/actors/hero/HeroModel"

import "challenges/7-ldtk-worlds/Monster"

-- util 
import "challenges/7-ldtk-worlds/Util"

local pd <const> = playdate
local gfx <const> = playdate.graphics


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

-- East Watch
--[[
   The East Watch is a castle on the wall.
   Jon meets with Davos and create a party to capture the wight.
   He releases the prisoners: Tormund, Beric Dondarrion, Thoros of Myr, Sandor Clegane, Jorah Mormont, and Gendry. 
]]



local eastWatchCast = {
    monsters = {},
    -- heros = HeroModel:createParty(magnificentSeven),
    -- guards = HeroModel:createParty(guards),
}

-- Plains
--[[
    The plains are a vast expanse of land beyond the wall.

local plains = {
    -- monsters = { Monster:new("Undead Polarbear") },
    -- magnificent seven
    -- heros = HeroModel:createParty(magnificentSeven),
    guards = HeroModel:createParty({"unnamed guard 1", "unnamed guard 2", "unnamed guard 3"}) ,
}
-- Woods before Arrow Mountain
--[[
    The woods are a light forest beyond the wall that the party travels through to reach Arrow Mountain.

local woods = {
    monsters = {
        "Wight", "White Walker"
    },
    heroes = magnificentSeven,
}

-- Arrow Mountain

-- The Frozen Lake
--[[
    The Frozen Lake is a lake beyond the wall. 
    It is the location of the battle between the White Walkers and the Night's Watch.
    The Night King kills Viserion and turns him into a wight.
    Jon Snow and his party are rescued by Daenerys Targaryen and her dragons.

local frozenLakeCast = {
    monsters = {
        wights = Monster:createHorde("Wight", 1000),
        whiteWalkers = Monster:createHorde("White Walker", 100),
        nightKing = Monster:new("Night King"),
    },
    heros = {},
}
]]

local function printGameState()
    print("Day: " .. gameState.day)
    print("Current Screen: " .. gameState.currentScreen)
    
    -- printTable(gameState)
end

-- I want to move this code into the World class eventually
-- but am failing to get it to work....

local usePrecomputedLevels = not playdate.isSimulator

ldtk.load("challenges/7-ldtk-worlds/assets/world/beyond.ldtk", usePrecomputedLevels)

if playdate.isSimulator then
    ldtk.export_to_lua_files()
end


function Beyond:init()
    --[[
        I want a simple state machine to control the game
        and track the part as they travel from The East Watch
        to the Frozen Lake and back again
    ]]
    printGameState()

    local util = Util()

    -- add 1 Actor to the scene
    --local player = Actor("Jon Snow")
    -- magnificentSeven[1]:tableDump()
    print( magnificentSeven[1].name )

    local jon = util:getActorByName(magnificentSeven, "Jon Snow")
    local jorah = util:getActorByName(magnificentSeven, "Jorah Mormont")
    print("jorah drops: " .. jorah.drop[3])

    -- local world = World()
    -- world:load()

   self:goToLevel("Level_0")

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
  
        local emptyTiles = ldtk.get_empty_tileIDs(level_name, "Solid", layer_name)
  
        if emptyTiles then
          gfx.sprite.addWallSprites(tilemap, emptyTiles)
        end
      end
    end
  end

function Beyond:checkSpritePosition()
    -- print("Beyond checking...")
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