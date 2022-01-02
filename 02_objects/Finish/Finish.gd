extends Area2D
class_name Finish
static func instantiate() -> Finish:
    return load(
        "res://02_objects/Finish/Finish.tscn"
    ).instance() as Finish


#----------------------------------------------------------------------- SIGNALS
signal reached()


#------------------------------------------------------- VARIABLES AND CONSTANTS
var __is_activated: bool = false


#--------------------------------------------------------------------- CALLBACKS
func _on_Finish_body_entered(body: Node) -> void:
    var player: Player = body as Player
    if player and not __is_activated:
        __is_activated = true
        emit_signal('reached')
