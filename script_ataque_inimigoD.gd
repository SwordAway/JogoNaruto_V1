extends Area2D

var movD = Vector2(5,0)

func _ready():
	pass 

func _process(delta):
	translate(movD)

# Some quando atinge a Area2D do personagem (lado Esquerdo)
func _on_FoiceD_area_entered(area):
	if(area.name == "HitE"):
		$".".queue_free()
		
	if(area.name == "Bola_de_Fogo"):
		$".".queue_free()

#Fazer sumir quando atingir um Bloco
func _on_FoiceD_body_entered(body):
	if(body.is_in_group("obj")):
		$".".queue_free()

func _on_Timer_timeout():
	$".".queue_free()
