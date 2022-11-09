class_name MeteoritoSpawner
extends Position2D

export var rango_direccion:Vector2 = Vector2(1.5, -1.5)
export var rango_tamanio_meteorito:Vector2 = Vector2(0.5, 2.5)

var direccion:Vector2 = Vector2(0, 0)
var tamanio:float = 0.0


func spawmear_meteorito() -> void:
	direccion = Vector2(direccion_meteorito_aleatoria(), direccion_meteorito_aleatoria())
	tamanio = tamanio_meteorito_aleatorio()
	print("tamanio ",tamanio," | direccion ", direccion)
	Eventos.emit_signal(
		"spawn_meteorito", 
		global_position, 
		direccion,
		tamanio
		)

func tamanio_meteorito_aleatorio() -> float:
	randomize()
	return rand_range(rango_tamanio_meteorito[0], rango_tamanio_meteorito[1])

func direccion_meteorito_aleatoria() -> float:
	randomize()
	return rand_range(rango_direccion[0], rango_direccion[1])
