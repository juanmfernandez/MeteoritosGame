class_name Motor
extends AudioStreamPlayer2D

export var tiempo_transicion:float = 0.6
export var volumen_apagado:float = -30.0

onready var tween_sonido:Tween = $Tween

var vol_original:float


func _ready() -> void:
	vol_original = volume_db
	volume_db = volumen_apagado

func sonido_on() -> void:
	if not playing:
		play()
	efecto_transicion(volume_db, vol_original)

func sonido_off() -> void:
	efecto_transicion(volume_db, volumen_apagado)

func efecto_transicion(desde_vol:float, hasta_vol:float) -> void:
	tween_sonido.interpolate_property(
		self,
		"volume_db",
		desde_vol,
		hasta_vol,
		tiempo_transicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
	)
	tween_sonido.start()