extends Node2D
class_name SpawnManager
 
@export var waveData: WaveData
var internalWaveData: WaveData

var spawn_points : Array[Marker2D]
var enemy_info: Dictionary = { "type" :"", "amount" : 0 }

func _ready():
    internalWaveData = waveData.duplicate(true)
    enemy_info = { "type" :"", "amount" : 0 }
    spawnDelay = 10

    spawn_points = []
    for child in get_children():
        if child is Marker2D:
            spawn_points.append(child)

var spawnDelay = 10
var spawnDelayIncreaseInterval := 120
var spawnDelayDecreaseAmount := 1

func startSpawningWave() -> void:
    if spawn_points.is_empty() == false:
        TimeManager.onGameTick.connect(_on_game_tick)

func _on_game_tick(totalTicks: int) -> void:
    if totalTicks % spawnDelay == 0:
        startSpawning()

    if totalTicks % spawnDelayIncreaseInterval == 0:
        decreaseSpawnDelay()
    
func decreaseSpawnDelay() -> void:
    if(spawnDelay > 5):
        spawnDelay -= spawnDelayDecreaseAmount

func startSpawning() -> void:
    if internalWaveData.enemies.is_empty() and enemy_info["amount"] <= 0:
        GameManager.lastWaveSpawned = true
        return

    var spawn_point = spawn_points[SeededRNG.getRandomInt(0, spawn_points.size() - 1)]

    if enemy_info["amount"] <= 0:
        enemy_info = internalWaveData.enemies.pop_front()    

    if enemy_info != null:
        spawnEnemies(spawn_point)

func spawnEnemies(pos) -> void:
    var enemy_scene = ResourceLoader.load("res://game/entities/enemies/%s.tscn" % enemy_info["type"]) as PackedScene
    var enemy = enemy_scene.instantiate()
    var scaleInfo = enemy_info["scale"]

    var startPosition = pos.global_position
    
    if int(scaleInfo) == 1:
        startPosition.y += SeededRNG.getRandomInt(-6, 3) * 4

    startPosition.y -= scaleInfo * 4

    enemy.position = startPosition

    enemy.scale = enemy.scale * Vector2(scaleInfo, scaleInfo)
    add_child(enemy)
    enemy_info.amount -= 1
