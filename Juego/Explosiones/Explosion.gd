extends Node2D

onready var explosion_fsx:AudioStreamPlayer2D = $ExplosionFSX


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	explosion_fsx.stop()
