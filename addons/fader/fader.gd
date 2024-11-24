extends CanvasLayer

const ALPHA_SPEED : float = 1
const ALPHA_EASING : float = -1.6
const COLOR_SPEED : float = 30
const COLOR_EASING : float = -1.6
@onready var fill : ColorRect = $Fill
@onready var next_color : Color = $Fill.color
@onready var previous_color : Color = $Fill.color
var s : float = 1
var cs : float = 1
var alpha_speed : float = ALPHA_SPEED
var color_speed : float = COLOR_SPEED

func snap_to_black(): await fade(Color.BLACK, INF)
func snap_to_white(): await fade(Color.WHITE, INF)
func snap_to_clear(): await fade(get_clear_color(), INF)
func snap_to(color : Color): await fade(color, INF)

func fade_to_black(): await fade(Color.BLACK, ALPHA_SPEED)
func fade_to_white(): await fade(Color.WHITE, ALPHA_SPEED)
func fade_to_clear(): await fade(get_clear_color(), ALPHA_SPEED)
func fade_to(color : Color): await fade(color, ALPHA_SPEED)

func fade_to_black_at(speed : float): await fade(Color.BLACK, speed)
func fade_to_white_at(speed : float): await fade(Color.WHITE, speed)
func fade_to_clear_at(speed : float): await fade(get_clear_color(), speed)

func fade(to_color : Color, at_speed : float):
	alpha_speed = at_speed
	color_speed = max(COLOR_SPEED, alpha_speed)
	previous_color = fill.color
	next_color = to_color
	if previous_color.a <= 0.001:
		previous_color.r = to_color.r
		previous_color.g = to_color.g
		previous_color.b = to_color.b
	s = 0
	cs = 0
	update_interactability()
	if at_speed == INF:
		s = 1
		cs = 1
		fill.color = to_color
	else:
		while s < 1:
			await Engine.get_main_loop().process_frame
	
func get_clear_color() -> Color:
	var color = fill.color
	color.a = 0
	return color

func update_interactability():
	if next_color.a > 0.5:
		fill.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		fill.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _ready():
	update_interactability()

func _process(delta: float):
	s = move_toward(s, 1, delta * alpha_speed)
	cs = move_toward(cs, 1, delta * color_speed)
	fill.color.r = lerp(previous_color.r, next_color.r, ease(cs, COLOR_EASING))
	fill.color.g = lerp(previous_color.g, next_color.g, ease(cs, COLOR_EASING))
	fill.color.b = lerp(previous_color.b, next_color.b, ease(cs, COLOR_EASING))
	fill.color.a = lerp(previous_color.a, next_color.a, ease(s, ALPHA_EASING))
