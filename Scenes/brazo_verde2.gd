extends RigidBody2D

var speed = 0


@onready var _animated_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	_animated_sprite.play("rotar")


func _on_body_entered(body: Node2D):
	_animated_sprite.play("tirado")
	queue_free()
