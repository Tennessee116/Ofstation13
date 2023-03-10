#define BAD_INIT_QDEL_BEFORE 1
#define BAD_INIT_DIDNT_INIT 2
#define BAD_INIT_SLEPT 4
#define BAD_INIT_NO_HINT 8

SUBSYSTEM_DEF(atoms)
	name = "Atoms"
	init_order = SS_INIT_ATOMS
	flags = SS_NO_FIRE

	var/old_initialization_mode
	var/initialization_mode = INITIALIZATION_INSSATOMS

	var/list/late_loaders
	var/list/created_atoms

	var/list/BadInitializeCalls = list()

/datum/controller/subsystem/atoms/Initialize(timeofday)
	initialization_mode = INITIALIZATION_INNEW_MAPLOAD
	InitializeAtoms()
	return ..()

/datum/controller/subsystem/atoms/proc/InitializeAtoms(list/atoms)
	if(initialization_mode == INITIALIZATION_INSSATOMS)
		return

	initialization_mode = INITIALIZATION_INNEW_MAPLOAD

	LAZY_INIT(late_loaders)

	var/count
	var/list/mapload_arg = list(TRUE)
	if(atoms)
		created_atoms = list()
		count = atoms.len
		for(var/I in atoms)
			var/atom/A = I
			if(!(A.atom_flags & ATOM_FLAG_INITIALIZED))
				if(InitAtom(I, mapload_arg))
					atoms -= I
				CHECK_TICK
	else
		count = 0
		for(var/atom/A in world)
			if(!(A.atom_flags & ATOM_FLAG_INITIALIZED))
				InitAtom(A, mapload_arg)
				++count
				CHECK_TICK

	report_progress("Initialized [count] atom\s")
	pass(count)

	initialization_mode = INITIALIZATION_INNEW_REGULAR

	if(late_loaders.len)
		for(var/I in late_loaders)
			var/atom/A = I
			A.LateInitialize(arglist(mapload_arg))
		report_progress("Late initialized [late_loaders.len] atom\s")
		late_loaders.Cut()

	if(atoms)
		. = created_atoms + atoms
		created_atoms = null

/datum/controller/subsystem/atoms/proc/InitAtom(atom/A, list/arguments)
	var/the_type = A.type
	if(QDELING(A))
		BadInitializeCalls[the_type] |= BAD_INIT_QDEL_BEFORE
		return TRUE

	var/start_tick = world.time

	var/result = A.Initialize(arglist(arguments))

	if(start_tick != world.time)
		BadInitializeCalls[the_type] |= BAD_INIT_SLEPT

	var/qdeleted = FALSE
	var/mapload = arguments[1]

	if(result != INITIALIZE_HINT_NORMAL)
		switch(result)
			if(INITIALIZE_HINT_LATELOAD)
				if(mapload)	//mapload
					late_loaders += A
				else
					A.LateInitialize(arglist(arguments))
			if(INITIALIZE_HINT_QDEL)
				qdel(A)
				qdeleted = TRUE
			else
				BadInitializeCalls[the_type] |= BAD_INIT_NO_HINT

	if(!A)	//possible harddel
		qdeleted = TRUE
	else if(!(A.atom_flags & ATOM_FLAG_INITIALIZED))
		BadInitializeCalls[the_type] |= BAD_INIT_DIDNT_INIT

	return qdeleted || QDELING(A)

/datum/controller/subsystem/atoms/stat_entry()
	..("Bad Initialize Calls:[BadInitializeCalls.len]")

/datum/controller/subsystem/atoms/proc/map_loader_begin()
	old_initialization_mode = initialization_mode
	initialization_mode = INITIALIZATION_INSSATOMS

/datum/controller/subsystem/atoms/proc/map_loader_stop()
	initialization_mode = old_initialization_mode

/datum/controller/subsystem/atoms/Recover()
	initialized = SSatoms.initialized
	initialization_mode = SSatoms.initialization_mode
	if(initialization_mode == INITIALIZATION_INNEW_MAPLOAD)
		InitializeAtoms()
	old_initialization_mode = SSatoms.old_initialization_mode
	BadInitializeCalls = SSatoms.BadInitializeCalls

/datum/controller/subsystem/atoms/proc/InitLog()
	. = ""
	for(var/path in BadInitializeCalls)
		. += "Path : [path] \n"
		var/fails = BadInitializeCalls[path]
		if(fails & BAD_INIT_DIDNT_INIT)
			. += "- Didn't call atom/Initialize()\n"
		if(fails & BAD_INIT_NO_HINT)
			. += "- Didn't return an Initialize hint\n"
		if(fails & BAD_INIT_QDEL_BEFORE)
			. += "- Qdel'd in New()\n"
		if(fails & BAD_INIT_SLEPT)
			. += "- Slept during Initialize()\n"

/datum/controller/subsystem/atoms/Shutdown()
	var/initlog = InitLog()
	if(initlog)
		text2file(initlog, "[GLOB.log_directory]/initialize.log")

#undef BAD_INIT_QDEL_BEFORE
#undef BAD_INIT_DIDNT_INIT
#undef BAD_INIT_SLEPT
#undef BAD_INIT_NO_HINT
