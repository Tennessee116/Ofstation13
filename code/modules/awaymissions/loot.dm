/obj/effect/spawner/lootdrop
	icon = 'resources/icons/mob/screen1.dmi'
	icon_state = "x2"
	var/lootcount = 1		//how many items will be spawned
	var/lootdoubles = 0		//if the same item can be spawned twice
	var/loot = ""			//a list of possible items to spawn- a string of paths

/obj/effect/spawner/lootdrop/Initialize()
	..()
	var/list/things = params2list(loot)

	if(things && things.len)
		for(var/i = lootcount, i > 0, i--)
			if(!things.len)
				return

			var/loot_spawn = pick(things)
			var/loot_path = text2path(loot_spawn)

			if(!loot_path || !lootdoubles)
				things.Remove(loot_spawn)
				continue

			new loot_path(get_turf(src))
	return INITIALIZE_HINT_QDEL

/obj/effect/closet_loader //Map loader messes up closets
	icon = 'resources/icons/mob/screen1.dmi'
	icon_state = "x2"

/obj/effect/closet_loader/Initialize()
	..()
	var/turf/T = get_turf(loc)
	var/obj/structure/closet/C = locate() in T
	if(!C)
		return INITIALIZE_HINT_QDEL
	for(var/obj/O in T.contents)
		if(!O.simulated || O.density)
			continue
		O.forceMove(C)
	return INITIALIZE_HINT_QDEL
