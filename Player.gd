extends KinematicBody2D

signal got_hit

export (PackedScene) var Bullet
export var speed = 400
var screen_size
onready var bullet_node = get_node("BulletContainer")

var direction = PI * 1.5

func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		direction = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		direction = PI
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		direction = PI / 2
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		direction = PI * 1.5
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		shoot()	
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	set_rotation(direction)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered(_body):
	hide()  # Player disappears after being hit.
	emit_signal("got_hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func shoot():
	var bullet = Bullet.instance()
	bullet_node.add_child(bullet)
	bullet.start_at(get_position(), get_rotation())
