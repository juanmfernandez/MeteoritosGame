class_name CameraPlayer
extends CameraJuego

## Export vars
export var variation_zoom: float = 0.1
export var zoom_min: float = 0.8
export var zoom_max: float = 1.5

## Methods
func _ready() -> void:
	zoom_original = zoom

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		controlar_zoom(-variation_zoom)
	elif event.is_action_pressed("zoom_out"):
		controlar_zoom(variation_zoom)

## Custom Methods
func controlar_zoom(mod_zoom: float) -> void:
	var zoom_x = clamp(zoom.x + mod_zoom, zoom_min, zoom_max)
	var zoom_y = clamp(zoom.y + mod_zoom, zoom_min, zoom_max)
	zoom_suavizado(zoom_x, zoom_y, 0.15)
