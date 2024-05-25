extends Node

var npc_1: bool = false;
var npc_2: bool = false;

var posiones: int = 0;
var hacha: int = 0;

const dialogos:Dictionary = {
	'dialogo_1': {
		'granjero': ["Hola, necesitamos de tu ayuda", "La espada milenaria no esta", "Ayudanos a dar con   ella, PORFAVOR"]
	},
	
	'dialogo_2': {
		'mago' : ["Asi que tu eres quien nos ayudara", "La fuente magica       sabe donde esta", "Pero no te dira nada a menos..."]
	},
	
	'dialogos_3': {
		'caballero': ["Hablaste con ese       mago", "Supongo que te dijo   algo", "Yo solo se algo y        nada mas",
		"La fuente necesita de dos posiones", "Ve y buscalas.. Suerte"
		]
	},
	
	'dialogos_4': {
		'fuente' : ["Has conseguido lo     que deseo", "Mis preciadas             posiones", "Yo se quien puede     ayudarte", "Ve y busca a Maria",
		"Ella sabe donde esta   la espada", "Surte..."],
		
		'fuente_no_abierta': ["Tienes posiones?", "Si no tienes mis         posiones",  "No te dire nada..."]
	},
	
	'dialogos_5': {
		'maria' : ["Hola, en que puedo   ayudarte", "Buscas la espada     milenaria", "El granjero juan la      tomo por error",
		"Pero el no te la va a   dar asi nomas", "Tienes que darle un   hacha nueva", "Luis te puede ayudar en eso", "Ve y habla con el..."]
	},
	
	'dialogos_6': {
		'juan': ["Hola, buscas un         hacha", "Puedo darte la que    tengo", "Tomala sin problema", "Espero que te sirva"]
	},
	
	'dialogos_7':{
		'final_no_admitido': ["Mmm, quiero un       hacha nueva", "Si no tienes un hacha", "No te dara la               espada..."],
		'final': ["Por fin un hacha        nueva", "Ve y toma el cofre", "Ahi esta lo que           necesitas...", "GRACIAS"],
	},
}

func _ready():
	pass

func _process(_delta):
	pass
