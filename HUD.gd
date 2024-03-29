extends CanvasLayer

signal start_game

func _input(event: InputEvent) -> void:
    if $StartButton.visible:
        if Input.is_action_pressed("ui_accept"):
            _on_StartButton_pressed()

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	