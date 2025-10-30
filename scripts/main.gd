extends Node2D

var score = 0
@export var mob_scene: PackedScene

func _ready() -> void:
	pass
	
func start_game():
	score = 0
	$StartTimer.start()
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")

func game_over():
	$MobTimer.stop()
	$ScoreTimer.stop()
	$HUD.show_game_over()
	
func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout() -> void:
	# cria novo inimigo
	var new_mob = mob_scene.instantiate()
	# obtem o path follow 2d
	var path_follow_2d = $Path2D/PathFollow2D
	# geramos um progressb ratio randomicamente (entre 0.0 e 1.0)
	path_follow_2d.progress_ratio = randf()
	# pegamos a posição do path follow e colocamos no inimigo
	new_mob.position = path_follow_2d.position
	# pegamos a rotação do path follow e rotacionamos 90 graus
	new_mob.rotation = path_follow_2d.rotation + PI / 2
	# adicionamos uma rotação alearório entre -45 graus e 45 graus
	new_mob.rotation += randf_range(-PI/4, PI/4)
	
	var random_x = randf_range(100.0, 250.0)
	var velocity = Vector2(random_x, 0)
	new_mob.linear_velocity = velocity.rotated(new_mob.rotation)
	
	# adicionamos o inimigo na cena
	add_child(new_mob)
	
func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()
