extends Node2D

@export var speed := 350
@export var max_distance := 300
@export var detect_radius := 24

@onready var player := $"bat"

func _physics_process(delta):
	var dir := Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1

	if dir != Vector2.ZERO:
		position += dir.normalized() * speed * delta

	# circular leash
	if position.length() > max_distance:
		position = position.normalized() * max_distance

	check_enemy_overlap()


func check_enemy_overlap():
	var enemies = get_tree().get_nodes_in_group("Enemy")

	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)

		if dist <= detect_radius:
			print("enemy detected")
			return

	print("all clear")
