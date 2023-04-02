extends Control

var respostas = []
var selecionada = {}

@onready var Texto = $VBoxContainer/Texto
@onready var InputJogador = $VBoxContainer/HBoxContainer/InputJogador

func _ready():
	seleciona_historia()
	verifica_fim()

func seleciona_historia():
	randomize()
	var qtd = $Historias.get_child_count()
	var indice = randi() % qtd
	var sorteada = $Historias.get_child(indice)
	
	selecionada.perguntas = sorteada.perguntas
	selecionada.texto = sorteada.texto
	
func verifica_fim():
	if respostas.size() == selecionada.perguntas.size(): 
		contar_historia()
	else:
		proxima_pergunta()
		
func contar_historia():
	Texto.text = selecionada.texto % respostas
	InputJogador.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Jogue Novamente"
	
func proxima_pergunta():
	Texto.text += "Porfavor, me diga " + selecionada.perguntas[respostas.size()] + "."
	InputJogador.grab_focus()
	
	
func _on_input_jogador_text_submitted(new_text):
	salva_resposta(new_text	)

func _on_botao_pressed():
	if respostas.size() == selecionada.perguntas.size():
		get_tree().reload_current_scene()
	else: 
		salva_resposta(InputJogador.text)
	
func salva_resposta(texto):
	respostas.append(texto)
	InputJogador.clear()
	Texto.text = ""
	verifica_fim()
