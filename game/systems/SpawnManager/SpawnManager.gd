extends Node
class_name SpawnManager

const SPAWN_INTERVAL_REDUCE_EVERY: int  = 100
const MIN_SPAWN_INTERVAL: int = 1

var spawnWaitTime: int = 0

var gameTime: int = 0
var waveTimeInSeconds: int = 0

signal remainingWaveTimeChanged(remainingTime: int)

@export var levelInfo: LevelInfo:
    set(value):
        levelInfo = value
        spawnWaitTime = value.spawnIntervalInSeconds
        waveTimeInSeconds = value.waveLengthInMinutes * 60

var unlockTimes := []
var nextUnlockTime := 0

var spawnPoints := []

func _ready():
    gameTime = 0
    setupSpawnPoints()
    getPoolUnlockTimes()

    TimeManager.gameTick.connect(_on_gameTick)

func getPoolUnlockTimes():
    for pool in levelInfo.enemyPool:
        unlockTimes.append(pool.unlockTime)

    setNextUnlockTime()

func setNextUnlockTime():
    if unlockTimes.size() > 0:
        var temp = unlockTimes.pop_front()
        nextUnlockTime = temp - nextUnlockTime

func setupSpawnPoints():
    for child in get_children():
        if child is Marker2D:
            spawnPoints.append(child)

func printWaveInfo():
    if unlockTimes.size() == 0:
        return

    print("next wave in %d seconds" % nextUnlockTime)
    
    nextUnlockTime -= 1

    if nextUnlockTime == 0:
        print("#########################################")
        print("########## New enemy pool unlocked! #####")
        print("#########################################")
        setNextUnlockTime()

func _on_gameTick(totalTick: int) -> void:
    
    printWaveInfo()

    gameTime = totalTick

    updateRemainingWaveTime()

    if totalTick % spawnWaitTime == 0:
        triggerSpawning()   

func updateRemainingWaveTime():
    remainingWaveTimeChanged.emit(waveTimeInSeconds - gameTime)

func triggerSpawning():
    var enemyName = getWeightedEnemy()
    if(enemyName == null):
        return
        
    var enemy = getEnemyTypeFromSpawnInfo(enemyName)
    var spawnPoint = spawnPoints[SeededRNG.getRandomInt(0, spawnPoints.size() - 1)]

    if enemyName:
        spawnEnemy(enemy.sceneName, enemy.type, spawnPoint)


func getWeightedEnemy():
    var available = {}

    for pool in levelInfo.enemyPool:
        if gameTime >= pool.unlockTime:
            for enemy in pool.enemies:
                available[enemy.name] = enemy.weight
    
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

func getEnemyTypeFromSpawnInfo(enemyName: String) -> EnemyWeight:
    for pool in levelInfo.enemyPool:
        if gameTime >= pool.unlockTime:
            for enemy in pool.enemies:
                if enemy.name == enemyName:
                    return enemy

    return null
    

func spawnEnemy(sceneName: String, attacker: Attacker, position: Marker2D):
    var enemyScene = ResourceLoader.load("res://game/entities/enemies/%s.tscn" % sceneName) as PackedScene
    var enemy = enemyScene.duplicate().instantiate()
    enemy.data = attacker
    enemy.position = position.global_position
    enemy.scale = enemy.scale
    add_child(enemy)
