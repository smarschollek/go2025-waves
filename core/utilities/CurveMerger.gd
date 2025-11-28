extends Node

var CURVES = {
    "Intro": load("res://data/curves/Intro.tres"),            #10s
    "Fast2": load("res://data/curves/Fast2.tres"),            #20s
    "Fast4": load("res://data/curves/Fast4.tres"),            #20s
    "LastWave": load("res://data/curves/LastWave.tres"),      #40s
}

func buildRandomWaveCurve(totalLenght: int) -> Curve:    
    var randomCurveLenght = totalLenght - 50  # Reserve 50s for intro and last wave
    var curvesToUse: Array = []

    curvesToUse.append(CURVES["Intro"])
    

    var currentLength = 10  
    var availableCurves = ["Intro", "Fast4"]    

    if(GameManager.level >= 5):
        availableCurves.append("Fast2")
        curvesToUse.append(CURVES["Fast4"])
        currentLength += 20


    while currentLength < randomCurveLenght:
        var curveName = availableCurves[SeededRNG.getRandI() % availableCurves.size()]
        var curve = CURVES[curveName]
        var curveLength = int(curve.max_domain)

        if currentLength + curveLength <= randomCurveLenght:
            curvesToUse.append(curve)
            currentLength += curveLength

    curvesToUse.append(CURVES["LastWave"])
    return concatenate_curve_array(curvesToUse)


func concatenate_curve_array(curves: Array, step: float = 0.1) -> Curve:
    var result := Curve.new()
    result.max_domain = 600
    result.max_value = 100

    var offset := 0.0
    var maxValue := 0.0

    for i in range(curves.size()):
        var curve: Curve = curves[i]

        var t := 0.0
        while t <= curve.max_domain:
            var y := curve.sample(t)
            result.add_point(Vector2(offset + t, y))
            if y > maxValue:
                maxValue = y
            t += step

        offset += curve.max_domain

    result.min_value = 1.0
    result.max_value = maxValue
    result.max_domain = offset
    result.min_domain = 0.0

    result.bake()
    return result