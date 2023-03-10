#include "nevastapol_areas.dm"
#include "nevastapol_shuttles.dm"

/datum/map_template/ruin/away_site/station_nevastapol
	name = "IDSS Nevastapol"
	id = "awaysite_station_nevastapol"
	description = "An independent deep-space colony, one can find opportunities for contracts and trading when visiting there."
	prefix = "resources/Haven/Maps/CommonAways/"
	suffixes = list("StationNevastapol/Maps/station_nevastapol_main.dmm")
	cost = 0
	accessibility_weight = 0
	template_flags = TEMPLATE_FLAG_SPAWN_GUARANTEED

/obj/effect/overmap/sector/station/nevastapol
	name = "IDSS Nevastapol"
	desc = "An independent deep-space colony, one can find opportunities for contracts and trading when visiting there."
	faction = "nevastapol"

	icon = 'resources/icons/obj/overmap.dmi'
	icon_state = "station_0"

	known = 1
	in_space = 0 // it is a huge station and the map is not good for bumping into from EVA.
	spawn_ships = FALSE
	//spawn_type = /mob/living/simple_animal/hostile/overmapship/nanotrasen/ntmerchant

	initial_restricted_waypoints = list(
		"Styx" = list("nav_nevastapol_1_styx"),
		"Eris" = list("nav_nevastapol_2_eris")
	)
