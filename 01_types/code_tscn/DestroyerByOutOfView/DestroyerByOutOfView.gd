extends Area2D
class_name DestroyerByOutOfView


#------------------------------------------------------- VARIABLES AND CONSTANTS
var __parent: Node


#----------------------------------------------------------------------- METHODS
func _ready() -> void:
    __parent = get_parent()


#--------------------------------------------------------------------- CALLBACKS
func _on_DestroyerByOutOfView_area_exited(other_area: Area2D) -> void:
    
    other_area = other_area as ViewZone
    
    if __parent and other_area:
        var grand_parent := __parent.get_parent()
        
        if grand_parent:
            var particles := ParticlesOfPoof.instantiate() as ParticlesOfPoof
            grand_parent.call_deferred("add_child", particles)
            particles.global_position = (__parent as Node2D).global_position
        
        __parent.queue_free()
