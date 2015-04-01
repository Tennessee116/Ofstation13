//TODO: move mobs to a human damage system, add "crazy" mob, add "caller" mob.
//see civilian_mobs.dm for friendly NPCs //removed temporarily because runtimes

/mob/living/simple_animal/hostile/proc/HealBitches()
	stop_automated_movement = 1
	world << "IM BEING CALLED"
	if(!target_mob)
		stance = HOSTILE_STANCE_IDLE
		world << "FOUND YOUR ERROR"
	if(target_mob in ListTargets(10))
		walk_to(src, target_mob, 1, move_to_delay)
		world << "MOVING SMOOTHLY"
	if(get_dist(src, target_mob) <= 1)	//heal bitches
		target_mob.health = target_mob.health + 15
		stance = HOSTILE_STANCE_IDLE
		world << "HEALING BITCHES"
		return 1

/mob/living/simple_animal/hostile/proc/GetTheFuckOut()
	for(var/mob/living/simple_animal/hostile/M in oview(5, src))
		if(will_help && M.faction == faction)
			M.target_mob = src.target_mob

	stance = HOSTILE_STANCE_ATTACK

	step_away(src, target_mob)

	spawn(20)

	stance = HOSTILE_STANCE_IDLE

/mob/living/simple_animal/hostile/scom
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	icon = 'icons/uristmob/scommobs.dmi'
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	faction = "alien" //luv u corai. scom 5eva	//rip in peace corai

	icon_state = "necro_s"
	icon_living = "necro_s"
	icon_dead = "necro_d"

/mob/living/simple_animal/hostile/scom/lactera
	will_help = 1
	melee_damage_lower = 15
	melee_damage_upper = 15
	ranged = 1
	projectilesound = 'sound/weapons/laser.ogg'



/mob/living/simple_animal/hostile/scom/lactera/light
	will_flee = 1
	icon_state = "liz1"
	name = "Lactera Light Trooper"
	projectiletype = /obj/item/projectile/beam/scom/alien1

/mob/living/simple_animal/hostile/scom/lactera/medium
	icon_state = "liz2"
	name = "Lactera Trooper"
	projectiletype = /obj/item/projectile/beam/scom/alien2

/mob/living/simple_animal/hostile/scom/lactera/heavy
	icon_state = "liz3"
	name = "Lactera Heavy Trooper"
	rapid = 1
	projectiletype = /obj/item/projectile/beam/scom/alien2

/mob/living/simple_animal/hostile/scom/lactera/leader
	icon_state = "liz4"
	name = "Lactera Officer"
	projectiletype = /obj/item/projectile/beam/scom/alien3

/mob/living/simple_animal/hostile/scom/lactera/medic
	can_heal = 1
	icon_state = "lizm"
	name = "Lactera Medic"
	projectiletype = /obj/item/projectile/beam/scom/alien1

/mob/living/simple_animal/hostile/scom/allophylus
	icon_state = "allophylus"
	name = "Allophylus"
	ranged = 1
	projectiletype = /obj/item/projectile/beam/scom/alien4

/obj/item/projectile/beam/scom
	icon = 'icons/urist/items/uristweapons.dmi'

/obj/item/projectile/beam/scom/alien1
	name = "alien beam"
	icon_state = "alienprojectile"
	damage = 10

/obj/item/projectile/beam/scom/alien2
	name = "alien beam"
	icon_state = "alienprojectile"
	damage = 20

/obj/item/projectile/beam/scom/alien3
	name = "alien beam"
	icon_state = "alienprojectile"
	damage = 25

obj/item/projectile/beam/scom/alien4 //only ever encounter 1, so it's op
	name = "mind blast"
	icon_state = "" //INVISIBUL
	damage = 30
	stun = 5
	weaken = 5
	stutter = 5