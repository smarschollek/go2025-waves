extends Node
class_name MoneySpawner

@export var coin: PackedScene
@export var area: Area2D

var activeSpawns: int = 0

func _ready() -> void:
    TimeManager.gameTick.connect(onGameTick)


func onGameTick(tickCount: int) -> void:
    if tickCount % int(GameManager.coinSpawnInterval) == 0:
        spawnCoin()


func spawnCoin() -> void:
    
    if activeSpawns >= GameManager.maximumCoinsOnScene:
        return

    var coinInstance = coin.duplicate().instantiate()
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
