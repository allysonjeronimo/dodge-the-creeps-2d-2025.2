extends Area2D

signal hit

var screen_size
var speed = 400
var velocity = Vector2.ZERO

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
# _ready() função de inicialização, executa depois de todos
# os nodes da cena iniciarem	
func _ready():
	# obtem tamanho da tela
	screen_size = get_viewport_rect().size
	hide()
	
# Chamado em loop 
func _process(delta):
	update_movement(delta)
	update_animations()
	
func update_movement(delta):
	# inicialmente a velocity é zero
	velocity = Vector2.ZERO
	
	# se pressionar para direita, esquerda, 
	# cima ou baixo, muda a velocity
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
		
	# incrementa posição baseado na multiplicação da velocity, speed e delta
	position += velocity * speed * delta
	# mantem player dentro do limite da tela
	position = position.clamp(Vector2.ZERO, screen_size)
		
func update_animations():
	# Atualizando as animações
	if velocity.length() != 0:
		if velocity.x != 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = velocity.x < 0
			$AnimatedSprite2D.flip_v = false
		if velocity.y != 0:
			$AnimatedSprite2D.play("up")
			$AnimatedSprite2D.flip_v = velocity.y > 0
	else:
		$AnimatedSprite2D.stop()

# Chamado quando inimigo colidir com Player
func _on_body_entered(body: Node2D) -> void:
	# Esconde playr
	hide()
	# Emite signal Hit (Para avisar o main)
	hit.emit()
	# Desativa colisor
	$CollisionShape2D.set_deferred("disabled", true)
