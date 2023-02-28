/singleton/cultural_info/culture/ipc
	name = CULTURE_ANDROID
	description = "You were not born, but created. Perhaps you were produced on an assembly line alongside many others for a certain task. \
	Maybe you were specially produced for a specific customer's needs. Or maybe you were built in some independent workshop by someone interested in robotics \
	Either way, you're probably used to not being treated as an equal by organic beings, who see you as a tool instead of a person."

/singleton/cultural_info/culture/ipc/sanitize_name(new_name)
	return sanitizeName(new_name, allow_numbers = 1)
