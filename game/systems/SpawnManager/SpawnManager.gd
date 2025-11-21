extends Node

const SPAWN_INTERVAL := 5.0
const SPAWN_INTERVAL_REDUCE_EVERY := 100
const MIN_SPAWN_INTERVAL := 1.0

var gameTime := 0.0
var spawnTimer: Timer

var enemy_pools = [
    {
        "unlockTime": 20,        
        "weights": {
            "Skeleton": 8
        }
    },
    {
        "unlockTime": 120,      
        "weights": {
            "Slime": 3
        }
    },
    {
        "unlockTime": 240,
        "weights": {
            "Orc": 1
        }
    }
]

var spawnPoints := []

func _ready():
    spawnTimer = Timer.new()
    spawnTimer.wait_time = SPAWN_INTERVAL
    spawnTimer.timeout.connect(_on_spawnTimer_timeout)
    add_child(spawnTimer)
    spawnTimer.start()

    TimeManager.gameTick.connect(_on_gameTick)

    for child in get_children():
        if child is Marker2D:
            spawnPoints.append(child)


func _on_gameTick(totalTick: int) -> void:
    gameTime = totalTick
    if totalTick % SPAWN_INTERVAL_REDUCE_EVERY == 0 and spawnTimer.wait_time > MIN_SPAWN_INTERVAL:
        print("Reducing spawn interval to %f" % (spawnTimer.wait_time - 1.0))
        spawnTimer.wait_time -= 1.0


func _on_spawnTimer_timeout():
    var enemyType = getWeightedEnemy()
    var spawnPoint = spawnPoints[SeededRNG.getRandomInt(0, spawnPoints.size() - 1)]

    if enemyType:
        spawnEnemy(enemyType, spawnPoint)


func getWeightedEnemy():
    var available = {}

    for pool in enemy_pools:
        if gameTime >= pool.unlockTime:
            for type in pool.weights:
                available[type] = available.get(type, 0) + pool.weights[type]
    
    if available.is_empty():
        return null

    var totalWeight = 0
    for w in available.values():
        totalWeight += w
    
    var rnd = SeededRNG.getRandI() % totalWeight
    var cumulative = 0
    
    for type in available.keys():
        cumulative += available[type]
        if rnd < cumulative:
            return type
    
    return null


func spawnEnemy(enemyType: String, position: Marker2D):
    var enemyScene = ResourceLoader.load("res://game/entities/enemies/%s.tscn" % enemyType) as PackedScene
    var enemy = enemyScene.duplicate().instantiate()
    enemy.position = position.global_position
    enemy.scale = enemy.scale
    add_child(enemy)
