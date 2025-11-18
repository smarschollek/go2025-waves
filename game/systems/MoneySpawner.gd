extends Node
class_name MoneySpawner

@export var spawnInterval: float = 7.5
@export var maxSpawns: int = 5
@export var coin: PackedScene
@export var area: Area2D

var activeSpawns: int = 0

func _ready() -> void:
    addTimer()

func addTimer() -> void:
    var timer: Timer = Timer.new()
    timer.wait_time = spawnInterval
    timer.one_shot = false
    timer.autostart = true
    add_child(timer)
    timer.timeout.connect(spawnCoin)

func spawnCoin() -> void:
    
    if activeSpawns >= maxSpawns:
        return

    var coinInstance: Area2D = coin.duplicate().instantiate()
    coinInstance.collected.connect(onCoinCollected)

    var shape = area.find_child("CollisionShape2D").shape as RectangleShape2D

    var spawnPosition := area.position + Vector2(
        randf_range(-shape.extents.x, shape.extents.x),
        randf_range(-shape.extents.y, shape.extents.y)
    )

    coinInstance.position = spawnPosition
    coinInstance.z_index = 10
    get_tree().current_scene.add_child(coinInstance)
    activeSpawns += 1
    
func onCoinCollected() -> void:
    activeSpawns -= 1
    pass
