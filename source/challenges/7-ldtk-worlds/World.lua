---@diagnostic disable: undefined-global
import "challenges/7-ldtk-worlds/libraries/LDtk"

local gfx <const> = playdate.graphics
local ldtk <const> = LDtk


local usePrecomputedLevels = not playdate.isSimulator

ldtk.load("challenges/7-ldtk-worlds/assets/world/beyond.ldtk", usePrecomputedLevels)

if playdate.isSimulator then
    ldtk.export_to_lua_files()
end


class ('World').extends()

--[[
    World class
    This class is responsible for loading the world and its assets
]]
function World:load()
    print('World goToLevel')
    -- self:goToLevel("Level_0")
    

    self:goToLevel("Level_0")
end

function World:goToLevel()
    -- if the world is loaded, then we can go to the level
    if ldtk.isLoaded then
        self:goToLevel("Level_0")
    end
end
