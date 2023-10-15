-- constructor for the Util class
class('Util').extends()

function Util:getActorByName(actors, name)
    --[[
    Finds an actor in a group by name
    ]]
    for i, actor in ipairs(actors) do
        if actor.name == name then
            return actor
        end
    end
    return nil
end