/mob  // TODO: rewrite as obj. If more efficient
	var/mob/zshadow/shadow

/mob/zshadow
	name = "shadow"
	desc = "Z-level shadow"
	status_flags = GODMODE
	anchored = 1
	unacidable = 1
	density = 0
	opacity = 0					// Don't trigger lighting recalcs gah!
	vis_flags = VIS_HIDE
	layer = Z_MIMIC_LAYER
	plane = DEFAULT_PLANE
	//auto_init = FALSE 			// We do not need to be initialize()d
	var/mob/owner = null		// What we are a shadow of.

/mob/zshadow/can_fall()
	return FALSE

/mob/zshadow/New(var/mob/L)
	if(!istype(L))
		qdel(src)
		return
	..() // I'm cautious about this, but its the right thing to do.
	owner = L
	GLOB.dir_set_event.register(L, src, /mob/zshadow/proc/update_dir)
	GLOB.invisibility_set_event.register(L, src, /mob/zshadow/proc/update_invisibility)

/mob/Destroy()
	if(shadow)
		qdel(shadow)
		shadow = null
	. = ..()

/mob/zshadow/Destroy()
	GLOB.dir_set_event.unregister(owner, src, /mob/zshadow/proc/update_dir)
	GLOB.invisibility_set_event.unregister(owner, src, /mob/zshadow/proc/update_invisibility)
	. = ..()

/mob/zshadow/examine(mob/user, distance, infix, suffix)
	return owner.examine(user, distance, infix, suffix)

// Relay some stuff they hear
/mob/zshadow/hear_say(var/message, var/verb = "says", var/datum/language/language = null, var/alt_name = "", var/italics = 0, var/mob/speaker = null, var/sound/speech_sound, var/sound_vol)
	if(speaker && speaker.z != src.z)
		return // Only relay speech on our actual z, otherwise we might relay sounds that were themselves relayed up!
	if(is_living_mob(owner))
		verb += " from above"
	return owner.hear_say(message, verb, language, alt_name, italics, speaker, speech_sound, sound_vol)

/mob/living/proc/check_shadow()
	var/mob/M = src
	if(is_turf(M.loc))
		for(var/turf/simulated/open/OS = GetAbove(src); OS && istype(OS); OS = GetAbove(OS))
			//Check above
			if(!M.shadow)
				M.shadow = new /mob/zshadow(M)
			M.shadow.forceMove(OS)
			M = M.shadow

	// Clean up mob shadow if it has one
	if(M.shadow)
		var/client/C = src.client
		if(C && C.eye == M.shadow)
			src.reset_view(0)
		qdel(M.shadow)
		M.shadow = null

//Copy direction
/mob/zshadow/proc/update_dir()
	set_dir(owner.dir)


//Change name of shadow if it's updated too (generally moving will sync but static updates are handy)
/mob/fully_replace_character_name(var/new_name, var/in_depth = TRUE)
	. = ..()
	if(shadow)
		shadow.fully_replace_character_name(new_name)


/mob/zshadow/proc/update_invisibility()
	set_invisibility(owner.invisibility)
