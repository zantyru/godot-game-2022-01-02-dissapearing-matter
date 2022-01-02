extends Area2D
class_name SecretItem
static func instantiate() -> SecretItem:
    return load(
        "res://02_objects/SecretItem/SecretItem.tscn"
    ).instance() as SecretItem


#----------------------------------------------------------------------- SIGNALS
signal picked_up()


#--------------------------------------------------------------------- CALLBACKS
func _on_SecretItem_body_entered(body: Node) -> void:
    
    var player: Player = body as Player
    
    if player:
        var parent := get_parent()
        
        if parent:
            var particles := ParticlesOfPoof.instantiate() as ParticlesOfPoof
            parent.call_deferred("add_child", particles)
            particles.global_position = global_position
        
        queue_free()
        emit_signal('picked_up')
