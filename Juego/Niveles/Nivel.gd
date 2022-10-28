class_name Nivel
extends Node2D

##Attrib OnReady
onready var contenedor_proyectiles:Node

## Methods
func _ready() -> void:
	conectar_seniales()
	crear_contenedores()

## Custom Methods
func conectar_seniales() -> void:
	Eventos.connect("disparo", self, "_on_disparo")

func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)
	
func _on_disparo(proyectil:Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)
