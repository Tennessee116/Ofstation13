/// These constants exist solely for ease of not writing the path. They contribute nothing mechanically.
var/const/VIGILANCE	= /decl/stat/vigilance
var/const/APTITUDE	= /decl/stat/aptitude
var/const/INTELLIGENCE	= /decl/stat/intelligence
var/const/BODY	= /decl/stat/body

/mob/living
	/// The raw list of stats for a mob.
	var/list/stats = list()
	/// Preset stats.
	var/list/preset_stats = list()
	/// Whether or not to acocunt for stats in this mob's activity. Determines whether or not stats are populated on Initialize().
	var/stat_user = TRUE

/// Assigns stats. If the stat is predefined in preset stats, just fetches it.
/mob/living/proc/assign_stats()
	if(stat_user)
		for(var/decl/stat/preexisting in preset_stats)
			var/decl/stat/assign_preexisting = decls_repository.get_decl(preexisting)
			stats[assign_preexisting] = preset_stats[preexisting]
			to_chat(src, SPAN_WARNING("You feel a sense of [assign_preexisting.name]."))

		for(var/stat_path in subtypesof(/decl/stat))
			var/decl/stat/assign_stat = decls_repository.get_decl(stat_path)
			if(assign_stat in stats)
				continue
			else
				stats[assign_stat] = rand(1, 10)
				to_chat(src, SPAN_WARNING("You feel a sense of [assign_stat.name]."))

/// Modify a stat's value.
/mob/living/proc/change_stat(decl/stat/target, new_value)
	to_chat(src, SPAN_WARNING("Your [target.name] has [new_value >= stats[target] ? "improved" : "worsened"]."))
	stats[target] = new_value

/// Performs a raw stat check. Checks a stat against a target value.
/mob/living/proc/check_stat(decl/stat/target, target_value)
	to_chat(src, "WE ROLLIN [uppertext(target)]")
	if(stats[target] > target_value)
		return TRUE
	else
		return FALSE

/// Returns prob() based on a stat's value.
/mob/living/proc/prob_stat(decl/stat/target)
	to_chat(src, "WE ROLLIN [uppertext(target)]")
	return prob(10 * stats[target] * (health/100))

/// Returns a rand() modified by a stat's value and a modifier for making it applicable in any circumstance.
/mob/living/proc/rand_stat(decl/stat/target, modifier = 1)
	to_chat(src, "WE ROLLIN [uppertext(target)]")
	return rand(1, 10) * stats[target] * (health/100) * modifier

/// A generic stat.
/decl/stat
	/// Self-explanatory.
	var/name = "mental illness"

/decl/stat/vigilance
	name = "vigilance"

/decl/stat/aptitude
	name = "aptitude"

/decl/stat/intelligence
	name = "intelligence"

/decl/stat/body
	name = "body"