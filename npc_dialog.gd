extends Control

const dialogs_npc = {
	0:[	
	"Hola gato,necesitamos tu ayuda",
	"un maligno tomo nuestro tesoro",
	"No puede ser!!",
	"¿Sabes de algun sospechoso?",
	"Si, pero cangrejo tiene mas informacion",
	"Hablare con el !!!",],
	1:[	
	"Necesito saber ¿por que tomaste el tesoro?",
	"Oh no, yo no fui",
	"me dijieron que te vieron tomarla",
	"No, no fui yo, fueron mis amigos",
	"¿Y en donde estan?",
	"Si lo quieres saber, debes de coleccionar",	
	"¿que cosa?",
	"10 posiones maginas",
	"estan en todo el mapa",	
],
	2:[	
	"Hola cangrejo, tu conoces al...",
	"Si! lo vi, era algo grande ",
	"¿quien era?",
	"era una cosa verde...",
	"siempre aparece con el señor de abajo",
	"Geracias cangrejo",

	],

	
}


var dialog_index
var current_npc
var tween: Tween
@onready var label = $RichTextLabel

func _ready():
	visible = false

	
func start(npc_id):
	visible = true
	dialog_index = 0
	current_npc = npc_id
	speak()
	
func speak():
	label.visible_ratio=0
	label.text = dialogs_npc[current_npc][dialog_index]
	tween = create_tween()
	var animation_speed = 0.02* label.text.length()
	tween.tween_property(label,"visible_ratio",1,animation_speed)
	dialog_index += 1

func next():
	if(dialog_index<dialogs_npc[current_npc].size()):
		speak()
	else:
		visible = false
		
func end_conversation():
	if(tween.is_running()):
		tween.kill()
	visible=false
func _input(event):
	if event.is_action_released("ui_accept"):
		next()

func _on_button_pressed():
	next()
