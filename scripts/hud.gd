extends CanvasLayer

signal start

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func show_game_over():
	show_message("Game Over!")
	await $MessageTimer.timeout
	
	$MessageLabel.text = "Dodge the Creeps"
	$MessageLabel.show()
	
	$StartButton.show()
	
	
func _on_message_timer_timeout() -> void:
	$MessageLabel.hide()
	
func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$MessageLabel.text = ""
	start.emit()
