extends Node

const VOLUMEDB = {
    EFFECT = -15.0,
}

const EFFECT_COOLDOWN_MS: int = 300

var playedEffects: Array = []

func _process(_delta: float) -> void:
    var currentTime := Time.get_ticks_msec()

    playedEffects = playedEffects.filter(func(effect): 
        return currentTime - effect["timestamp"] < EFFECT_COOLDOWN_MS
    )

func playBackgroundMusic(stream: AudioStream, volume_db: float = -10.0) -> void:
    if stream == null:
        return

    var musicPlayer := AudioStreamPlayer2D.new()
    add_child(musicPlayer)
    musicPlayer.stream = stream
    musicPlayer.volume_db = volume_db
    musicPlayer.play()

func playEffect(stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0) -> void:
    
    if playedEffects.any(func(effect): 
        return effect["stream"] == stream
    ):
        return

    playedEffects.append({"stream": stream, "timestamp": Time.get_ticks_msec()})

    var player := AudioStreamPlayer.new()
    add_child(player)
    player.stream = stream
    player.volume_db = volume_db
    player.pitch_scale = pitch_scale
    player.play()
    await player.finished
    player.queue_free()
