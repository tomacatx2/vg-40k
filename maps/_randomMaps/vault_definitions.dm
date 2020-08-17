var/list/existing_vaults = list()

/datum/map_element/vault
	type_abbreviation = "V"

	var/require_dungeons = 0 //If 1, don't spawn on maps without a dungeon location defined (see code/modules/randomMaps/dungeons.dm)

	var/list/exclusive_to_maps = list() //Only spawn on these maps (accepts nameShort and nameLong, for more info see maps/_map.dm). No effect if empty
	var/list/map_blacklist = list() //Don't spawn on these maps

	var/only_spawn_once = 1 //If 0, this vault can spawn multiple times on a single map

	var/base_turf_type = /turf/unsimulated/outside/sand //The "default" turf type that surrounds this vault. If it differs from the z-level's base turf type (for example if this vault is loaded on a snow map), all turfs of this type will be replaced with turfs of the z-level's base turf type

/datum/map_element/vault/initialize(list/objects)
	..(objects)
	existing_vaults.Add(src)

	var/zlevel_base_turf_type = get_base_turf(location.z)
	if(!zlevel_base_turf_type)
		zlevel_base_turf_type = /turf/unsimulated/outside/sand

	for(var/turf/new_turf in objects)
		if(new_turf.type == base_turf_type) //New turf is vault's base turf
			if(new_turf.type != zlevel_base_turf_type) //And vault's base turf differs from zlevel's base turf
				new_turf.ChangeTurf(zlevel_base_turf_type)

		new_turf.turf_flags |= NO_MINIMAP //Makes the spawned turfs invisible on minimaps

//How to create a new vault:
//1) create a map in maps/randomVaults/
//2) create a new subtype of /datum/map_element/vault/mapruins/ (look below for an example) and set its file_path to your map's file path (including the file extension, which is most likely ".dmm")
//3) if you're an advanced user, feel free to play around with other variables

/datum/map_element/vault/mapruins/icetruck_crash
	file_path = "maps/randomvaults/icetruck_crash.dmm"

/datum/map_element/vault/mapruins/asteroid_temple
	file_path = "maps/randomvaults/asteroid_temple.dmm"

/datum/map_element/vault/mapruins/asteroid_temple/initialize(list/objects)
	..(objects)

	var/list/all_spawns = list()
	for(var/obj/effect/landmark/catechizer_spawn/S in objects)
		all_spawns.Add(S)

	var/obj/effect/true_spawn = pick(all_spawns)
	all_spawns.Remove(true_spawn)

	var/obj/item/weapon/melee/morningstar/catechizer/original = new(get_turf(true_spawn))
	qdel(true_spawn)
	for(var/obj/effect/S in all_spawns)
		new /mob/living/simple_animal/hostile/mimic/crate/item(get_turf(S), original) //Make copies
		qdel(S)

/datum/map_element/vault/mapruins/tommyboyasteroid
	file_path = "maps/randomvaults/tommyboyasteroid.dmm"

/datum/map_element/vault/mapruins/hivebot_factory
	file_path = "maps/randomvaults/hivebot_factory.dmm"

/datum/map_element/vault/mapruins/clown_base
	file_path = "maps/randomvaults/clown_base.dmm"

/datum/map_element/vault/mapruins/rust
	file_path = "maps/randomvaults/rust.dmm"

/datum/map_element/vault/mapruins/dance_revolution
	name = "Dance Dance Revolution"
	file_path = "maps/randomvaults/dance_revolution.dmm"
	var/obj/structure/dance_dance_revolution/machine

/datum/map_element/vault/mapruins/dance_revolution/initialize(list/objects)
	.=..()

	machine = track_atom(locate(/obj/structure/dance_dance_revolution) in objects)

/datum/map_element/vault/mapruins/dance_revolution/process_scoreboard()
	var/list/L = list()

	if(!machine)
		L += "The game has been destroyed!"
	else if(machine.wins || machine.attempts)
		L += "[machine.attempts] attempts have been made in total."
		L += "Of them, [machine.wins] were successful."
		if(machine.winner)
			L += "The first dancer to successfully finish the game was [machine.winner]."
		else
			L += "Nobody was good enough to finish the game."

	return L

/datum/map_element/vault/mapruins/spacegym
	file_path = "maps/randomvaults/spacegym.dmm"

/datum/map_element/vault/mapruins/oldarmory
	file_path = "maps/randomvaults/oldarmory.dmm"

