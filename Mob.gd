extends RigidBody2D

export (int) var MIN_SPEED = 100
export (int) var MAX_SPEED = 300

var mob_types = ["fly", "swim", "walk"]
export var mob_heights := [10, 30, 25]
export var mob_radii := [33, 33, 33 ]

var color = Color(0,0.7,0) #green color
var height
var radius
var mob_type_index

func _ready():
	mob_type_index = randi() % mob_types.size()
	$AnimatedSprite.animation = mob_types[mob_type_index]
	height = mob_heights[mob_type_index]
	radius = mob_radii[mob_type_index]

	#Make the collision shape:
	var capsule = CapsuleShape2D.new()
	capsule.height = height
	capsule.radius = radius

	#need to rotate the capsule 90 degrees due to orientation of sprite and default rotation of capsuleshape2d
	var transform = Transform2D(-PI/2, Vector2(0,0))
	$CollisionShape2D.shape = capsule
	$CollisionShape2D.set_transform(transform)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
