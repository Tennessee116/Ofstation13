/atom/movable/screen/screen_tip
	icon = null
	icon_state = null
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	screen_loc = "TOP,LEFT"
	maptext_height = 480
	maptext_width = 480
	maptext = ""

/atom/movable/screen/screen_tip/Initialize(mapload, _hud)
	. = ..()
	hud = _hud
	update_view()

/atom/movable/screen/screen_tip/proc/update_view(datum/source)
	if(!hud) //Might not have been initialized by now
		return
	maptext_width = DEFAULT_VIEW_SIZE * world.icon_size
