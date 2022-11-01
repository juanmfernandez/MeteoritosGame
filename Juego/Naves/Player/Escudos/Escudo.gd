class_name Escudo
extends Area2D

# Vars
var is_active:bool = false setget, get_is_active
var energia:float = 8.0
var radio_desgaste:float = -1.6

#Setters and getters
func get_is_active() -> bool:
	return is_active

func _process(delta: float) -> void:
	energia += radio_desgaste * delta
	
	if energia <= 0:
		desactivar()

## Methods
func _ready() -> void:
	set_process(false)
	collider_controller(true)

## Custom Methods
func collider_controller(active:bool) -> void:
	$CollisionShape2D.set_deferred("disabled", active)

func activar() -> void:
	if energia <= 0:
		return

	is_active = true
	collider_controller(false)
	$AnimationPlayer.play("activando")

func desactivar() -> void:
	set_process(false)
	is_active = false
	collider_controller(true)
	$AudioStreamPlayer.stop()
	$AnimationPlayer.play_backwards("activando")

## Signals
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activando" and is_active:
		$AnimationPlayer.play("activado")
		set_process(true)


func _on_body_entered(body: Node) -> void:
	body.queue_free()
