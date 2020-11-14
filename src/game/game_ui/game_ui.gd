extends CanvasLayer


func play_game_over() -> void:
	$GameOverPanel.play_game_over()


func _on_ScoreManager_score_updated(new_score: int, break_score_added: int) -> void:
	# To do: add point effect if break_score_added
	$UIRoot/MarginContainer/HBoxContainer/VBoxContainer/ScoreLabel.bbcode_text = "[right]" + String(new_score) + "[/right] "


func _on_PauseButton_meta_clicked(meta) -> void:
	get_tree().paused = true
	$PausePanel.appear()
