extends KinematicBody2D
class_name Block_Destroyable
static func instantiate() -> Block_Destroyable:
    return load(
        "res://02_objects/Block_Destroyable/Block_Destroyable.tscn"
    ).instance() as Block_Destroyable
