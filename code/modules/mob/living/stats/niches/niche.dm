/// Practically special abilities and qualities.
/mob/living/var/list/niches = list()

/// Assign a niche
/mob/living/proc/assign_niche(decl/niche/assign)
	niches += assign
	assign.on_gain(src)

/// The niches for each stat. Niches populate this, not vice-versa.
/decl/stat/var/niches = list()

/// The actual ability.
/decl/niche
	/// Self-explanatory.
	var/name = "developer incompetence"
	/// A basic description.
	var/desc = "The ability to report this to a developer."
	/// The appropiate associated stat.
	var/decl/stat/parent_stat

/decl/niche/Initialize()
	..()
	if(parent_stat)
		parent_stat = decls_repository.get_decl(parent_stat)

/// Anything that needs to be done when the mob gains this niche.
/decl/niche/proc/on_gain(mob/living/affected)
	return to_chat(affected, SPAN_WARNING("You feel different."))