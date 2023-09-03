extends CharacterBody2D

var speed = 300
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_speed = -500
var lanzar_animation_playing = false

@onready var _animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var move_input = Input.get_action_strength("move_right2") - Input.get_action_strength("move_left2")

	if move_input < 0:
		if lanzar_animation_playing:
			_animated_sprite.play("run-verde")
		else:
			_animated_sprite.play("run")
		_animated_sprite.flip_h = true
	elif move_input > 0:
		if lanzar_animation_playing:
			_animated_sprite.play("run-verde")
		else:
			_animated_sprite.play("run")
		_animated_sprite.flip_h = false
	else:
		if is_on_floor():
			if lanzar_animation_playing:
				_animated_sprite.play("idle-verde")
			else:
				_animated_sprite.play("idle")
		else:
			_animated_sprite.stop() # Detiene la animación cuando está en el aire
		_animated_sprite.flip_h = true
	
	# Manejar el lanzamiento
	if Input.is_action_just_pressed("lanzar2"):
		_animated_sprite.play("lanzar")
		lanzar_animation_playing = true
		
		
		
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta

	var move_input = Input.get_action_strength("move_right2") - Input.get_action_strength("move_left2")

	# Handle Jump.
	if Input.is_action_just_pressed("move_up2"):
		if is_on_floor():
			if lanzar_animation_playing:
				_animated_sprite.play("jump-verde")
			else:
				_animated_sprite.play("jump")
			velocity.y = jump_speed

	if move_input != 0:
		velocity.x = move_input * speed
	else:
		velocity.x = 0

	move_and_slide()

# Agregar esta función para controlar el último frame de la animación de salto
func _on_AnimatedSprite2D_animation_finished():
	if _animated_sprite.animation == "jump":
		_animated_sprite.frame = _animated_sprite.frame_count - 1
	elif _animated_sprite.animation == "jump-verde":
		_animated_sprite.frame = _animated_sprite.frame_count - 1
		
	elif _animated_sprite.animation == "lanzar":
		_animated_sprite.frame = _animated_sprite.frame_count - 1
