# Overview

Addon offers easy to use fader. The most typical usage is for transitions:

```
func _transition():
	await $Fader.fade_to_black()
	# hide/unload old stuff
	# show/load new stuff
	$Fader.fade_to_clear()
```

Noteworthy features:
- blocks mouse input on fade out (but allows on fade in)
- fading can be awaited
- allows fading out to any color in addition to standard ```fade_to_black``` and ```fade_to_white```
- allows fade speed customization

## Usage

To add fader to your game, just make sure there's an instance of ```addons/fader/fader.tscn``` in your scene. Then you can use the Fader node using the following API:

```
func snap_to_black()
func snap_to_white()
func snap_to_clear()
func snap_to(color : Color)

func fade_to_black()
func fade_to_white()
func fade_to_clear()
func fade_to(color : Color)

func fade_to_black_at(speed : float)
func fade_to_white_at(speed : float)
func fade_to_clear_at(speed : float)

func fade(to_color : Color, at_speed : float)
```

To fade in on the game start, you can use snap_* function followed by fade_to_clear:

```
func _ready():
	$Fader.snap_to_black()
	$Fader.fade_to_clear()
```

## Settings

By default, fading happens with the speed of 1, which means that the transition from fully transparent to fully opaque state will take 1 second.

In additional to specifying custom fade speed in the ```fade_to_*_at(speed : float)``` You can modify ```ALPHA_SPEED``` constant in ```addons/fader/fader.gd``` script to change global fading speed.

You'll also find some other constants for modification, like easing curve selection.

## Demo

Try playing ```demo.tscn```, you'll be able to transition through some example screens using different fade colors. Also, on the demo start screen fades from black.
