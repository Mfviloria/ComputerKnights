extends Node2D

var tree: Arbol
@onready var label = $Label
func _ready() -> void:
	tree = Arbol.new()
	tree.agregar("Principal","res://Scenes/computador.tscn")
	tree.agregar("Gmail","res://Scenes/inbox.tscn")
	tree.agregar("Carpets","res://Scenes/Carpets.tscn")
	#$Label.text = tree.print_tree_visual(tree.raiz)
	GlobalTree.nodoActual = tree.raiz
	print(tree.nodoActual.link)

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalTree.nodoActual = tree.raiz.izquierda
	get_tree().change_scene_to_file(tree.nodoActual.izquierda.link)
