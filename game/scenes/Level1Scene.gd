extends Node2D

func _process(_delta: float) -> void:
    if $Defenders/Swordman.visible != UpgradeManager.showSwordman:
        $Defenders/Swordman.visible = UpgradeManager.showSwordman
    if $Defenders/Priest.visible != UpgradeManager.showPriest:
        $Defenders/Priest.visible = UpgradeManager.showPriest
    if $Defenders/Frostwizard.visible != UpgradeManager.showFrostwizard:
        $Defenders/Frostwizard.visible = UpgradeManager.showFrostwizard
    if $Defenders/Knight.visible != UpgradeManager.showKnight:
        $Defenders/Knight.visible = UpgradeManager.showKnight

func _ready() -> void:
    MoneyManager.reset()
    GameManager.setSceneRoot(self)
    GameManager.reset()
    
    $Defenders/Swordman.visible = UpgradeManager.showSwordman
    $Defenders/Priest.visible = UpgradeManager.showPriest
    $Defenders/Frostwizard.visible = UpgradeManager.showFrostwizard
    $Defenders/Knight.visible = UpgradeManager.showKnight
    
    TimeManager.startGameTimer()

    Engine.time_scale = 1.0

    AudioManager.playBackgroundMusic(load("res://assets/audio/bgm.mp3") as AudioStream, -15)

    $BagManager.schedule = getLevelBag().schedule
    $SpawnManager.initialize($BagManager, CurveMerger.buildRandomWaveCurve(180))

    setRows()



func getLevelBag() -> LevelBag:
    var levelBag = load("res://data/levels/LevelBag1.tres") as LevelBag

    if GameManager.level >= 5:
        levelBag = load("res://data/levels/LevelBag5.tres") as LevelBag

    if GameManager.level >= 10:
        levelBag = load("res://data/levels/LevelBag10.tres") as LevelBag
    
    return levelBag

func setRows():
    $BackRows/CellRow1.amount = UpgradeManager.rows
    $BackRows/CellRow2.amount = UpgradeManager.rows    
    $BackRows/CellRow3.amount = UpgradeManager.rows
