class_name SectorMeteoritos
extends Node2D

## Attrib Export
export var cantidad_meteoritos:int = 15
export var intervalo_spawn:float = 0.5

## Attrib var
var spawners:Array
var spawner_index:int = 0

## Construc
func crear(pos: Vector2, meteoritos: int) -> void:
	global_position = pos
	cantidad_meteoritos = meteoritos

## Methods
func _ready() -> void:
	$MeteoroSpawmerTimer.wait_time = intervalo_spawn
	almacenar_spawners()
	conectar_seniales_detectores()

## Customs Methods
func conectar_seniales_detectores() -> void:
	for detector in $DetectorFueraZona.get_children():
		print("Y se marchó ")
		detector.connect("body_entered", self, "_on_detector_body_entered")

func almacenar_spawners() -> void:
	for spawner in $Spawmer.get_children():
		spawners.append(spawner)

func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()

func _on_MeteoroSpawmerTimer_timeout() -> void:
	if cantidad_meteoritos == 0:
		$MeteoroSpawmerTimer.stop()
		return
		
	spawner_index = spawner_aleatorio()
	spawners[spawner_index].spawmear_meteorito()
	print("se ha spwmeado un moteoro: ", spawner_index)
	cantidad_meteoritos -= 1

func _on_detector_body_entered(body: Node) -> void:
	
	body.set_esta_en_sector(false)
