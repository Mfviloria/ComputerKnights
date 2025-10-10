extends Node
class_name Arbol

var raiz: Nodo = null
var nodoActual:Nodo

func NodoActual(nodo:Nodo):
	nodoActual = nodo

func agregar(dato: String, link:String) -> void:
	var nuevo_nodo = Nodo.new(dato, link)
	if raiz == null:
		raiz = nuevo_nodo
		nodoActual = raiz 
	else:
		_agregar_recursivo(raiz, nuevo_nodo)

func _agregar_recursivo(actual: Nodo, nuevo: Nodo) -> void:
	if nuevo.dato < actual.dato:
		if actual.izquierda == null:
			actual.izquierda = nuevo
		else:
			_agregar_recursivo(actual.izquierda, nuevo)
	else:
		if actual.derecha == null:
			actual.derecha = nuevo
		else:
			_agregar_recursivo(actual.derecha, nuevo)

func preorden(nodo: Nodo = raiz) -> void:
	if nodo == null:
		return
	print(nodo.dato, " ")
	preorden(nodo.izquierda)
	preorden(nodo.derecha)

func inorden(nodo: Nodo = raiz) -> void:
	if nodo == null:
		return
	inorden(nodo.izquierda)
	print(nodo.dato, " ")
	inorden(nodo.derecha)

func postorden(nodo: Nodo = raiz) -> void:
	if nodo == null:
		return
	postorden(nodo.izquierda)
	postorden(nodo.derecha)
	print(nodo.dato, " ")

func altura(nodo: Nodo = raiz) -> int:
	if nodo == null:
		return 0
	return max(altura(nodo.izquierda), altura(nodo.derecha)) + 1

func peso(nodo: Nodo = raiz) -> int:
	if nodo == null:
		return 0
	return 1 + peso(nodo.izquierda) + peso(nodo.derecha)

func nivel(nodo: Nodo, buscar: String, nivel_actual: int = 0) -> int:
	if nodo == null:
		return -1
	if nodo.dato == buscar:
		return nivel_actual
	if buscar < nodo.dato:
		return nivel(nodo.izquierda, buscar, nivel_actual + 1)
	else:
		return nivel(nodo.derecha, buscar, nivel_actual + 1)

func imprimir_recursivo(nodo, nivel := 0):
	if nodo == null:
		return
	
	# Primero imprime la rama derecha
	imprimir_recursivo(nodo.derecha, nivel + 1)
	
	# Imprime el nodo actual con sangría
	var espacios = "    ".repeat(nivel)
	print(espacios + str(nodo.dato))
	
	# Luego imprime la rama izquierda
	imprimir_recursivo(nodo.izquierda, nivel + 1)

	
func inorden_iterativo(raiz: Nodo = self.raiz) -> void:
	var pila: Array = []
	var actual = raiz
	while actual != null or not pila.is_empty():
		if actual != null:
			pila.append(actual)
			actual = actual.izquierda
		else:
			actual = pila.pop_back()
			print(actual.dato, " ")
			actual = actual.derecha

func preorden_iterativo(raiz: Nodo = self.raiz) -> void:
	var pila: Array = []
	var actual = raiz
	while actual != null or not pila.is_empty():
		if actual != null:
			print(actual.dato, " ")
			pila.append(actual)
			actual = actual.izquierda
		else:
			actual = pila.pop_back()
			actual = actual.derecha

func postorden_iterativo(raiz: Nodo = self.raiz) -> void:
	var pila: Array = []
	var ultimo_visitado = null
	var actual = raiz

	while actual != null or not pila.is_empty():
		if actual != null:
			pila.append(actual)
			actual = actual.izquierda
		else:
			var cima = pila[-1]
			if cima.derecha != null and ultimo_visitado != cima.derecha:
				actual = cima.derecha
			else:
				print(cima.dato, " ")
				ultimo_visitado = pila.pop_back()

func equivalentes(arbol1: Nodo, arbol2: Nodo) -> bool:
	var lista1 = _inorden_lista(arbol1, [])
	var lista2 = _inorden_lista(arbol2, [])
	return lista1 == lista2

func _inorden_lista(nodo: Nodo, lista: Array) -> Array:
	if nodo == null:
		return lista
	_inorden_lista(nodo.izquierda, lista)
	lista.append(nodo.dato)
	_inorden_lista(nodo.derecha, lista)
	return lista
# Dentro de tu script Arbol.gd
func get_col(h: int) -> int: 
	if h == 1: 
		return 1 
	return get_col(h - 1) + get_col(h - 1) + 1

func print_tree_visual(root) -> String:
	var h = altura(root)
	if h == 0:
		return ""
	var col = get_col(h)
	var M = []
	for i in range(h):
		var row = []
		for j in range(col):
			row.append("") 
		M.append(row)

	_print_tree_matrix(M, root, int(col / 2), 0, h)

	var total_width = int(4 * pow(2, h - 1))
	var col_width = max(1, int(total_width / col))

	var texto = ""
	for i in range(h):
		for j in range(col):
			texto += pad_center(M[i][j], col_width)
		texto += "\n"
	return texto
	
func pad_center(s: String, width: int) -> String:
	var ln = s.length()
	if width <= ln:
		return s
	var total = width - ln
	var left = int(total / 2)
	var right = total - left
	return " ".repeat(left) + s + " ".repeat(right)
	
func _print_tree_matrix(M: Array, root, col: int, row: int, height: int) -> void:
	if root == null:
		return
	M[row][col] = str(root.dato)
	var offset = max(1, int(pow(2, height - 2))) # evita offset 0
	_print_tree_matrix(M, root.izquierda, col - offset, row + 1, height - 1)
	_print_tree_matrix(M, root.derecha, col + offset, row + 1, height - 1)
func mostrar_todo() -> void:
	print("---------------------------")
	print("Inorden:")
	inorden()
	print("\nPreorden:")
	preorden()
	print("\nPostorden:")
	postorden()
	print("\nAltura del árbol:", altura())
	print("Peso del árbol:", peso())
	print("---------------------------")
