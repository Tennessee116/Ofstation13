/obj/item/weapon/computer_hardware/scanner/medical
	name = "medical scanner module"
	desc = "A medical scanner module. It can be used to scan patients and display medical information."

/obj/item/weapon/computer_hardware/scanner/medical/do_on_afterattack(mob/user, atom/target, proximity)
	if(!can_use_scanner(user, target, proximity))
		return

	var/dat = medical_scan_action(target, user, holder2, 1)

	if(dat && driver && driver.using_scanner)
		driver.data_buffer = html2pencode(dat)
		SStgui.update_uis(driver.NM)
