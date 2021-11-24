extends Area2D

var movE = Vector2(-5,0)
var arma = "shuriken"

func _ready():
	pass

func _process(delta):
	
	translate(movE)



func _on_DisparoE_area_entered(area):
	if (area.name == "LdD"):
		$".".queue_free()
	if(area.name == "DeletarObjetos"):
			$".".queue_free()
	if(area.name == "DeletarObjetos2"):
			$".".queue_free()
	if(area.name == "DeletarObjetos3"):
			$".".queue_free()
	if(area.name == "DeletarObjetos4"):
			$".".queue_free()
