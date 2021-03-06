extends RigidBody2D


onready var _initial_sprite_scale: Vector2 = $Upscaler.scale
onready var _initial_collision_scale: float = $CollisionShape2D.get_shape().get_radius()
onready var _initial_trail_scale: float = $Trail.width

var _disable_semaphore: int = 0
var _scale_multiplier: float = 0


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	state = $BallPowerUpReceiver.process_state(state)
	if state.get_contact_count() >= 1:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("bounce")


func change_scale(scale_multiplier: float) -> void:
	if _scale_multiplier != 0:
		return
	gravity_scale = 0.7
	linear_damp = 0.4
	_scale_multiplier = scale_multiplier
	$CollisionShape2D.get_shape().set_radius(scale_multiplier * _initial_collision_scale)
	$Tween.interpolate_property($Upscaler, "scale", $Upscaler.scale, _initial_sprite_scale * scale_multiplier, 0.5,\
			Tween.TRANS_BACK, Tween.EASE_OUT)
	$Tween.interpolate_property($Trail, "width", $Trail.width, _initial_trail_scale * scale_multiplier * 0.8,\
			0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()


func reset_scale() -> void:
	if _scale_multiplier == 0:
		return
	gravity_scale = 1
	linear_damp = -1
	$CollisionShape2D.get_shape().set_radius(_initial_collision_scale)
	$Tween.interpolate_property($Upscaler, "scale", $Upscaler.scale, _initial_sprite_scale, 0.5,\
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Trail, "width", $Trail.width, _initial_trail_scale,\
			0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	_scale_multiplier = 0


func disable_block_collision() -> void:
	_disable_semaphore += 1
	set_collision_mask_bit(1, false)


func enable_block_collision() -> void:
	_disable_semaphore -= 1
	if _disable_semaphore <= 0:
		set_collision_mask_bit(1, true)
