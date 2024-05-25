extends Control

var array_general = null;

var array_granjero = Global_Dialogos.dialogos.dialogo_1.granjero;
var array_mago = Global_Dialogos.dialogos.dialogo_2.mago;
var array_caballero = Global_Dialogos.dialogos.dialogos_3.caballero;
var array_fuente = Global_Dialogos.dialogos.dialogos_4.fuente;
var array_fuente_no_abierta = Global_Dialogos.dialogos.dialogos_4.fuente_no_abierta;
var arrat_maria = Global_Dialogos.dialogos.dialogos_5.maria;
var array_juan = Global_Dialogos.dialogos.dialogos_6.juan;
var array_final_no_admitido = Global_Dialogos.dialogos.dialogos_7.final_no_admitido;
var arrat_final = Global_Dialogos.dialogos.dialogos_7.final;
@onready var childCollisionShape: CollisionShape2D = get_node("../Cofre/CollisionShape2D")

const icono_npc_1 = preload("res://art/kenney_tiny-dungeon/Tiles/tile_0086.png");
const icono_npc_2 = preload("res://art/kenney_tiny-dungeon/Tiles/tile_0111.png");
const icono_npc_3 = preload("res://art/kenney_tiny-dungeon/Tiles/tile_0087.png");
const icono_npc_4 = preload("res://art/kenney_tiny-dungeon/Tiles/tile_0020.png");
const icono_npc_5 = preload("res://art/kenney_tiny-dungeon/Tiles/tile_0099.png");
const icono_npc_6 = preload("res://art/kenney_tiny-dungeon/Tiles/tile_0088.png");
const icono_npc_final = preload("res://art/kenney_tiny-dungeon/Tiles/tile_0098.png");

var chat: int = 0;

func _ready():
	pass # Replace with function body.

func _activar_dialogos(TEXTO: String, IMAGEN: Texture) -> void:
	$Dialogos.show();
	$Dialogos/Label.text = TEXTO;
	$Dialogos/TextureRect.texture = IMAGEN;
	
func _process(_delta):
	pass
	
#NPC GRANJERO
func _on_area_2d_body_entered(body):
	if (body.is_in_group("inte")):
		_activar_dialogos(Global_Dialogos.dialogos.dialogo_1.granjero[chat], icono_npc_1);
		array_general = array_granjero;

func _on_area_2d_body_exited(body):
	if (body.is_in_group("inte")):
		$Dialogos.visible = false;
		
	
#NPC MAGO
func _on_mago_body_entered(body):
	if (body.is_in_group("inte_2")):
		_activar_dialogos(Global_Dialogos.dialogos.dialogo_2.mago[chat], icono_npc_2);
		array_general = array_mago;

func _on_mago_body_exited(body):
	if (body.is_in_group("inte_2")):
		$Dialogos.visible = false;

#NPC caballero
func _on_caballero_body_entered(body):
	if (body.is_in_group("caballero")):
		_activar_dialogos(Global_Dialogos.dialogos.dialogos_3.caballero[chat], icono_npc_3);
		array_general = array_caballero;

func _on_caballero_body_exited(body):
	if (body.is_in_group("caballero")):
		$Dialogos.visible = false;

#NPC fuente
func _on_fuente_body_entered(body):
	var agente_gato: int = Global_Dialogos.posiones;
	if (body.is_in_group("fuente") and agente_gato == 2):
		_activar_dialogos(Global_Dialogos.dialogos.dialogos_4.fuente[chat], icono_npc_4);
		array_general = array_fuente;
	elif (body.is_in_group("fuente") and agente_gato < 2):
		_activar_dialogos(Global_Dialogos.dialogos.dialogos_4.fuente_no_abierta[chat], icono_npc_4);
		array_general = array_fuente_no_abierta;

func _on_fuente_body_exited(body):
	if (body.is_in_group("fuente")):
		$Dialogos.visible = false;
		
#NPC maria
func _on_maria_body_entered(body):
	if (body.is_in_group("maria")):
		_activar_dialogos(Global_Dialogos.dialogos.dialogos_5.maria[chat], icono_npc_5);
		array_general = arrat_maria;
	
func _on_maria_body_exited(body):
	if (body.is_in_group("maria")):
		$Dialogos.visible = false;

#NPC juan

func _on_juan_body_entered(body):
	if (body.is_in_group("juan")):
		_activar_dialogos(Global_Dialogos.dialogos.dialogos_6.juan[chat], icono_npc_6);
		array_general = array_juan;

func _on_juan_body_exited(body):
	if (body.is_in_group("juan")):
		$Dialogos.visible = false;

#NPC final
func _on_final_body_entered(body):
	var hacha = Global_Dialogos.hacha;
	if (body.is_in_group("final") and hacha == 1):
		_activar_dialogos(Global_Dialogos.dialogos.dialogos_7.final[chat], icono_npc_final);
		childCollisionShape.set_deferred("disabled", false)
		array_general = arrat_final;
	elif (body.is_in_group("final") and hacha < 1):
		_activar_dialogos(Global_Dialogos.dialogos.dialogos_7.final_no_admitido[chat], icono_npc_final);
		array_general = array_final_no_admitido;
	
func _on_final_body_exited(body):
	if (body.is_in_group("final")):
		$Dialogos.visible = false;

#Control de chats	
func _input(event):
	if not event.is_action_pressed("next"):
		return
	chat += 1;
	if(chat == array_general.size()):
		chat = 0;
		$Dialogos.visible = false;
	else:
		$Dialogos.visible = true;
		$Dialogos/Label.text = array_general[chat];


