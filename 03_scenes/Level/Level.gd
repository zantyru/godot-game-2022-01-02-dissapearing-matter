extends Node2D
class_name Level


#----------------------------------------------------------------------- SIGNALS
signal finished()
signal failed()
signal secret_item_picked_up()


#------------------------------------------------------- VARIABLES AND CONSTANTS
const DEAD_LINE_OFFSET := 64.0

onready var __tilemap: TileMap = $TileMap

var __player: Player = null
var __dead_line: float = 0.0
var __is_signal_sended: bool = false


#----------------------------------------------------------------------- METHODS
func _ready() -> void:
    var tile_set: TileSet = __tilemap.tile_set
    var BLOCK_TILE_IDX: int = tile_set.find_tile_by_name("block")
    var BLOCK_DESTROYABLE_TILE_IDX: int = tile_set.find_tile_by_name("block destroyable")
    var PLAYER_TILE_IDX: int = tile_set.find_tile_by_name("player")
    var FINISH_TILE_IDX: int = tile_set.find_tile_by_name("finish")
    var SECRET_ITEM_TILE_IDX: int = tile_set.find_tile_by_name("bonus item")
    
    var tiles_coords: Array = __tilemap.get_used_cells()
    var tile_idx: int
    var obj: Node2D
    var obj_global_position: Vector2
    
    for v in tiles_coords:
        tile_idx = __tilemap.get_cellv(v)
        obj_global_position = __tilemap.to_global(__tilemap.map_to_world(v))
        match tile_idx:
            BLOCK_TILE_IDX:
                obj = Block.instantiate()
            BLOCK_DESTROYABLE_TILE_IDX:
                obj = Block_Destroyable.instantiate()
            PLAYER_TILE_IDX:
                obj = Player.instantiate()
                __player = obj
            FINISH_TILE_IDX:
                obj = Finish.instantiate()
                (obj as Finish).connect('reached', self, '_on_Finish_reached')
            SECRET_ITEM_TILE_IDX:
                obj = SecretItem.instantiate()
                (obj as SecretItem).connect('picked_up', self, '_on_SecretItem_picked_up')
        self.add_child(obj)
        obj.global_position = obj_global_position
    
    var rc: Rect2 = __tilemap.get_used_rect()
    var end: Vector2 = __tilemap.to_global(__tilemap.map_to_world(rc.end))
    __dead_line = end.y + DEAD_LINE_OFFSET
    
    __tilemap.queue_free()


func _process(_delta: float) -> void:
    if not __is_signal_sended and __player and __player.global_position.y > __dead_line:
        __is_signal_sended = true
        emit_signal('failed')
    
#--------------------------------------------------------------------- CALLBACKS
func _on_Finish_reached() -> void:
    if not __is_signal_sended:
        __is_signal_sended = true
        emit_signal('finished')


func _on_SecretItem_picked_up() -> void:
    emit_signal('secret_item_picked_up')
