extends KinematicBody2D

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y = -600

func _physics_process(_delta):
	var _change = move_and_slide(velocity)
