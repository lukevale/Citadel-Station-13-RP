<<<<<<< HEAD
/*
 * Contents:
 *		Welding mask
 *		Cakehat
 *		Ushanka
 *		Pumpkin head
 *		Kitty ears
 *		Holiday hats
 		Crown of Wrath
 */

/*
 * Welding mask
 */
/obj/item/clothing/head/welding
	name = "welding helmet"
	desc = "A head-mounted face cover designed to protect the wearer completely from space-arc eye."
	icon_state = "welding"
	item_state_slots = list(slot_r_hand_str = "welding", slot_l_hand_str = "welding")
	matter = list(DEFAULT_WALL_MATERIAL = 3000, "glass" = 1000)
	var/up = 0
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags_inv = (HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
	body_parts_covered = HEAD|FACE|EYES
	action_button_name = "Flip Welding Mask"
	siemens_coefficient = 0.9
	w_class = ITEMSIZE_NORMAL
	var/base_state
	flash_protection = FLASH_PROTECTION_MAJOR
	tint = TINT_HEAVY

/obj/item/clothing/head/welding/attack_self()
	toggle()


/obj/item/clothing/head/welding/verb/toggle()
	set category = "Object"
	set name = "Adjust welding mask"
	set src in usr

	if(!base_state)
		base_state = icon_state

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(src.up)
			src.up = !src.up
			body_parts_covered |= (EYES|FACE)
			flags_inv |= (HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
			icon_state = base_state
			flash_protection = FLASH_PROTECTION_MAJOR
			tint = initial(tint)
			to_chat(usr, "You flip the [src] down to protect your eyes.")
		else
			src.up = !src.up
			body_parts_covered &= ~(EYES|FACE)
			flags_inv &= ~(HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
			icon_state = "[base_state]up"
			flash_protection = FLASH_PROTECTION_NONE
			tint = TINT_NONE
			to_chat(usr, "You push the [src] up out of your face.")
		update_clothing_icon()	//so our mob-overlays
		if (ismob(src.loc)) //should allow masks to update when it is opened/closed
			var/mob/M = src.loc
			M.update_inv_wear_mask()
		usr.update_action_buttons()

/obj/item/clothing/head/welding/demon
	name = "demonic welding helmet"
	desc = "A painted welding helmet, this one has a demonic face on it."
	icon_state = "demonwelding"
	item_state_slots = list(
		slot_l_hand_str = "demonwelding",
		slot_r_hand_str = "demonwelding",
		)

/obj/item/clothing/head/welding/knight
	name = "knightly welding helmet"
	desc = "A painted welding helmet, this one looks like a knights helmet."
	icon_state = "knightwelding"
	item_state_slots = list(
		slot_l_hand_str = "knightwelding",
		slot_r_hand_str = "knightwelding",
		)

/obj/item/clothing/head/welding/fancy
	name = "fancy welding helmet"
	desc = "A painted welding helmet, the black and gold make this one look very fancy."
	icon_state = "fancywelding"
	item_state_slots = list(
		slot_l_hand_str = "fancywelding",
		slot_r_hand_str = "fancywelding",
		)

/obj/item/clothing/head/welding/engie
	name = "engineering welding helmet"
	desc = "A painted welding helmet, this one has been painted the engineering colours."
	icon_state = "engiewelding"
	item_state_slots = list(
		slot_l_hand_str = "engiewelding",
		slot_r_hand_str = "engiewelding",
		)


/*
 * Cakehat
 */
/obj/item/clothing/head/cakehat
	name = "cake-hat"
	desc = "It's tasty looking!"
	icon_state = "cake0"
	var/onfire = 0
	body_parts_covered = HEAD

/obj/item/clothing/head/cakehat/process()
	if(!onfire)
		processing_objects.Remove(src)
		return

	var/turf/location = src.loc
	if(istype(location, /mob/))
		var/mob/living/carbon/human/M = location
		if(M.item_is_in_hands(src) || M.head == src)
			location = M.loc

	if (istype(location, /turf))
		location.hotspot_expose(700, 1)

/obj/item/clothing/head/cakehat/attack_self(mob/user as mob)
	onfire = !(onfire)
	if (onfire)
		force = 3
		damtype = "fire"
		icon_state = "cake1"
		processing_objects.Add(src)
	else
		force = null
		damtype = "brute"
		icon_state = "cake0"
	return


/*
 * Ushanka
 */
/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "Perfect for winter in Siberia, da?"
	icon_state = "ushankadown"
	flags_inv = HIDEEARS

/obj/item/clothing/head/ushanka/attack_self(mob/user as mob)
	if(src.icon_state == "ushankadown")
		src.icon_state = "ushankaup"
		user << "You raise the ear flaps on the ushanka."
	else
		src.icon_state = "ushankadown"
		user << "You lower the ear flaps on the ushanka."

/*
 * Pumpkin head
 */
/obj/item/clothing/head/pumpkinhead
	name = "carved pumpkin"
	desc = "A jack o' lantern! Believed to ward off evil spirits."
	icon_state = "hardhat0_pumpkin"//Could stand to be renamed
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	brightness_on = 2
	light_overlay = "helmet_light"
	w_class = ITEMSIZE_NORMAL

/*
 * Kitty ears
 */
/obj/item/clothing/head/kitty
	name = "kitty ears"
	desc = "A pair of kitty ears. Meow!"
	icon_state = "kitty"
	body_parts_covered = 0
	siemens_coefficient = 1.5
	item_icons = list()

	update_icon(var/mob/living/carbon/human/user)
		if(!istype(user)) return
		var/icon/ears = new/icon("icon" = 'icons/mob/head.dmi', "icon_state" = "kitty")
		ears.Blend(rgb(user.r_hair, user.g_hair, user.b_hair), ICON_ADD)

		var/icon/earbit = new/icon("icon" = 'icons/mob/head.dmi', "icon_state" = "kittyinner")
		ears.Blend(earbit, ICON_OVERLAY)

/obj/item/clothing/head/richard
	name = "chicken mask"
	desc = "You can hear the distant sounds of rhythmic electronica."
	icon_state = "richard"
	item_state_slots = list(slot_r_hand_str = "chickenhead", slot_l_hand_str = "chickenhead")
	body_parts_covered = HEAD|FACE
	flags_inv = BLOCKHAIR

/obj/item/clothing/head/santa
	name = "santa hat"
	desc = "It's a festive christmas hat, in red!"
	icon_state = "santahatnorm"
	item_state_slots = list(slot_r_hand_str = "santahat", slot_l_hand_str = "santahat")
	body_parts_covered = 0

/obj/item/clothing/head/santa/green
	name = "green santa hat"
	desc = "It's a festive christmas hat, in green!"
	icon_state = "santahatgreen"
	item_state_slots = list(slot_r_hand_str = "santahatgreen", slot_l_hand_str = "santahatgreen")
	body_parts_covered = 0

/*
 * Xenoarch/Surface Loot Hats
 */

// Triggers an effect when the wearer is 'in grave danger'.
// Causes brainloss when it happens.
/obj/item/clothing/head/psy_crown
	name = "broken crown"
	desc = "A crown-of-thorns with a missing gem."
	var/tension_threshold = 150
	var/cooldown = null // world.time of when this was last triggered.
	var/cooldown_duration = 3 MINUTES // How long the cooldown should be.
	var/flavor_equip = null // Message displayed to someone who puts this on their head. Drones don't get a message.
	var/flavor_unequip = null // Ditto, but for taking it off.
	var/flavor_drop = null // Ditto, but for dropping it.
	var/flavor_activate = null // Ditto, for but activating.
	var/brainloss_cost = 3 // Whenever it activates, inflict this much brainloss on the wearer, as its not good for the mind to wear things that manipulate it.

/obj/item/clothing/head/psy_crown/proc/activate_ability(var/mob/living/wearer)
	cooldown = world.time + cooldown_duration
	to_chat(wearer, flavor_activate)
	to_chat(wearer, "<span class='danger'>The inside of your head hurts...</span>")
	wearer.adjustBrainLoss(brainloss_cost)

/obj/item/clothing/head/psy_crown/equipped(var/mob/living/carbon/human/H)
	..()
	if(istype(H) && H.head == src && H.is_sentient())
		processing_objects += src
		to_chat(H, flavor_equip)

/obj/item/clothing/head/psy_crown/dropped(var/mob/living/carbon/human/H)
	..()
	processing_objects -= src
	if(H.is_sentient())
		if(loc == H) // Still inhand.
			to_chat(H, flavor_unequip)
		else
			to_chat(H, flavor_drop)

/obj/item/clothing/head/psy_crown/Destroy()
	processing_objects -= src
	return ..()

/obj/item/clothing/head/psy_crown/process()
	if(isliving(loc))
		var/mob/living/L = loc
		if(world.time >= cooldown && L.is_sentient() && L.get_tension() >= tension_threshold)
			activate_ability(L)


/obj/item/clothing/head/psy_crown/wrath
	name = "red crown"
	desc = "A crown-of-thorns set with a red gemstone that seems to glow unnaturally. It feels rather disturbing to touch."
	description_info = "This has a chance to cause the wearer to become extremely angry when in extreme danger."
	icon_state = "wrathcrown"
	flavor_equip = "<span class='warning'>You feel a bit angrier after putting on this crown.</span>"
	flavor_unequip = "<span class='notice'>You feel calmer after removing the crown.</span>"
	flavor_drop = "<span class='notice'>You feel much calmer after letting go of the crown.</span>"
	flavor_activate = "<span class='danger'>An otherworldly feeling seems to enter your mind, and it ignites your mind in fury!</span>"
	origin_tech = list(TECH_ARCANE = 4)

/obj/item/clothing/head/psy_crown/wrath/activate_ability(var/mob/living/wearer)
	..()
	wearer.add_modifier(/datum/modifier/berserk, 30 SECONDS)
=======
/*
 * Contents:
 *		Welding mask
 *		Cakehat
 *		Ushanka
 *		Pumpkin head
 *		Kitty ears
 *		Holiday hats
 		Crown of Wrath
 */

/*
 * Welding mask
 */
/obj/item/clothing/head/welding
	name = "welding helmet"
	desc = "A head-mounted face cover designed to protect the wearer completely from space-arc eye."
	icon_state = "welding"
	item_state_slots = list(slot_r_hand_str = "welding", slot_l_hand_str = "welding")
	matter = list(DEFAULT_WALL_MATERIAL = 3000, "glass" = 1000)
	var/up = 0
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags_inv = (HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
	body_parts_covered = HEAD|FACE|EYES
	action_button_name = "Flip Welding Mask"
	siemens_coefficient = 0.9
	w_class = ITEMSIZE_NORMAL
	var/base_state
	flash_protection = FLASH_PROTECTION_MAJOR
	tint = TINT_HEAVY

/obj/item/clothing/head/welding/attack_self()
	toggle()


/obj/item/clothing/head/welding/verb/toggle()
	set category = "Object"
	set name = "Adjust welding mask"
	set src in usr

	if(!base_state)
		base_state = icon_state

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(src.up)
			src.up = !src.up
			body_parts_covered |= (EYES|FACE)
			flags_inv |= (HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
			icon_state = base_state
			flash_protection = FLASH_PROTECTION_MAJOR
			tint = initial(tint)
			to_chat(usr, "You flip the [src] down to protect your eyes.")
		else
			src.up = !src.up
			body_parts_covered &= ~(EYES|FACE)
			flags_inv &= ~(HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
			icon_state = "[base_state]up"
			flash_protection = FLASH_PROTECTION_NONE
			tint = TINT_NONE
			to_chat(usr, "You push the [src] up out of your face.")
		update_clothing_icon()	//so our mob-overlays
		if (ismob(src.loc)) //should allow masks to update when it is opened/closed
			var/mob/M = src.loc
			M.update_inv_wear_mask()
		usr.update_action_buttons()

/obj/item/clothing/head/welding/demon
	name = "demonic welding helmet"
	desc = "A painted welding helmet, this one has a demonic face on it."
	icon_state = "demonwelding"
	item_state_slots = list(
		slot_l_hand_str = "demonwelding",
		slot_r_hand_str = "demonwelding",
		)

/obj/item/clothing/head/welding/knight
	name = "knightly welding helmet"
	desc = "A painted welding helmet, this one looks like a knights helmet."
	icon_state = "knightwelding"
	item_state_slots = list(
		slot_l_hand_str = "knightwelding",
		slot_r_hand_str = "knightwelding",
		)

/obj/item/clothing/head/welding/fancy
	name = "fancy welding helmet"
	desc = "A painted welding helmet, the black and gold make this one look very fancy."
	icon_state = "fancywelding"
	item_state_slots = list(
		slot_l_hand_str = "fancywelding",
		slot_r_hand_str = "fancywelding",
		)

/obj/item/clothing/head/welding/engie
	name = "engineering welding helmet"
	desc = "A painted welding helmet, this one has been painted the engineering colours."
	icon_state = "engiewelding"
	item_state_slots = list(
		slot_l_hand_str = "engiewelding",
		slot_r_hand_str = "engiewelding",
		)


/*
 * Cakehat
 */
/obj/item/clothing/head/cakehat
	name = "cake-hat"
	desc = "It's tasty looking!"
	icon_state = "cake0"
	var/onfire = 0
	body_parts_covered = HEAD

/obj/item/clothing/head/cakehat/process()
	if(!onfire)
		STOP_PROCESSING(SSobj, src)
		return

	var/turf/location = src.loc
	if(istype(location, /mob/))
		var/mob/living/carbon/human/M = location
		if(M.item_is_in_hands(src) || M.head == src)
			location = M.loc

	if (istype(location, /turf))
		location.hotspot_expose(700, 1)

/obj/item/clothing/head/cakehat/attack_self(mob/user as mob)
	onfire = !(onfire)
	if (onfire)
		force = 3
		damtype = "fire"
		icon_state = "cake1"
		START_PROCESSING(SSobj, src)
	else
		force = null
		damtype = "brute"
		icon_state = "cake0"
	return


/*
 * Ushanka
 */
/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "Perfect for winter in Siberia, da?"
	icon_state = "ushankadown"
	flags_inv = HIDEEARS

/obj/item/clothing/head/ushanka/attack_self(mob/user as mob)
	if(src.icon_state == "ushankadown")
		src.icon_state = "ushankaup"
		user << "You raise the ear flaps on the ushanka."
	else
		src.icon_state = "ushankadown"
		user << "You lower the ear flaps on the ushanka."

/*
 * Pumpkin head
 */
/obj/item/clothing/head/pumpkinhead
	name = "carved pumpkin"
	desc = "A jack o' lantern! Believed to ward off evil spirits."
	icon_state = "hardhat0_pumpkin"//Could stand to be renamed
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	brightness_on = 2
	light_overlay = "helmet_light"
	w_class = ITEMSIZE_NORMAL

/*
 * Kitty ears
 */
/obj/item/clothing/head/kitty
	name = "kitty ears"
	desc = "A pair of kitty ears. Meow!"
	icon_state = "kitty"
	body_parts_covered = 0
	siemens_coefficient = 1.5
	item_icons = list()

	update_icon(var/mob/living/carbon/human/user)
		if(!istype(user)) return
		var/icon/ears = new/icon("icon" = 'icons/mob/head.dmi', "icon_state" = "kitty")
		ears.Blend(rgb(user.r_hair, user.g_hair, user.b_hair), ICON_ADD)

		var/icon/earbit = new/icon("icon" = 'icons/mob/head.dmi', "icon_state" = "kittyinner")
		ears.Blend(earbit, ICON_OVERLAY)

/obj/item/clothing/head/richard
	name = "chicken mask"
	desc = "You can hear the distant sounds of rhythmic electronica."
	icon_state = "richard"
	item_state_slots = list(slot_r_hand_str = "chickenhead", slot_l_hand_str = "chickenhead")
	body_parts_covered = HEAD|FACE
	flags_inv = BLOCKHAIR

/obj/item/clothing/head/santa
	name = "santa hat"
	desc = "It's a festive christmas hat, in red!"
	icon_state = "santahatnorm"
	item_state_slots = list(slot_r_hand_str = "santahat", slot_l_hand_str = "santahat")
	body_parts_covered = 0

/obj/item/clothing/head/santa/green
	name = "green santa hat"
	desc = "It's a festive christmas hat, in green!"
	icon_state = "santahatgreen"
	item_state_slots = list(slot_r_hand_str = "santahatgreen", slot_l_hand_str = "santahatgreen")
	body_parts_covered = 0

/*
 * Xenoarch/Surface Loot Hats
 */

// Triggers an effect when the wearer is 'in grave danger'.
// Causes brainloss when it happens.
/obj/item/clothing/head/psy_crown
	name = "broken crown"
	desc = "A crown-of-thorns with a missing gem."
	var/tension_threshold = 150
	var/cooldown = null // world.time of when this was last triggered.
	var/cooldown_duration = 3 MINUTES // How long the cooldown should be.
	var/flavor_equip = null // Message displayed to someone who puts this on their head. Drones don't get a message.
	var/flavor_unequip = null // Ditto, but for taking it off.
	var/flavor_drop = null // Ditto, but for dropping it.
	var/flavor_activate = null // Ditto, for but activating.
	var/brainloss_cost = 3 // Whenever it activates, inflict this much brainloss on the wearer, as its not good for the mind to wear things that manipulate it.

/obj/item/clothing/head/psy_crown/proc/activate_ability(var/mob/living/wearer)
	cooldown = world.time + cooldown_duration
	to_chat(wearer, flavor_activate)
	to_chat(wearer, "<span class='danger'>The inside of your head hurts...</span>")
	wearer.adjustBrainLoss(brainloss_cost)

/obj/item/clothing/head/psy_crown/equipped(var/mob/living/carbon/human/H)
	..()
	if(istype(H) && H.head == src && H.is_sentient())
		START_PROCESSING(SSobj, src)
		to_chat(H, flavor_equip)

/obj/item/clothing/head/psy_crown/dropped(var/mob/living/carbon/human/H)
	..()
	STOP_PROCESSING(SSobj, src)
	if(H.is_sentient())
		if(loc == H) // Still inhand.
			to_chat(H, flavor_unequip)
		else
			to_chat(H, flavor_drop)

/obj/item/clothing/head/psy_crown/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/head/psy_crown/process()
	if(isliving(loc))
		var/mob/living/L = loc
		if(world.time >= cooldown && L.is_sentient() && L.get_tension() >= tension_threshold)
			activate_ability(L)


/obj/item/clothing/head/psy_crown/wrath
	name = "red crown"
	desc = "A crown-of-thorns set with a red gemstone that seems to glow unnaturally. It feels rather disturbing to touch."
	description_info = "This has a chance to cause the wearer to become extremely angry when in extreme danger."
	icon_state = "wrathcrown"
	flavor_equip = "<span class='warning'>You feel a bit angrier after putting on this crown.</span>"
	flavor_unequip = "<span class='notice'>You feel calmer after removing the crown.</span>"
	flavor_drop = "<span class='notice'>You feel much calmer after letting go of the crown.</span>"
	flavor_activate = "<span class='danger'>An otherworldly feeling seems to enter your mind, and it ignites your mind in fury!</span>"

/obj/item/clothing/head/psy_crown/wrath/activate_ability(var/mob/living/wearer)
	..()
	wearer.add_modifier(/datum/modifier/berserk, 30 SECONDS)
>>>>>>> 4839b4b... Merge pull request #4577 from VOREStation/upstream-merge-5677
