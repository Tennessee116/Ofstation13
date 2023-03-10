/decl/hierarchy/supply_pack/atmospherics
	name = "Atmospherics"
	containertype = /obj/structure/closet/crate/internals

/decl/hierarchy/supply_pack/atmospherics/internals
	name = "Gear - Internals crate"
	contains = list(/obj/item/clothing/mask/gas = 3,
					/obj/item/weapon/tank/air = 3)
	cost = 10
	containername = "\improper Internals crate"

/decl/hierarchy/supply_pack/atmospherics/evacuation
	name = "Emergency equipment"
	contains = list(
		/obj/item/weapon/storage/toolbox/emergency = 2,
		/obj/item/clothing/suit/storage/hazardvest = 2,
		/obj/item/clothing/suit/armor/vest = 2,
		/obj/item/weapon/tank/emergency/oxygen/engi = 4,
		/obj/item/clothing/suit/space/emergency = 4,
		/obj/item/clothing/head/helmet/space/emergency = 4,
		/obj/item/clothing/mask/gas = 4,
		/obj/item/device/flashlight/flare/glowstick = 5
	)
	cost = 45

	containername = "\improper Emergency crate"
	newcargocost = 55

/decl/hierarchy/supply_pack/atmospherics/inflatable
	name = "Equipment - Inflatable barriers"
	contains = list(/obj/item/weapon/storage/briefcase/inflatable = 3)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "\improper Inflatable Barrier Crate"

/decl/hierarchy/supply_pack/atmospherics/canister_empty
	name = "Equipment - Empty gas canister"
	contains = list(/obj/machinery/portable_atmospherics/canister)
	cost = 7
	containername = "\improper Empty gas canister crate"
	containertype = /obj/structure/largecrate
	newcargocost = 4

/decl/hierarchy/supply_pack/atmospherics/canister_air
	name = "Gas - Air canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/air)
	cost = 10
	containername = "\improper Air canister crate"
	containertype = /obj/structure/largecrate
	newcargocost = 8

/decl/hierarchy/supply_pack/atmospherics/canister_oxygen
	name = "Gas - Oxygen canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/oxygen)
	cost = 15
	containername = "\improper Oxygen canister crate"
	containertype = /obj/structure/largecrate
	newcargocost = 10

/decl/hierarchy/supply_pack/atmospherics/canister_nitrogen
	name = "Gas - Nitrogen canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/nitrogen)
	cost = 10
	containername = "\improper Nitrogen canister crate"
	containertype = /obj/structure/largecrate
	newcargocost = 8

/decl/hierarchy/supply_pack/atmospherics/canister_phoron
	name = "Gas - Phoron gas canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/phoron)
	cost = 70
	containername = "\improper Phoron gas canister crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = access_atmospherics
	newcargocost = 60

/decl/hierarchy/supply_pack/atmospherics/canister_hydrogen
	name = "Gas - Hydrogen canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/hydrogen)
	cost = 25
	containername = "\improper Hydrogen canister crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = access_atmospherics

/decl/hierarchy/supply_pack/atmospherics/canister_sleeping_agent
	name = "Gas - N2O gas canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/sleeping_agent)
	cost = 40
	containername = "\improper N2O gas canister crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = access_atmospherics

/decl/hierarchy/supply_pack/atmospherics/canister_carbon_dioxide
	name = "Gas - Carbon dioxide gas canister"
	contains = list(/obj/machinery/portable_atmospherics/canister/carbon_dioxide)
	cost = 40
	containername = "\improper CO2 canister crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = access_atmospherics
	newcargocost = 25

/decl/hierarchy/supply_pack/atmospherics/fuel
	name = "Liquid - Fuel tank crate"
	contains = list(/obj/item/weapon/tank/hydrogen = 4)
	cost = 15
	containername = "\improper Fuel tank crate"

/decl/hierarchy/supply_pack/atmospherics/phoron
	name = "Gas - Phoron tank crate"
	contains = list(/obj/item/weapon/tank/phoron = 3)
	cost = 30
	containername = "\improper Phoron tank crate"

/decl/hierarchy/supply_pack/atmospherics/voidsuit
	name = "EVA - Atmospherics voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/atmos/alt,
					/obj/item/clothing/head/helmet/space/void/atmos/alt,
					/obj/item/clothing/shoes/magboots)
	cost = 120
	containername = "\improper Atmospherics voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = access_atmospherics

/decl/hierarchy/supply_pack/atmospherics/scanner_module
	name = "Electronics - Atmospherics scanner module crate"
	contains = list(/obj/item/weapon/computer_hardware/scanner/atmos = 4)
	cost = 20
	containername = "\improper Atmospherics scanner module crate"
	containertype = /obj/structure/closet/crate/secure
	access = access_atmospherics
	newcargocost = 18
