extends Node
class_name CharacterMotor2D


export var speed: float = 25.0
export var crouching_speed: float = 13.0
export var max_h_speed: float = 300.0
export var max_v_speed: float = 1000.0
export (float, 0.0, 1.0, 0.01) var h_damping_factor := 0.65
export var gravity_accel: float = 981.0
export var jumping_accel: float = 32.0 * 981.0
export var crouching_jump_accel: float = 28.0 * 981.0
export (int, 0, 30) var jump_frames_treshold: int = 4
export (int, 0, 30) var jump_accel_frames_treshold: int = 0

var motion_direction := Vector2()
var linear_velocity := Vector2()
var is_jumping := false
var is_on_floor := false
var was_on_floor := false
var is_crouching := false
var is_spacious := true
var __parent: KinematicBody2D
var __jump_frames := 0
var __jump_accel_frames := 0


func _enter_tree() -> void:
    
    __parent = get_parent() as KinematicBody2D
    

#func _ready() -> void:
#
#    check_space()


func _process(_delta: float) -> void:
    
    if was_on_floor and not is_on_floor:
        __jump_frames = 0
    elif not is_on_floor and not is_jumping:
        __jump_frames += 1
#        print(__jump_frames) #@DEBUG
    
    motion_direction.x = (
        int(Input.is_action_pressed("move_right"))
        - int(Input.is_action_pressed("move_left"))
    )
    
    if is_equal_approx(abs(motion_direction.x), 0.0):
        linear_velocity.x *= h_damping_factor
        
    var is_jump_key_pressed := Input.is_action_pressed("jump")
    
    if is_on_floor:
        __jump_accel_frames = 0
    elif is_jump_key_pressed:
        if __jump_frames > jump_frames_treshold:
            __jump_accel_frames += 1
    else:
        __jump_accel_frames = jump_accel_frames_treshold + 1
    
    is_jumping = is_jump_key_pressed and (
        is_on_floor
        or __jump_frames <= jump_frames_treshold
        or __jump_accel_frames <= jump_accel_frames_treshold
    )
        
    #is_crouching = Input.is_action_pressed("crouch")
    
    #choice_pose()


func _physics_process(delta: float) -> void:
    
    var spd: float = crouching_speed if is_crouching else speed
    var jac: float = crouching_jump_accel if is_crouching else jumping_accel
    
#    if __jump_frames > jump_frames_treshold:
#        jac /= __jump_accel_frames + 1
#    else:
#        jac += gravity_accel
    
    jac /= __jump_accel_frames + 1
    
    var motion := motion_direction * spd
    var gravity := Vector2(0, 1) * gravity_accel * delta
    var jumping := Vector2(0, -int(is_jumping)) * jac * delta
    
    linear_velocity += gravity + motion + jumping    
    linear_velocity.x = clamp(linear_velocity.x, -max_h_speed, max_h_speed)
    linear_velocity.y = clamp(linear_velocity.y, -max_v_speed, max_v_speed)    
    linear_velocity = __parent.move_and_slide(linear_velocity, Vector2.UP)
    
    was_on_floor = is_on_floor
    is_on_floor = __parent.is_on_floor()
    
    if is_jumping:
        __jump_frames = jump_frames_treshold + 1
        was_on_floor = false
    
    #check_space()
    

#func check_space():
#
#    is_spacious = not _ray.is_colliding()
