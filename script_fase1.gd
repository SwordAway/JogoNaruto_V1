extends Node2D


func _on_Morte_body_entered(body):
	if(body.is_in_group("Personagem")):
		get_tree().change_scene("res://cena_game_over.tscn")

