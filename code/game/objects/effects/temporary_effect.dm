//A temporary effect that does not DO anything except look pretty.
/obj/effect/temporary
	anchored = 1
	unacidable = 1
	mouse_opacity = 0
	density = 0
	plane = DEFAULT_PLANE
	layer = ABOVE_MOB_LAYER

/obj/effect/temporary/Initialize(var/mapload, var/duration = 30, var/_icon = 'resources/icons/effects/effects.dmi', var/_state)
	. = ..()
	icon = _icon
	icon_state = _state
	QDEL_IN(src, duration)
