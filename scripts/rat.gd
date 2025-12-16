extends CharacterBody2D

@export var speed = 50.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"../Player"
var health = 1
signal died

func _ready():
	animated_sprite.play("idle")
	
func _physics_process(delta: float) -> void:
	if not player:
		return
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed  # Changed order: direction first
	move_and_slide()
	
	if velocity.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
		
func play_hurt():
	animated_sprite.play("damage")
	animated_sprite.play("idle")
	
func take_damage():
	health -= 1
	play_hurt()
	if health <= 0:
		died.emit()
		queue_free()
