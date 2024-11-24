extends Node

func _ready():
	$Fader.snap_to_black()
	$Fader.fade_to_clear()
	
func _go_red():
	await $Fader.fade_to_black()
	$GreenScreen.hide()
	$BlueScreen.hide()
	$RedScreen.show()
	$Fader.fade_to_clear()

func _go_green():
	await $Fader.fade_to_white()
	$BlueScreen.hide()
	$RedScreen.hide()
	$GreenScreen.show()
	$Fader.fade_to_clear()

func _go_blue():
	await $Fader.fade_to(Color.MAGENTA)
	$RedScreen.hide()
	$GreenScreen.hide()
	$BlueScreen.show()
	$Fader.fade_to_clear()
