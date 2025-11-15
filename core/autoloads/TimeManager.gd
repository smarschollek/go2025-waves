extends Node

signal onGameTick(totalTick: int)


var tick := 0
var gameTimer: Timer

func _ready() -> void:
    gameTimer = Timer.new()
    gameTimer.wait_time = 0.25
    gameTimer.one_shot = false
    gameTimer.timeout.connect(_on_game_timer_timeout)
    add_child(gameTimer)

func _on_game_timer_timeout() -> void:
    tick += 1
    onGameTick.emit(tick)

func startGameTimer() -> void:
    gameTimer.start()

func stopGameTimer() -> void:
    tick = 0
    gameTimer.stop()
