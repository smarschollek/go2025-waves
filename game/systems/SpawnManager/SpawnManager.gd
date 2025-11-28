extends Node
class_name SpawnManager

var unlockTimes := []
var nextUnlockTime := 0
var spawnPoints := []

var _bagManager: BagManager
var _spawnCurve: Curve

func initialize(bagManager: BagManager, spawnCurve: Curve) -> void:
    _bagManager = bagManager
    _spawnCurve = spawnCurve
    GameManager.currentWaveTimeInSeconds = 0
    
    TimeManager.gameTick.connect(_on_gameTick)
    

    GameManager.waveTimeInSeconds = int(spawnCurve.max_domain)

func _ready() -> void:
    setupSpawnPoints()

func _on_gameTick(totalTick: int) -> void:
    if not _bagManager.hasBagItems():
        return

    if GameManager.currentWaveTimeInSeconds >= GameManager.waveTimeInSeconds:
        return


    var timeLeft = GameManager.waveTimeInSeconds - GameManager.currentWaveTimeInSeconds
    if timeLeft == 50:
        GameManager.showLastWaveApproaching = true
    if timeLeft == 40:
        GameManager.showLastWaveApproaching = false

    GameManager.currentWaveTimeInSeconds += 1
        
    var spawnWaitTime : int = round(_spawnCurve.sample(GameManager.currentWaveTimeInSeconds))

    if totalTick % spawnWaitTime == 0:
        var item = _bagManager.getRandomBagItem()
        if item != null:
            var spawnPoint = spawnPoints[SeededRNG.getRandI() % spawnPoints.size()]
            spawnEnemy(item.type, item.level, spawnPoint)

func setupSpawnPoints():
    for child in get_children():
        if child is Marker2D:
            spawnPoints.append(child)

func spawnEnemy(sceneName: String, level: int, position: Marker2D):
    var attacker = load("res://data/units/Attacker/Skeleton/Skeleton_L%s.tres" % level) as Attacker
    var enemyScene = load("res://game/entities/enemies/%s.tscn" % sceneName) as PackedScene
    var enemy = enemyScene.duplicate().instantiate()
    enemy.data = attacker
    enemy.position = position.global_position
    enemy.scale = enemy.scale
    add_child(enemy)
