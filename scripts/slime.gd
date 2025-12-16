extends CharacterBody2D

@export var speed: float = 50.0  # Add type hint
@onready var animated_sprite = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"../Player"
var health = 1
signal died

func _ready():
	animated_sprite.play("idle")
	
func _physics_process(delta: float) -> void:
	if not player or speed == null:  # Add safety check
		return
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
	if velocity.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
		
func play_hurt():
	animated_sprite.play("damage")
	await animated_sprite.animation_finished
	animated_sprite.play("idle")
	
func take_damage():
	health -= 1
	play_hurt()
	if health <= 0:
		died.emit()
		queue_free()
