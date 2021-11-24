extends Node2D


func _ready():
	if(ScriptGlobal.Multiplayer == true):
		$HTTPRequest.request(ScriptGlobal.Ranking_Single)
	else:
		$HTTPRequest.request(ScriptGlobal.Ranking_Duo)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	#print(body.get_string_from_utf8())
	$Label.text = "1 Jogador\n" + body.get_string_from_utf8()
	pass # Replace with function body.
