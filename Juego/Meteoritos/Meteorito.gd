class_name Meteorito
extends RigidBody2D

# Atribb export
export var vel_lineal_base:Vector2 = Vector2(450.0, 450.0)
export var vel_ang_base:float = 100.0
export var hitpoints_base:float = 10.0

# Atrib OnReady
onready var impacto_fsx:AudioStreamPlayer = $ImpactoFSX
onready var impacto_meteoro:AnimationPlayer = $AnimImpactMeteoro

# Att
var hitpoints:float
var esta_en_sector:bool = true setget set_esta_en_sector
var pos_spwan_original:Vector2
var vel_spwan_original:Vector2
var esta_destruido:bool = false

# Setters and Getters
func set_esta_en_sector(valor:bool) -> void:
	esta_en_sector = valor

# Contruc
func crear(pos: Vector2, dir: Vector2, tamanio: float) -> void:
	position = pos
	pos_spwan_original = position - Vector2(aleatorizar_velocidad(), aleatorizar_velocidad())
	# Calc mass, size of sprite and collider
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	# radio = diametro / 2
	var radio:int = int($Sprite.texture.get_size().x / 2.3 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	# Calc velocities
	#linear_velocity = (vel_lineal_base * dir / tamanio) * aleatorizar_velocidad()
	linear_velocity = (vel_lineal_base * dir / tamanio) * aleatorizar_velocidad()
	vel_spwan_original = linear_velocity
	#angular_velocity = (vel_ang_base / tamanio) * aleatorizar_velocidad()
	angular_velocity = (vel_ang_base ) * aleatorizar_velocidad()
	# Calc HitPoints
	hitpoints = hitpoints_base * tamanio
	print("hitpoints: ", hitpoints," | linear_velocity: ", linear_velocity, " | angular_velocity: ", angular_velocity)

# Customs Methods
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if esta_en_sector:
		return
	
	var mi_tranform := state.get_transform()
	mi_tranform.origin = pos_spwan_original
	linear_velocity = vel_spwan_original
	state.set_transform(mi_tranform)
	esta_en_sector = true

func aleatorizar_velocidad() -> float:
	randomize()
	return rand_range(-9, 10)

func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0 and not esta_destruido:
		esta_destruido = true
		destruir()
	impacto_meteoro.play("impacto")
	impacto_fsx.play()

func destruir() -> void:
	print("Kill meteor at ", hitpoints)
	$CollisionShape2D.set_deferred("disabled", true)
	Eventos.emit_signal("meteorito_destruido", global_position)
	queue_free()
