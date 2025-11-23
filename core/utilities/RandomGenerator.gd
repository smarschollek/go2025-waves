extends Node

var rng = RandomNumberGenerator.new()

func setup(seed_value: int) -> void:
    rng.seed = seed_value

func getRandomFloat(min_value: float, max_value: float) -> float:
    return rng.randf_range(min_value, max_value)

func getRandomInt(min_value: int, max_value: int) -> int:
    return rng.randi_range(min_value, max_value)

func getRandI() -> int: 
    return rng.randi()
