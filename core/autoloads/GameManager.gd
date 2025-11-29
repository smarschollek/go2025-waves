extends Node

const START_LEVEL = 0

func reset() -> void:
    isDragging = false
    occupiedDropzones = []

var rootNode: Node = null

func getSceneRoot() -> Node:
    return rootNode

func setSceneRoot(root: Node) -> void:
    rootNode = root


func _ready() -> void:
    reset()    

func _physics_process(_delta: float) -> void:
    if currentWaveTimeInSeconds >= waveTimeInSeconds:
        if get_tree().get_nodes_in_group("Enemy").is_empty():
            await get_tree().create_timer(1.0).timeout
            levelFinished.emit(false)

#Drag and Drop 

var isDragging = false
var occupiedDropzones = []

func occupyDropzone(zone) -> void:
    occupiedDropzones.append(zone)

func isDropzoneFree(zone) -> bool:
    return not zone in occupiedDropzones
    
# Gameover handling
var showLastWaveApproaching := false
var showEnemiesAreComing := false

signal levelFinished(lost: bool)

var waveTimeInSeconds := 9999
var currentWaveTimeInSeconds := 0

func enemyReachedGoal() -> void:
    levelFinished.emit(true)

func newGame() -> void:
    get_tree().paused = false
    UpgradeManager.reset()
    SeededRNG.setup(int(Time.get_unix_time_from_system()))
    level = START_LEVEL
    loadNextLevel()

# Level management

var level: int = START_LEVEL

func loadNextLevel() -> void:
    level += 1
    waveTimeInSeconds = 9999
    currentWaveTimeInSeconds = 0  

    get_tree().change_scene_to_packed(load(LevelData.level1.scenePath))

# zIndex constants

const ZINDEX = {
    "BACKGROUND": 0,
    "GROUND": 1,
    "ENTITIES": 3,
    "PROJECTILES": 4,
    "UI": 5
}

# Tooltips

const TOOLTIPS = {
    "arcaneCore": {
        "title": "Arcane Core",
        "description": "Explodes when hit. Destroys all opponents on the lane"
    },
    "wizard": {
        "title": "Wizard",
        "description": "Shoots magic projectiles at enemies."
    },
    "swordman": {
        "title": "Swordman",
        "description": "Melee unit that attacks enemies up close."
    
    },
    "priest": {
        "title": "Priest",
        "description": "Pray for more coins",
    },
    "frostwizard": {
        "title": "Frost Wizard",
        "description": "Shoots frost projectiles that slow down enemies.",
    },
    "knight": {
        "title": "Knight",
        "description": "Tank unit with high health.",
    },
}


# Money management

var coinValue: int = 25
var maximumCoinsOnScene: int = 3
var coinSpawnInterval: float = 5

