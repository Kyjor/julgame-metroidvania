using JulGame.Macros

mutable struct Enemy
    animator
    isFacingRight
    parent

    function Enemy()
        this = new()
        
        this.parent = C_NULL

        return this
    end
end

# This is called when a scene is loaded, or when script is added to an entity
# This is where you should register collision events or other events
# Do not remove this function
function JulGame.initialize(this::Enemy)
    this.animator = this.parent.animator
    this.animator.currentAnimation = this.animator.animations[1]
    this.animator.currentAnimation.animatedFPS = 2
    this.parent.sprite.isFlipped = true

    collisionEvent = JulGame.Macros.@argevent (col) handle_collisions(this, col)
    JulGame.Component.add_collision_event(this.parent.collider, collisionEvent)
end

# This is called every frame
# Do not remove this function
function JulGame.update(this::Enemy, deltaTime)
end

# This is called when the script is removed from an entity (scene change, entity deletion)
# Do not remove this function
function JulGame.on_shutdown(this::Enemy)
end 

function handle_collisions(this::Enemy, event)
    if event.collider.tag == "ground"
        println("Enemy collided with ground")
    end
end