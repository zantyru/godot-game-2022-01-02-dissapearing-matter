extends CPUParticles2D
class_name ParticlesOfPoof
static func instantiate() -> ParticlesOfPoof:
    return load(
        "res://02_objects/ParticlesOfPoof/ParticlesOfPoof.tscn"
    ).instance() as ParticlesOfPoof


#----------------------------------------------------------------------- METHODS
func _ready() -> void:
    emitting = true
