/datum/species/skrell
	name = SPECIES_SKRELL
	name_plural = SPECIES_SKRELL
	icobase = 'resources/icons/mob/human_races/species/skrell/body.dmi'
	deform = 'resources/icons/mob/human_races/species/skrell/deformed_body.dmi'
	preview_icon = 'resources/icons/mob/human_races/species/skrell/preview.dmi'
	primitive_form = "Neaera"
	unarmed_types = list(/datum/unarmed_attack/punch)
	description = "A species of amphibious, colorful aliens, Skrell are relatively new to the galactic stage. \
	While their technology is about on par with humans in most regards, excelling in a few fields, they are relatively weak in military strength, \
	forcing them to rely on their human allies for protection. They are herbivores, and generally prefer to resolve situations with words instead of force. \
	Skrell are divided into three main castes, which determines their social status and role in society, with these castes being assigned based on their \
	abilities and temperament in their youth."
	health_hud_intensity = 1.75
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/fish/octopus
	genders = list(PLURAL)

	min_age = 19
	max_age = 90

	burn_mod = 0.9
	oxy_mod = 1.3
	flash_mod = 1.2
	toxins_mod = 0.8
	siemens_coefficient = 1.3
	warning_low_pressure = WARNING_LOW_PRESSURE * 1.4
	hazard_low_pressure = HAZARD_LOW_PRESSURE * 2
	warning_high_pressure = WARNING_HIGH_PRESSURE / 0.8125
	hazard_high_pressure = HAZARD_HIGH_PRESSURE / 0.84615

	body_temperature = null // cold-blooded, implemented the same way nabbers do it

	darksight_range = 4
	darksight_tint = DARKTINT_MODERATE

	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR

	flesh_color = "#8cd7a3"
	blood_color = "#1d2cbf"
	base_color = "#006666"
	organs_icon = 'resources/icons/mob/human_races/species/skrell/organs.dmi'

	cold_level_1 = 280 //Default 260 - Lower is better
	cold_level_2 = 220 //Default 200
	cold_level_3 = 130 //Default 120

	heat_level_1 = 420 //Default 360 - Higher is better
	heat_level_2 = 480 //Default 400
	heat_level_3 = 1100 //Default 1000

	reagent_tag = IS_SKRELL

	override_limb_types = list(BP_HEAD = /obj/item/organ/external/head/skrell)

	descriptors = list(
		/datum/mob_descriptor/height = 1.2,
		/datum/mob_descriptor/build = 0,
		/datum/mob_descriptor/headtail_length = 0
	)

	available_cultural_info = list(
		TAG_CULTURE =   list(
		CULTURE_SKRELL_AMEMIR,
		CULTURE_SKRELL_SULQURL,
		CULTURE_SKRELL_TARSIKAR
		),
		TAG_HOMEWORLD = list(
		HOME_SYSTEM_QERRBALAK,
		HOME_SYSTEM_TELINKEER,
		HOME_SYSTEM_QARSEM,
		HOME_SYSTEM_MOQUK
		)
	)

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_LUNGS =    /obj/item/organ/internal/lungs/skrell,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_EYES =     /obj/item/organ/internal/eyes
		)

/datum/species/skrell/water_act(var/mob/living/carbon/human/H, var/depth)
	..()
	if(depth >= 40)
		if(H.getHalLoss())
			H.adjustHalLoss(-5)
			if(prob(5)) // Might be too spammy.
				to_chat(H, "<span class='notice'>The water ripples gently over your skin in a soothing balm.</span>")

