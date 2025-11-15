extends Node2D

func _ready() -> void:
    Dialogic.timeline_ended.connect(_on_timeline_ended)
    Dialogic.signal_event.connect(textSignalFromDialogic)

    Dialogic.start("level1_intro")
    



func _on_timeline_ended() -> void:
    get_tree().change_scene_to_file("res://game/scenes/Level1Scene.tscn")

func textSignalFromDialogic(text: String) -> void:
    if text == "showCoinPurse":
        $MoneyBag.visible = true

    if text == "showDefender":
        $Defender.visible = true

    if text == "showWizard":
        $Wizard.visible = true
