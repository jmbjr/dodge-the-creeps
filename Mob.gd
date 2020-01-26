extends RigidBody2D

export (int) var MIN_SPEED
export (int) var MAX_SPEED

var mob_types = ["fly", "swim", "walk"]
#var mob_types = ["fly", "fly", "fly"]
export var mob_heights := [30, 45, 45]
export var mob_radii := [30, 40, 40 ]

var color = Color(0,0.7,0) #green color
var height
var radius
var mob_type_index
func _ready():
	mob_type_index = randi() % mob_types.size()
	$AnimatedSprite.animation = mob_types[mob_type_index]
	height = mob_heights[mob_type_index]
	radius = mob_radii[mob_type_index]
	#Making the collision shape:
	var capsule = CapsuleShape2D.new()
	capsule.height = height
	capsule.radius = radius

	#Adding the shape to the KinematicBody2D:
	var shape_owner = create_shape_owner(self) #returns an int ID
	shape_owner_add_shape(shape_owner, capsule)

	#Drawing the box (extants are double the width and height):
#	rect = Rect2(-extents.x, -extents.y, 2*extents.x, 2*extents.y)
	#rect = Rect2(-radius/2, -height/2, 2*radius, 2*height)
	update() #this calls the draw function

func _draw():
	#Drawing the rectangle. 
	#You could replace this with a scaled sprite
#	draw_rect(rect, color)
	draw_circle(Vector2((height-radius)/2,0), radius, color)
	draw_circle(Vector2((radius-height)/2,0), radius, color)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
