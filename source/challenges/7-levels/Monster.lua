import "challenges/7-levels/Actor"

class('Monster').extends('Actor')

function Monster:init()
   Actor.init(self, name)
end

function Monster:createHorde(name, count)
    local horde = {}
    for i = 1, count do
        local wight = Monster:new("Wight")
        table.insert(horde, wight)
    end
    return horde
end

-- https://www.perplexity.ai/search/I-am-trying-m5XRSTBTSXqYLFMi0UCjlw?s=c