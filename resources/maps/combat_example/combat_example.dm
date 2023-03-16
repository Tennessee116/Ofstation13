#if !defined(USING_MAP_DATUM)

	#include "combat_example.dmm"

	#define USING_MAP_DATUM /datum/map/combat_example

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring combat example!

#endif
