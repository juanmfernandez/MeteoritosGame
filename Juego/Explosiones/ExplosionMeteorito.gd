class_name ExplosionMeteorito
extends Node2D


# _on_animation_player
func _on_AnimExplosionMeteoro_animation_finished(_anim_name: String) -> void:
	queue_free()
