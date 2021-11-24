extends Area2D

var movD = Vector2(5,0)

func _ready():
	pass 

func _process(delta):
	translate(movD)

func _on_Timer_timeout():
	queue_free()

func Atingir_com_Shuriken():
	if(ScriptGlobal.Status_som == true):
		$AtingirShuri.play()


func _on_Disparo_area_entered(area):
	if(area.name == "LdE" or area.name == "LdD"):
		Atingir_com_Shuriken()
		$AnimatedSprite.visible = false


func _on_Disparo_body_entered(body):
	if(body.is_in_group("obj")):
		$".".queue_free()
	if(body.name == "Itachi"):
		get_tree().change_scene("res://cena_vitoria_multiplayer.tscn")

func _on_AtingirShuri_finished():
	get_parent().get_node("Disparo").queue_free()
