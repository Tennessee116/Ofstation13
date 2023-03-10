/obj/item/weapon/grenade/anti_photon
	desc = "An experimental device for temporarily removing light in a limited area."
	name = "photon disruption grenade"
	icon = 'resources/icons/obj/grenade.dmi'
	icon_state = "emp"
	item_state = "emp"
	det_time = 20
	origin_tech = list(TECH_BLUESPACE = 4, TECH_MATERIAL = 4)

/obj/item/weapon/grenade/anti_photon/detonate()
	playsound(src.loc, 'resources/sound/effects/phasein.ogg', 50, 1, 5)
	set_light(-1, 6, 10, 2, "#ffffff")

	var/extra_delay = rand(0,90)

	spawn(extra_delay)
		spawn(200)
			set_light(1, 1, 10, 2, "#[num2hex(rand(64,255))][num2hex(rand(64,255))][num2hex(rand(64,255))]")
			playsound(src.loc, 'resources/sound/effects/bang.ogg', 50, 1, 5)
		spawn(210)
			..()
			qdel(src)
