using JulGame.AnimationModule
using JulGame.AnimatorModule
using JulGame.RigidbodyModule
using JulGame.Macros
using JulGame.Math
using JulGame.SoundSourceModule

mutable struct PlayerMovement
    animator
    canMove
    input
    isFacingRight
    isJump 
    jumpVelocity
    jumpSound
    parent

    xDir
    yDir

    function PlayerMovement(jumpVelocity = -5)
        this = new()

        this.canMove = false
        this.input = C_NULL
        this.isFacingRight = true
        this.isJump = false
        this.parent = C_NULL
        this.jumpVelocity = jumpVelocity
        this.animator = nothing

        this.xDir = 0
        this.yDir = 0

        return this
    end
end


# This is called when a scene is loaded, or when script is added to an entity
# This is where you should register collision events or other events
# Do not remove this function
function JulGame.initialize(this::PlayerMovement)
    MAIN.scene.camera.target = this.parent.transform
    this.animator = this.parent.animator
    this.animator.currentAnimation = this.animator.animations[1]
    this.animator.currentAnimation.animatedFPS = 0
    this.jumpSound = JulGame.add_sound_source(this.parent, SoundSourceModule.SoundSource(Int32(1), false, "Jump.wav", Int32(50)))
end

# This is called every frame
# Do not remove this function
function JulGame.update(this::PlayerMovement, deltaTime)
    this.canMove = true
    x = 0
    speed = 5
    input = MAIN.input

    # Inputs match SDL2 scancodes after "SDL_SCANCODE_"
    # https://wiki.libsdl.org/SDL2/SDL_Scancode
    # Spaces full scancode is "SDL_SCANCODE_SPACE" so we use "SPACE". Every other key is the same.
    if ((JulGame.InputModule.get_button_pressed(MAIN.input, "SPACE")  || input.button == 1)|| this.isJump) && this.parent.rigidbody.grounded && this.canMove 
        this.animator.currentAnimation.animatedFPS = 0
        force_frame_update(this.animator, Int32(2))
        JulGame.Component.toggle_sound(this.jumpSound)
        add_velocity(this.parent.rigidbody, Vector2f(0, this.jumpVelocity))
    end
    if (JulGame.InputModule.get_button_held_down(MAIN.input, "A") || input.xDir == -1) && this.canMove
        if JulGame.InputModule.get_button_pressed(MAIN.input, "A")
            force_frame_update(this.animator, Int32(2))
        end
        x = -speed
        if this.parent.rigidbody.grounded
            this.animator.currentAnimation.animatedFPS = 5
        end
        if this.isFacingRight
            this.isFacingRight = false
            Component.flip(this.parent.sprite)
        end
    elseif (JulGame.InputModule.get_button_held_down(MAIN.input, "D")  || input.xDir == 1) && this.canMove
        if JulGame.InputModule.get_button_pressed(MAIN.input, "D")
            force_frame_update(this.animator, Int32(2))
        end
        if this.parent.rigidbody.grounded
            this.animator.currentAnimation.animatedFPS = 5
        end
        x = speed
        if !this.isFacingRight
            this.isFacingRight = true
            Component.flip(this.parent.sprite)
        end
    elseif this.parent.rigidbody.grounded
        this.animator.currentAnimation.animatedFPS = 0
        force_frame_update(this.animator, Int32(1))
    end
    
    set_velocity(this.parent.rigidbody, Vector2f(x, Component.get_velocity(this.parent.rigidbody).y))
    x = 0
    this.isJump = false
    if this.parent.transform.position.y > 8
        this.parent.transform.position = Vector2f(1, 4)
    end
end

# This is called when the script is removed from an entity (scene change, entity deletion)
# Do not remove this function
function JulGame.on_shutdown(this::PlayerMovement)
end 