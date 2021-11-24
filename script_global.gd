extends Node

const Ranking_Single = "http://narutin.freevar.com/viewTempoSingle.php?"
const Ranking_Duo = "http://narutin.freevar.com/viewTempoDuo.php?"

var kil_inimigo = 41 
var furia_raposa = 0
var furia_demon = 0
var vidas_naruto = 7
var vidas_sasuke = 7
var Multiplayer = false
var Selec_person = 1
var Status_som = true
var Status_music = true
var player = ""
var speed: float = 0.001;

#Gustavo mexeu aqui!
var contagem = false

func controlVida():
	if(furia_raposa>=10): 
		furia_raposa = 10 
	if(vidas_naruto>=7):
		vidas_naruto = 7
		
	if(furia_demon>=10): 
		furia_demon = 10 
	if(vidas_sasuke>=7):
		vidas_sasuke = 7
		
func reset():
	contagem = false
	speed = 0.001
	Multiplayer = false
	kil_inimigo = 41 
	furia_raposa = 0
	furia_demon = 0
	vidas_naruto = 7
	vidas_sasuke = 7
	
func _process(delta):
	
	#Gustavo mexeu aqui!
	if(contagem == true):
		speed += 0.001
		print(speed)
	else:
		pass





