/datum/species/vox
	name = SPECIES_VOX
	name_plural = SPECIES_VOX
	icobase = 'resources/icons/mob/human_races/species/vox/body.dmi'
	deform = 'resources/icons/mob/human_races/species/vox/body.dmi'
	husk_icon = 'resources/icons/mob/human_races/species/vox/husk.dmi'
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick,  /datum/unarmed_attack/claws/strong, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite/strong)
	rarity_value = 4
	description = "The Vox are a pre-FTL transport society, clustered around their nitrogen-rich home nebula. . \
	Originally found within valuable cobalt bearing asteroids seemingly able to survive off of the Nitrogen within their home Nebula, they quickly became a menace to travelers, \
	stealing ships via violent boarding action and ram raids and murdering or enslaving their crews. \
	They rarely venture outside of their nebula of origin, apart for small frigates in search of larger ships to board."

	taste_sensitivity = TASTE_DULL
	speech_sounds = list('resources/sound/voice/shriek1.ogg')
	speech_chance = 20

	warning_low_pressure = 50
	hazard_low_pressure = 0

	cold_level_1 = 80
	cold_level_2 = 50
	cold_level_3 = 0

	gluttonous = GLUT_TINY|GLUT_ITEM_NORMAL
	stomach_capacity = 12

	breath_type = "nitrogen"
	poison_types = list("oxygen" = TRUE)
	siemens_coefficient = 0.2

	species_flags = SPECIES_FLAG_NO_SCAN
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_NO_FBP_CONSTRUCTION
	appearance_flags = HAS_EYE_COLOR | HAS_HAIR_COLOR

	blood_color = "#2299fc"
	flesh_color = "#808d11"

	reagent_tag = IS_VOX

	inherent_verbs = list(
		/mob/living/carbon/human/proc/leap
		)

	override_limb_types = list(
		BP_GROIN = /obj/item/organ/external/groin/vox,
		BP_HEAD = /obj/item/organ/external/head/vox
		)

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart/vox,
		BP_LUNGS =    /obj/item/organ/internal/lungs/vox,
		BP_LIVER =    /obj/item/organ/internal/liver/vox,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys/vox,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_EYES =     /obj/item/organ/internal/eyes,
		BP_STACK =    /obj/item/organ/internal/stack/vox
		)

	genders = list(NEUTER)
	descriptors = list(
		/datum/mob_descriptor/height = -1,
		/datum/mob_descriptor/build = 1,
		/datum/mob_descriptor/vox_markings = 0
		)

	available_cultural_info = list(
		TAG_CULTURE =   list(
			CULTURE_VOX
		),
		TAG_HOMEWORLD = list(
			HOME_SYSTEM_VOX
		)
	)

/datum/species/vox/equip_survival_gear(var/mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/vox(H), slot_wear_mask)

	if(istype(H.get_equipped_item(slot_back), /obj/item/weapon/storage/backpack))
		H.equip_to_slot_or_del(new /obj/item/weapon/tank/nitrogen(H), slot_r_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/vox(H.back), slot_in_backpack)
		H.internal = H.r_hand
	else
		H.equip_to_slot_or_del(new /obj/item/weapon/tank/nitrogen(H), slot_back)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/vox(H), slot_r_hand)
		H.internal = H.back

	if(H.internals)
		H.internals.icon_state = "internal1"

/datum/species/vox/disfigure_msg(var/mob/living/carbon/human/H)
	var/datum/gender/T = gender_datums[H.get_gender()]
	return "<span class='danger'>[T.His] beak is chipped! [T.He] [T.is] not even recognizable.</span>\n" //Pretty birds.
