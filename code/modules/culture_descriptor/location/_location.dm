/decl/cultural_info/location
	desc_type = "Home System"
	secondary_langs = list(
		LANGUAGE_SIGN
	)
	category = TAG_HOMEWORLD
	var/distance
	var/ruling_body = FACTION_SOL_CENTRAL
	var/capital

/decl/cultural_info/location/get_text_details()
	. = list()
	if(!isnull(capital))
		. += "<b>Capital:</b> [capital]."
	if(!isnull(ruling_body))
		. += "<b>Territory:</b> [ruling_body]."
	if(!isnull(distance))
		. += "<b>Distance from Sol:</b> [distance]."
	. += ..()
