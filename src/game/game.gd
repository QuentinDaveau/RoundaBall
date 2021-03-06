extends Node


func _ready() -> void:
	get_tree().get_nodes_in_group("fall_detector")[0].connect("ball_fell", self, "_on_FallDetector_ball_fell")
	SceneManager.set_transition_gradient($BackGroundLoader.get_background().get_gradient())


func _on_FallDetector_ball_fell(ball: RigidBody2D) -> void:
	ball.sleeping = true
	ball.set_deferred("mode", ball.MODE_STATIC)
	$GameUI.disable_pause_button()
	CameraManager.add_shake(100)
	yield(get_tree().create_timer(0.75), "timeout")
	$GameUI.play_game_over($ScoreManager.fix_score())


func _start_game() -> void:
	pass


func _pause_game() -> void:
	pass
