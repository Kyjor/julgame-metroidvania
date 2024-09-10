using JulGame.Component 
using JulGame.EntityModule 
using JulGame.Math
using JulGame.UI

mutable struct GameManager
    parent

    function GameManager()
        this = new()

        return this
    end
end

# This is called when a scene is loaded, or when script is added to an entity
# This is where you should register collision events or other events
# Do not remove this function
function JulGame.initialize(this::GameManager)
   # MAIN.scene.camera.backgroundColor = (252, 223, 205)
end

# This is called every frame
# Do not remove this function
function JulGame.update(this::GameManager, deltaTime)
end

# This is called when the script is removed from an entity (scene change, entity deletion)
# Do not remove this function
function JulGame.on_shutdown(this::GameManager)
end 