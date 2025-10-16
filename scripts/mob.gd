extends RigidBody2D

# chamado na inicialização do jogo
func _ready() -> void:
	# array com nomes das animações ["fly", "swim", "walk"]
	var animation_names = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# gera numero aleatorio entre 0 e tamanho do array - 1 (Entre o e 2 nesse caso)
	var random_index = randi() % animation_names.size()
	# Play na animação aleatória
	$AnimatedSprite2D.play(animation_names[random_index])
	
# chamado quando o Mob sai da tela	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# limpa o node Mob e seus filhos da memoria
	queue_free()
