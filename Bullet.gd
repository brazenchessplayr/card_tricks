extends KinematicBody2D

var velocity = Vector2()
export var speed = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start_at(pos, dir = PI * 1.5):
	set_position(pos)
	set_rotation(dir)
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(_delta):
	var _change = move_and_slide(velocity)


func _on_Timer_timeout():
	queue_free()
