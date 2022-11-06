class_name Meteorito
extends RigidBody2D

# Atribb export
export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0
export var hitpoints_base:float = 10.0

# Atrib OnReady
onready var impacto_fsx:AudioStreamPlayer = $ImpactoFSX
onready var impacto_meteoro:AnimationPlayer = $AnimImpactMeteoro

# Att
var hitpoints:float

# Methods
func _ready() -> void:
	angular_velocity = vel_ang_base

# Contruc
func crear(pos: Vector2, dir: Vector2, tamanio: float) -> void:
	position = pos
	# Calc mass, size of sprite and collider
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	# radio = diametro / 2
	var radio:int = int($Sprite.texture.get_size().x / 2.3 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	# Calc veloci
	linear_velocity = (vel_lineal_base * dir / tamanio) * aleatorizar_velocidad()
	angular_velocity = (vel_ang_base / tamanio) * aleatorizar_velocidad()
	# Calc HitPoints
	hitpoints = hitpoints_base * tamanio
	print("Initial Hitpoints -> ", hitpoints)

# Customs Methods
func aleatorizar_velocidad() -> float:
	randomize()
	return rand_range(-0.9, 1.9)

func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0:
		destruir()
	impacto_meteoro.play("impacto")
	impacto_fsx.play()

func destruir() -> void:
	print("Kill meteor at ", hitpoints)
	$CollisionShape2D.set_deferred("disabled", true)
	Eventos.emit_signal("meteorito_destruido", global_position)
	queue_free()
