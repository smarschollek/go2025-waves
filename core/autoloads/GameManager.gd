extends Node

var lastWaveSpawned = false

func reset() -> void:

    # setupRandomnSeed(int(Time.get_unix_time_from_system()))
    setupRandomnSeed(42)
    isDragging = false
    occupiedDropzones = []
    
    lastWaveSpawned = false


func _ready() -> void:
    reset()    

func _physics_process(_delta: float) -> void:
    if lastWaveSpawned and get_tree().get_nodes_in_group("Enemy").is_empty() and gameOverTriggered == false:
        triggerGameOver(false)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("toggleFullscreen"):
        if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
        else:
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

#Drag and Drop 

var isDragging = false
var occupiedDropzones = []

func occupyDropzone(zone) -> void:
    occupiedDropzones.append(zone)

func isDropzoneFree(zone) -> bool:
    return not zone in occupiedDropzones
    
#Random number generator

var rng = RandomNumberGenerator.new()

func setupRandomnSeed(seed_value: int) -> void:
    rng.seed = seed_value

func getRandomInt(min_value: int, max_value: int) -> int:
    return rng.randi_range(min_value, max_value)

# Gameover handling

signal gameOver(lost)

var gameOverTriggered = false

func triggerGameOver(lost: bool) -> void:
    gameOverTriggered = true
    emit_signal("gameOver", lost)
    
# Timer Helper

func waitFor(time_ms: int) -> void:
    await get_tree().create_timer(time_ms / 1000.0).timeout
    