extends Node

var lastWaveSpawned = false

func reset() -> void:
    isDragging = false
    occupiedDropzones = []
    
    lastWaveSpawned = false


func _ready() -> void:
    reset()    

func _physics_process(_delta: float) -> void:
    if lastWaveSpawned and get_tree().get_nodes_in_group("Enemy").is_empty() and gameOverTriggered == false:
        triggerGameOver(false)

#Drag and Drop 

var isDragging = false
var occupiedDropzones = []

func occupyDropzone(zone) -> void:
    occupiedDropzones.append(zone)

func isDropzoneFree(zone) -> bool:
    return not zone in occupiedDropzones
    
# Gameover handling

signal gameOver(lost)

var gameOverTriggered = false

func triggerGameOver(lost: bool) -> void:
    gameOverTriggered = true
    emit_signal("gameOver", lost)

# game state

var operatorName := ""
var day := 0

# save/load handling

var saveData := {
    "operatorName": operatorName,
    "day": day
}

var saveFilePath := "user://savegame.json"

func newGame() -> void:
    SeededRNG.setup(int(Time.get_unix_time_from_system()))

    operatorName = "Doug #" + str(SeededRNG.getRandomInt(1, 1000))
    day = 1

func saveFileExists() -> bool:
    return FileAccess.file_exists(saveFilePath)

func saveGame() -> void:
    var file := FileAccess.open(saveFilePath, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(saveData))
        file.close()

func loadGame() -> void:
    if saveFileExists():
        var file := FileAccess.open(saveFilePath, FileAccess.READ)
        if file:
            var content := file.get_as_text()
            saveData = JSON.parse_string(content)
            file.close()
