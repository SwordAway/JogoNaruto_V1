extends Area2D

var movD = Vector2(5,0)


func _process(delta):
	translate(movD)

func _on_Timer_timeout():
	$AnimatedSprite.play("fogosome")
	movD.x = 1

func _on_Bola_de_Fogo_area_entered(area):
	if(area.name == "LdE" or area.name == "LdD"):
		movD.x = 0
		$AnimatedSprite.play("fogosome")
		$CollisionShape2D.queue_free()


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "fogosome"):
		get_parent().get_node("Bola_de_Fogo").queue_free()

# Quando Atinge uma parede e etc
func _on_Bola_de_Fogo_body_entered(body):
	if(body.is_in_group("obj")):
		$AnimatedSprite.play("fogosome")
		$CollisionShape2D.queue_free()
		movD.x = 0
