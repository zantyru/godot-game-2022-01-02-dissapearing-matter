extends KinematicBody2D
class_name Player
static func instantiate() -> Player:
    return load(
        "res://02_objects/Player/Player.tscn"
    ).instance() as Player


#------------------------------------------------------ CLASS NAMES BY CONSTANTS


#-------------------------------------------------------------------- SUBCLASSES


#----------------------------------------------------------------------- SIGNALS


#------------------------------------------------------- VARIABLES AND CONSTANTS
enum FACING {
    NONE,
    TO_THE_RIGHT,
    TO_THE_LEFT,
}

enum MOTION {
    NONE,
    IDLE,
    WALKING,
    JUMPING,
}

const ANIMATIONS: Dictionary = {
    FACING.TO_THE_RIGHT: {
        MOTION.IDLE: "idle_right",
        MOTION.WALKING: "walking_right",
        MOTION.JUMPING: "jumping_right",
    },
    FACING.TO_THE_LEFT: {
        MOTION.IDLE: "idle_left",
        MOTION.WALKING: "walking_left",
        MOTION.JUMPING: "jumping_left",
    },
}

onready var __motor: CharacterMotor2D = $CharacterMotor2D
onready var __animated_sprite: AnimatedSprite = $AnimatedSprite

var __facing: int = FACING.TO_THE_RIGHT
var __motion: int = MOTION.IDLE


#----------------------------------------------------------------------- METHODS
func _process(_delta: float) -> void:
    var old_facing := __facing
    var old_motion := __motion
    
    if __motor.motion_direction.x > 0.0:
        __facing = FACING.TO_THE_RIGHT
    elif __motor.motion_direction.x < 0.0:
        __facing = FACING.TO_THE_LEFT
    
    if is_zero_approx(__motor.motion_direction.x):
        __motion = MOTION.IDLE
    else:
        __motion = MOTION.WALKING
    
    if not __motor.is_on_floor:
        __motion = MOTION.JUMPING
    
    if old_facing != __facing or old_motion != __motion:
        __animated_sprite.play(ANIMATIONS[__facing][__motion])


#--------------------------------------------------------------------- COROUTINS


#--------------------------------------------------------------------- CALLBACKS
