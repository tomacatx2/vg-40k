//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/hospitaller_suit
	name = "Hospitaller Armor"
	desc = "Its basically bolted on, if it isn't then the person wearing it is probably missing flesh."
	icon = 'F_40kshit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "hospitaller_suit" //Check: Its there
	item_state = "hospitaller_suit"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	allowed = list(/obj/item/weapon/gun/projectile/automatic/boltpistol,
			/obj/item/weapon/chainsword,
			/obj/item/weapon/powersword
			)
	armor = list(melee = 70, bullet = 80, laser = 70,energy = 25, bomb = 50, bio = 100, rad = 50)
	canremove = FALSE


//-----COMMISSAR COAT
/obj/item/clothing/suit/armor/comissarcoat
	name = "commissar coat"
	desc = "A large coat with comissar stripes and heavy reinforcements."
	icon = 'F_40kshit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "commissarcoat" //Check: Its there
	item_state = "commissarcoat" //Check: Its there
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 50, rad = 50)
	body_parts_covered = FULL_TORSO
	allowed = list(/obj/item/weapon)
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY

//Inquisitor Suits
/obj/item/clothing/suit/armor/inq 
	name = "Inquisitor Suit"
	desc = "A stylish way to scare the shit out of people."
	icon = 'F_40kshit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "inq"//Check its there
	item_state = "inq"//Check: Its there
	body_parts_covered = FULL_TORSO|ARMS
	pressure_resistance = 3 * ONE_ATMOSPHERE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 15, bomb = 25, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon)

/obj/item/clothing/suit/armor/inq/alt
	icon_state = "inqalt" //Check: Its there
	item_state = "inqalt" //Check: Its there

/obj/item/clothing/suit/armor/inq/cape
	icon_state = "inqcapeo" //Check: Its there
	item_state = "inqcapeo"//Check: Its there

/obj/item/clothing/suit/armor/inq/alt/cape
	icon_state = "inqaltcape" //Check: Its there
	item_state = "inqaltcape" //Check: Its there

/obj/item/clothing/suit/armor/inq/old/cape
	icon_state = "inqcape" //Check: Its there
	item_state = "inqcape" //Check: Its there

/obj/item/clothing/suit/armor/inq/random/New() //Check: Its there
	..()
	var/whatami = pick("inq", "inqalt", "inqcape", "inqcapeo", "inqaltcape")
	switch(whatami)
		if("inq")
			icon_state = "inq"
			item_state = "inq"
		if("inqalt")
			icon_state = "inqalt"
			item_state = "inqalt"
		if("inqcape")
			icon_state = "inqcape"
			item_state = "inqcape"
		if("inqcapeo")
			icon_state = "inqcapeo"
			item_state = "inqcapeo"
		if("inqaltcape")
			icon_state = "inqaltcape"
			item_state = "inqalecape"


//Primaris Psyker Clothing

/obj/item/clothing/suit/armor/primarispsykerrobe
	name = "Flashy Robe"
	desc = "Fit for someone who has special tastes."
	icon = 'F_40kshit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "psyker_robe" //Check: Its there
	body_parts_covered = UPPER_TORSO
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)

/obj/item/clothing/suit/armor/harlequin
	name = "Harlequin Coat"
	desc = "The ornamented battle dress of a harlequin."
	icon = 'F_40kshit/icons/obj/clothing/suits.dmi'
	icon_state = "harlequin"
	item_state = "harlequin"
	blood_overlay_type = "armor"
	body_parts_covered = ARMS|LEGS|UPPER_TORSO
	armor = list(melee = 65, bullet = 60, laser = 60, energy = 100, bomb = 65, bio = 100, rad = 100)
	var/speed_modifier = 3
	allowed = list(/obj/item/weapon)

/obj/item/clothing/suit/armor/harlequin/equipped(mob/living/carbon/human/H, equipped_slot)
	..()
	if(istype(H) && H.get_item_by_slot(slot_shoes) == src && equipped_slot != null && equipped_slot == slot_shoes)
		if(H.mind.assigned_role == "Mime")
			H.movement_speed_modifier *= speed_modifier

/obj/item/clothing/suit/armor/harlequin/unequipped(mob/living/carbon/human/H, var/from_slot = null)
	..()
	if(from_slot == slot_shoes && istype(H))
		if(H.mind.assigned_role == "Mime")
			H.movement_speed_modifier /= speed_modifier

/obj/item/clothing/suit/armor/red_hoodie
	name = "Red Hoodie"
	desc = "Its a red hoodie."
	icon = 'F_40kshit/icons/obj/clothing/suits.dmi'
	icon_state = "detroidjacket"
	item_state = "detroidjacket"
	blood_overlay_type = "armor"
	body_parts_covered = ARMS|UPPER_TORSO
	armor = list(melee = 5, bullet = 5, laser = 5, energy = 5, bomb = 10, bio = 50, rad = 5)
	allowed = list(/obj/item/weapon)