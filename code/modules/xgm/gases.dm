/decl/xgm_gas/oxygen
	id = "oxygen"
	name = "Oxygen"
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.032	// kg/mol
	flags = XGM_GAS_OXIDIZER | XGM_GAS_FUSION_FUEL
	breathed_product = /datum/reagent/oxygen

/decl/xgm_gas/nitrogen
	id = "nitrogen"
	name = "Nitrogen"
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.028	// kg/mol

/decl/xgm_gas/carbon_dioxide
	id = "carbon_dioxide"
	name = "Carbon Dioxide"
	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.044	// kg/mol

/decl/xgm_gas/methyl_bromide
	id = "methyl_bromide"
	name = "Methyl Bromide"
	specific_heat = 42.59 // J/(mol*K)
	molar_mass = 0.095	  // kg/mol
	breathed_product = /datum/reagent/toxin/methyl_bromide

/decl/xgm_gas/phoron
	id = "phoron"
	name = "Phoron"

	//Note that this has a significant impact on TTV yield.
	//Because it is so high, any leftover phoron soaks up a lot of heat and drops the yield pressure.
	specific_heat = 200	// J/(mol*K)

	//Hypothetical group 14 (same as carbon), period 8 element.
	//Using multiplicity rule, it's atomic number is 162
	//and following a N/Z ratio of 1.5, the molar mass of a monatomic gas is:
	molar_mass = 0.405	// kg/mol

	tile_overlay = "phoron"
	overlay_limit = 0.7
	flags = XGM_GAS_FUEL | XGM_GAS_CONTAMINANT | XGM_GAS_FUSION_FUEL
	breathed_product = /datum/reagent/toxin/phoron

/decl/xgm_gas/sleeping_agent
	id = "nitrous_oxide"
	name = "Nitrous Oxide"
	specific_heat = 40	// J/(mol*K)
	molar_mass = 0.044	// kg/mol. N2O

	tile_overlay = "nitrous_oxide"
	overlay_limit = 1
	flags = XGM_GAS_OXIDIZER //N2O is a powerful oxidizer
	breathed_product = /datum/reagent/nitrous_oxide

/decl/xgm_gas/methane
	id = "methane"
	name = "Methane"
	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.016	// kg/mol
	flags = XGM_GAS_FUEL

/decl/xgm_gas/alium
	id = "aliether"
	name = "Aliether"

/decl/xgm_gas/alium/New()
	name = "Compound #[rand(100,999)]"
	specific_heat = rand(1, 400)	// J/(mol*K)
	molar_mass = rand(20,800)/1000	// kg/mol
	if(prob(40))
		flags |= XGM_GAS_FUEL
	else if(prob(40)) //it's prooobably a bad idea for gas being oxidizer to itself.
		flags |= XGM_GAS_OXIDIZER
	if(prob(40))
		flags |= XGM_GAS_CONTAMINANT
	if(prob(40))
		flags |= XGM_GAS_FUSION_FUEL

/decl/xgm_gas/hydrogen
	id = "hydrogen"
	name = "Hydrogen"
	specific_heat = 100	// J/(mol*K)
	molar_mass = 0.002	// kg/mol
	flags = XGM_GAS_FUEL|XGM_GAS_FUSION_FUEL
	burn_product = "watervapor"

/decl/xgm_gas/hydrogen/deuterium
	id = "deuterium"
	name = "Deuterium"

/decl/xgm_gas/hydrogen/tritium
	id = "tritium"
	name = "Tritium"

/decl/xgm_gas/helium
	id = "helium"
	name = "Helium"
	specific_heat = 80	// J/(mol*K)
	molar_mass = 0.004	// kg/mol
	flags = XGM_GAS_FUSION_FUEL
	breathed_product = /datum/reagent/helium

/decl/xgm_gas/argon
	id = "argon"
	name = "Argon"
	specific_heat = 10	// J/(mol*K)
	molar_mass = 0.018	// kg/mol

// If narcosis is ever simulated, krypton has a narcotic potency seven times greater than regular airmix.
/decl/xgm_gas/krypton
	id = "krypton"
	name = "Krypton"
	specific_heat = 5	// J/(mol*K)
	molar_mass = 0.036	// kg/mol

/decl/xgm_gas/neon
	id = "neon"
	name = "Neon"
	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.01	// kg/mol

/decl/xgm_gas/xenon
	id = "xenon"
	name = "Xenon"
	specific_heat = 3	// J/(mol*K)
	molar_mass = 0.054	// kg/mol
	breathed_product = /datum/reagent/nitrous_oxide/xenon

/decl/xgm_gas/nitrodioxide
	id = "nitrodioxide"
	name = "Nitrogen Dioxide"
	specific_heat = 37	// J/(mol*K)
	molar_mass = 0.054	// kg/mol
	flags = XGM_GAS_OXIDIZER
	breathed_product = /datum/reagent/toxin

/decl/xgm_gas/nitricoxide
	id = "nitricoxide"
	name = "Nitric Oxide"

	specific_heat = 10	// J/(mol*K)
	molar_mass = 0.030	// kg/mol
	flags = XGM_GAS_OXIDIZER

/decl/xgm_gas/chlorine
	id = "chlorine"
	name = "Chlorine"
	tile_overlay = "chlorine"
	specific_heat = 5	// J/(mol*K)
	molar_mass = 0.017	// kg/mol
	flags = XGM_GAS_CONTAMINANT
	breathed_product = /datum/reagent/toxin/chlorine

/decl/xgm_gas/vapor
	id = "watervapor"
	name = "Water Vapor"

	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.020	// kg/mol
	breathed_product =     /datum/reagent/water
	condensation_product = /datum/reagent/water
	condensation_point =   308.15 // 35C. Dew point is ~20C but this is better for gameplay considerations.

/decl/xgm_gas/sulfurdioxide
	id = "sulfurdioxide"
	name = "Sulfur Dioxide"

	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.044	// kg/mol

/decl/xgm_gas/ammonia
	id = "ammonia"
	name = "Ammonia"

	specific_heat = 20	// J/(mol*K)
	molar_mass = 0.017	// kg/mol
	breathed_product = /datum/reagent/ammonia

/decl/xgm_gas/carbon_monoxide
	id = "carbon_monoxide"
	name = "Carbon Monoxide"
	specific_heat = 30	// J/(mol*K)
	molar_mass = 0.028	// kg/mol
	breathed_product = /datum/reagent/carbon_monoxide
