extends StaticBody2D
class_name Block
static func instantiate() -> Block:
    return load(
        "res://02_objects/Block/Block.tscn"
    ).instance() as Block
