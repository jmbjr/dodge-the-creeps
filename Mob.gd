extends RigidBody2D

export (int) var MIN_SPEED = 150
export (int) var MAX_SPEED = 250

var mob_types = ["fly", "swim", "walk"]
export var mob_heights := [50, 35, 35]
export var mob_radii := [25, 35, 35 ]

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

	#Add the shape to the physics body:
	var shape_owner = create_shape_owner(self) #returns an int ID
	#need to rotate the capsule 90 degrees due to orientation of sprite and default rotation of capsuleshape2d
	var transform = Transform2D(-PI/2, Vector2(0,0))
	shape_owner_add_shape(shape_owner, capsule)
	shape_owner_set_transform(shape_owner, transform)

	update() #this calls the draw function

func _draw():
	pass
	#Draw the collision shape. Assumes the capsule has been rotated in _ready
	draw_circle(Vector2((height-2*radius)/2,0), radius, color)
	draw_circle(Vector2((2*radius-height)/2,0), radius, color)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
