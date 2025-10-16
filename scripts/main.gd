extends Node2D

var score = 0

func start_game():
	score = 0
	$StartTimer.start()
	$Player.start($StartPosition.position)

func _on_score_timer_timeout() -> void:
	score += 1

func _on_mob_timer_timeout() -> void:
	print("Criar novo inimigo!")
	
func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()
