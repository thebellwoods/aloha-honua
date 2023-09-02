-- Libraries
import "libraries/AnimatedSprite"
import "libraries/LDtk"
import "Lightening"

class('Effects').extends()

function Effects:init()
    self.lightening = Lightening()
end



