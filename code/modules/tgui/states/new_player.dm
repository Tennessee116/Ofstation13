/**
 * tgui state: new_player_state
 *
 * Checks that the user is a new_player, or if user is an admin
 */

GLOBAL_DATUM_INIT(new_player_state, /datum/ui_state/new_player_state, new)

/datum/ui_state/new_player_state/can_use_topic(src_object, mob/user)
	if(is_new_player(user) || check_rights(R_ADMIN, 0, user.client))
		return UI_INTERACTIVE
	return UI_CLOSE

