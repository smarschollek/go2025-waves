extends Node2D

@export var day: int = 1
@export var operatorName: String = "Doug # 1234"
@export var killedUnits: int = 0
@export var opationTime: float = 0.0

func _process(_delta: float) -> void:
    $Day.text = "Day %d" % day
    $HBoxContainer/Texts/Operator.text = operatorName
    $HBoxContainer/Texts/KilledUnits.text = str(killedUnits)
    $HBoxContainer/Texts/OperationTime.text = formatTime(opationTime)
    $HBoxContainer/Texts/Grade.text = calculateGrade()

func formatTime(seconds: float) -> String:
    var total_seconds = int(seconds)
    var hrs = int(total_seconds / 3600.0)
    var mins = int((total_seconds % 3600) / 6.0)
    var secs = total_seconds % 60

    return "%02d:%02d:%02d" % [hrs, mins, secs]


func calculateGrade() -> String:
    return "Training"