/datum/map_element/vault/mapruins/spacepond
	file_path = "maps/randomvaults/spacepond.dmm"

/datum/map_element/vault/mapruins/spacepond/initialize(list/objects)
	..()

	load_dungeon(/datum/map_element/dungeon/wine_cellar)

/datum/map_element/dungeon/wine_cellar
	file_path = "maps/randomvaults/dungeons/wine_cellar.dmm"

/datum/map_element/vault/mapruins/iou_vault
	file_path = "maps/randomvaults/iou_fort.dmm"

/datum/map_element/vault/mapruins/biodome
	file_path = "maps/randomvaults/biodome.dmm"

/datum/map_element/vault/mapruins/iou_vault
	file_path = "maps/randomvaults/iou_fort.dmm"

/datum/map_element/vault/mapruins/asteroids
	file_path = "maps/randomvaults/asteroids.dmm"

/datum/map_element/vault/mapruins/listening
	file_path = "maps/randomvaults/listening.dmm"

/datum/map_element/vault/pretty_rad_clubhouse
	file_path = "maps/randomvaults/pretty_rad_clubhouse.dmm"

/datum/map_element/vault/mapruins/hivebot_crash
	file_path = "maps/randomvaults/hivebot_crash.dmm"

/datum/map_element/vault/mapruins/brokeufo
	file_path = "maps/randomvaults/brokeufo.dmm"

/datum/map_element/vault/mapruins/prison
	file_path = "maps/randomvaults/prison_ship.dmm"

/datum/map_element/vault/mapruins/prison/pre_load()
	load_dungeon(/datum/map_element/dungeon/prison)

/datum/map_element/dungeon/prison
	file_path = "maps/randomvaults/dungeons/prison.dmm"

/datum/map_element/vault/mapruins/AIsat
	file_path = "maps/randomvaults/AIsat.dmm"

/datum/map_element/vault/mapruins/ejectedengine
	file_path = "maps/randomvaults/ejectedengine.dmm"

/datum/map_element/vault/mapruins/droneship
	file_path = "maps/randomvaults/droneship.dmm"

/datum/map_element/vault/mapruins/meteorlogical_station
	file_path = "maps/randomvaults/meteorlogical_station.dmm"

/datum/map_element/vault/mapruins/taxi_engi
	file_path = "maps/randomvaults/taxi_engineering.dmm"

/datum/map_element/vault/mapruins/lightspeedship
	file_path = "maps/randomvaults/lightspeedship.dmm"

/datum/map_element/vault/mapruins/ice_comet
	file_path = "maps/randomvaults/ice_comet.dmm"

/datum/map_element/vault/mapruins/research_facility
	file_path = "maps/randomvaults/research_facility.dmm"

/datum/map_element/vault/mapruins/zoo_truck
	file_path = "maps/randomvaults/zoo_truck.dmm"

/datum/map_element/vault/mapruins/syndiecargo
	file_path = "maps/randomvaults/syndiecargo.dmm"

/datum/map_element/vault/mapruins/skeleton_den
	file_path = "maps/randomvaults/rattlemebones.dmm"

/datum/map_element/vault/mapruins/beach_party
	file_path = "maps/randomvaults/beach_party.dmm"

/datum/map_element/vault/mapruins/zathura
	file_path = "maps/randomvaults/house.dmm"

/datum/map_element/vault/mapruins/spy_sat
	file_path = "maps/randomvaults/spy_satellite.dmm"

/datum/map_element/vault/mapruins/spy_sat/pre_load()
	load_dungeon(/datum/map_element/dungeon/satellite_deployment)

/datum/map_element/dungeon/satellite_deployment
	file_path = "maps/randomvaults/dungeons/satellite_deployment.dmm"

/datum/map_element/vault/mapruins/ironchef
	file_path = "maps/randomvaults/ironchef.dmm"

/datum/map_element/vault/mapruins/assistantslair
	file_path = "maps/randomvaults/assistantslair.dmm"

/datum/map_element/vault/mapruins/asteroidfield
	file_path = "maps/randomvaults/asteroidfield.dmm"

/datum/map_element/vault/mapruins/clownroid
	file_path = "maps/randomvaults/clownroid.dmm"

/datum/map_element/vault/mapruins/goonesat
	file_path = "maps/randomvaults/goonesat.dmm"
	
/datum/map_element/vault/mapruins/mechagraveyard
	file_path = "maps/randomvaults/mecha_graveyard.dmm"