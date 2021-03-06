/obj/item/shield_diffuser
	name = "portable shield diffuser"
	desc = "A small handheld device designed to disrupt energy barriers"
	description_info = "This device disrupts shields on directly adjacent tiles (in a + shaped pattern), in a similar way the floor mounted variant does. It is, however, portable and run by an internal battery. Can be recharged with a regular recharger."
	icon = 'icons/obj/machines/shielding.dmi'
	icon_state = "hdiffuser_off"
	var/obj/item/cell/device/cell = /obj/item/cell/device
	var/enabled = 0


/obj/item/shield_diffuser/Initialize(mapload)
	. = ..()
	if(cell)
		cell = new cell(src)

/obj/item/shield_diffuser/Destroy()
	QDEL_NULL(cell)
	if(enabled)
		STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/shield_diffuser/get_cell()
	return cell

/obj/item/shield_diffuser/process()
	if(!enabled)
		return

	for(var/direction in cardinal)
		var/turf/simulated/shielded_tile = get_step(get_turf(src), direction)
		for(var/obj/effect/energy_field/S in shielded_tile)
			if(istype(S) && cell.checked_use(10 KILOWATTS * CELLRATE))
				qdel(S)

/obj/item/shield_diffuser/update_icon()
	if(enabled)
		icon_state = "hdiffuser_on"
	else
		icon_state = "hdiffuser_off"

/obj/item/shield_diffuser/attack_self()
	enabled = !enabled
	update_icon()
	if(enabled)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)
	to_chat(usr, "You turn \the [src] [enabled ? "on" : "off"].")

/obj/item/shield_diffuser/examine()
	. = ..()
	to_chat(usr, "The charge meter reads [cell ? cell.percent() : 0]%")
	to_chat(usr, "It is [enabled ? "enabled" : "disabled"].")