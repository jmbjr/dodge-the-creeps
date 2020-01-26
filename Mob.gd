extends RigidBody2D

export (int) var MIN_SPEED
export (int) var MAX_SPEED

var mob_types = ["fly", "swim", "walk"]

var max_extent_dim = 100 # 2*maximum heigt/width allowed
var min_extent_dim = 10 # 2*minimum height/width allowed

var rect #this will be used for drawing the rectangle
var color = Color(0,0.7,0) #green color

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	var extents = Vector2(50,200)
	randomize()
#	extents.x = min_extent_dim + (max_extent_dim - min_extent_dim)*randf()
#	extents.y = min_extent_dim + (max_extent_dim - min_extent_dim)*randf()
	
	#Making the collision shape:
	var box = RectangleShape2D.new()
	box.extents = extents

	#Adding the shape to the KinematicBody2D:
	var shape_owner = create_shape_owner(self) #returns an int ID
	shape_owner_add_shape(shape_owner, box)

	#Drawing the box (extants are double the width and height):
	rect = Rect2(-extents.x, -extents.y, 2*extents.x, 2*extents.y)
	update() #this calls the draw function

func _draw():
	#Drawing the rectangle. 
	#You could replace this with a scaled sprite
	draw_rect(rect, color)
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
