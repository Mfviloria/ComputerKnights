extends RichTextLabel

var speed = 0.08
var textos = [
	"Mira a quien tenemos aquí...",
	"No te voy a dejar pasar tan facil caballerito "
]

var power_growing = false
var power_speed = 2.0 

func _ready():
	if not Global.texto_mostrado:
		$"../Mails".visible = false
		$"../Power".visible = false
		$"../AnimatedSprite2D".play("idle")
		bbcode_enabled = true
		clear()
		await mostrar_textos()
		Global.texto_mostrado = true
	elif Global.texto_mostrado and Global.perdio:
		$"../Mails".visible = false
		$"../Power".visible = false
		$"../AnimatedSprite2D".play("idle")
		bbcode_enabled = true
		textos.clear()
		textos = ["JAJAJAJA", "Has caído como un ingenuo.", "Tendrás otra oportunidad para que no te sientas mal."]
		await mostrar_textos()
	else:
		$"../Mails".visible = false
		$"../Power".visible = false
		$"../AnimatedSprite2D".play("Hurt")
		textos.clear()
		textos = ["NOOOOO", "No has caído en mi trampa.", "Te has salvado del fishing caballero."]
		mostrar_textos()
		

func mostrar_textos() -> void:
	for t in textos:
		text = ""
		for char in t:
			text += char
			await get_tree().create_timer(speed).timeout
		await get_tree().create_timer(1.0).timeout

	if !Global.texto_mostrado:
		$"../AnimatedSprite2D".play("attack")
		$"../Power".visible = true
		$"../Power".play("default")
	elif Global.texto_mostrado and Global.perdio:
		$"../AnimatedSprite2D".play("attack")
		$"../Power".visible = true
		$"../Power".play("default")
	else:
		$"../AnimatedSprite2D".play("death")
		
		await get_tree().change_scene_to_file("res://Scenes/seleccion.tscn")

func _on_power_animation_finished() -> void:
	$"../Mails".visible = true
