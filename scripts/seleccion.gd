extends Node2D



func _on_izq_pressed() -> void:
	Computer.tree.nodoActual = Computer.tree.nodoActual.izquierda.izquierda
	get_tree().change_scene_to_file(Computer.tree.nodoActual.link)

func _on_der_pressed() -> void:
	GlobalTree.NodoActual(GlobalTree.nodoActual.derecha)
	get_tree().change_scene_to_file(GlobalTree.nodoActual.link)
