extends Node2D

@export var info: DefenderInfo

var draggable: bool = false
var insideDropzone: bool = false
var current_dropzone = null
var drag_preview: Area2D

@onready var drag_scene = preload("res://game/ui/DragPreview.tscn")

var isDragging = false

func _ready() -> void:
    $PreviewSprite.texture = info.previewSprite
    $Label.text = str(info.cost)
    pass

func _process(_delta: float) -> void:
    toggleCardEnabled()

func _input(event: InputEvent):
    if MoneyManager.hasEnoughMoney(info.cost) == false:
        return

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed and $PreviewSprite.get_rect().has_point(to_local(event.position)) :

            start_drag(event.position)
        elif not event.pressed and isDragging:
            end_drag(event.position)

    if event is InputEventMouseMotion and isDragging:
        drag_preview.global_position = event.position

func start_drag(mouse_pos: Vector2):
    setDragging(true)
    
    drag_preview = drag_scene.instantiate()
    drag_preview.sprite = $PreviewSprite.texture
    drag_preview.scale = Vector2(1.5, 1.5)
    drag_preview.z_index = 1
    
    drag_preview.connect("dropzone_entered", Callable(self, "_on_dropzone_entered"))
    drag_preview.connect("dropzone_exited", Callable(self, "_on_dropzone_exited"))
    
    get_tree().current_scene.add_child(drag_preview)
    drag_preview.global_position = mouse_pos

func end_drag(_mouse_pos: Vector2):
    if current_dropzone != null:
        if MoneyManager.spendMoney(info.cost):
            GameManager.occupyDropzone(current_dropzone)
            var defender_instance = info.defenderScene.instantiate()
            defender_instance.position = current_dropzone.position
            get_tree().current_scene.add_child(defender_instance)
            
    setDragging(false)
    drag_preview.queue_free()

func setDragging(value: bool):
    GameManager.isDragging = value
    isDragging = value
    current_dropzone= null

func _on_dropzone_entered(zone):
    current_dropzone = zone

func _on_dropzone_exited(zone):
    if current_dropzone == zone:
        current_dropzone = null

func toggleCardEnabled() -> void:
    if MoneyManager.totalMoney < info.cost:
        $PreviewSprite.modulate = Color(1, 1, 1, 0.5)
        $CardSprite.modulate = Color(1, 1, 1, 0.5)
        $Label.modulate = Color(1, 0, 0, 0.5)
        $Area2D/CollisionShape2D.disabled = true
    else:
        $PreviewSprite.modulate = Color(1, 1, 1, 1)
        $CardSprite.modulate = Color(1, 1, 1, 1)
        $Label.modulate = Color(1, 1, 1, 1)
        $Area2D/CollisionShape2D.disabled = false
    pass
