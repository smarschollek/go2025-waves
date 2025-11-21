extends Node

signal cardDropped(dropZone: Node, card: Node)

var currentCard: Node = null
var storedScene: PackedScene = null

var dragPreview : Sprite2D = null

func onDrag(mousePosition: Vector2):
    dragPreview.position = mousePosition

func startDrag(card: Node, scene: PackedScene, previewTexture: Texture2D) -> void:
    currentCard = card
    storedScene = scene
    dragPreview = Sprite2D.new()
    dragPreview.texture = previewTexture
    dragPreview.flip_h = true
    dragPreview.z_index = GameManager.ZINDEX.UI
    dragPreview.scale = Vector2(3,3)
    GameManager.getSceneRoot().add_child(dragPreview)

func tryDrop(dropZone: Node) -> void:
    if storedScene == null or currentCard == null:
        return

    var instance : Node2D = storedScene.duplicate().instantiate()
    instance.z_index = GameManager.ZINDEX.ENTITIES
    dropZone.add_child(instance)
    cardDropped.emit(dropZone, currentCard)
    clear()

func clear() -> void:
    if dragPreview:
        dragPreview.queue_free()
    
    dragPreview = null
    currentCard = null
    storedScene = null

func isDragging() -> bool:
    return currentCard != null and storedScene != null
