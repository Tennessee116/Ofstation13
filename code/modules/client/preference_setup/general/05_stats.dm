/datum/preferences
	/// The list of stats the actually gets transferred to the mob when created.
	var/list/stats = list(
	VIGILANCE,
	APTITUDE,
	INTELLIGENCE,
	BODY
	)
	/// The amount of points they can use.
	var/stat_points = 10

/datum/category_item/player_setup_item/physical/stats
	name = "Stats"
	sort_order = 5

/datum/category_item/player_setup_item/physical/stats/load_character(savefile/S)
	from_file(S["stats"], pref.stats)

/datum/category_item/player_setup_item/physical/stats/save_character(savefile/S)
	to_file(S["stats"], pref.stats)

/datum/category_item/player_setup_item/physical/stats/sanitize_character(savefile/S)
	for(var/stat in pref.stats)
		pref.stats[stat] = 0

/datum/category_item/player_setup_item/physical/stats/content(mob/user)
	var/contents = list()
	contents += "<b>Stats:</b><br>"
	var/list/stat_decls = list()

	for(var/stat_path in pref.stats)
		stat_decls[stat_path] = decls_repository.get_decl(stat_path)

	for(var/stat in pref.stats)
		var/decl/stat/stat_decl = stat_decls[stat]

		contents += "<a href='?src=[REF(src)];[stat]=1'>[capitalize(stat_decl.name)]</a><br/>"

	contents += "[calculate_point_usage()] out of [pref.stat_points] stat points used."
	return jointext(contents, null)

/datum/category_item/player_setup_item/physical/stats/OnTopic(href, list/href_list, mob/user)
	for(var/stat in pref.stats)
		var/decl/stat/stat_decl = decls_repository.get_decl(stat)

		if(href_list["[stat]"])
			var/new_stat = input("Change your [stat_decl.name] stat [pref.stats[stat] ? "from [pref.stats[stat]]" : ""] to?s", CHARACTER_PREFERENCE_INPUT_TITLE) as null|num
			if(new_stat && CanUseTopic(user))
				if(calculate_point_usage() - pref.stats[stat] + new_stat >= pref.stat_points)
					to_chat(user, SPAN_WARNING("You don't have enough stat points. [pref.stat_points - calculate_point_usage()] points remaining!"))
					return FALSE
				else
					pref.stats[stat] = new_stat
					return TRUE

	return ..()

/// Calculates the remaining stat points
/datum/category_item/player_setup_item/physical/stats/proc/calculate_point_usage()
	var/used_points = 0

	for(var/stat in pref.stats)
		if(pref.stats[stat])
			used_points += pref.stats[stat]
		else
			continue

	return used_points