
/**************************
		relaymove
**************************/
/obj/com_vehicle/relaymove(mob/user, direction)
	if(user != get_pilot() || move_delayer.blocked())
		return 0
	
	if(!engine_online || mechanically_disabled)
		if(!movement_warning_oncd)
			to_chat(user, "<span class='notice'> You mash the pedals and move the controls in the unpowered [src].</span>")
			movement_warning_oncd = TRUE
			spawn(20)
				movement_warning_oncd = FALSE
			return 0
		else
			return 0
	
	set_glide_size(DELAY2GLIDESIZE(movement_delay))
	
	switch(direction)
		if(NORTH)
			if(speed < 1000 && speed < max_speed) //1000 is the peak of the acceleration scale
				speed += acceleration
		if(SOUTH)
			if(speed > 0 && !can_reverse) //If we can't reverse and our speed is greater than 0 we can brake
				speed -= acceleration
			else
				if(speed > -1000 && can_reverse && speed > max_reverse_speed) //If we can reverse and we are above -1000 keep goin
					speed -= acceleration
		if(EAST)
			if(inverse_handling)
				dir = turn(dir, 90) //Tank controls
			else
				dir = turn(dir,-90)
		if(WEST)
			if(inverse_handling)
				dir = turn(dir, -90) //Technically its reversed too
			else
				dir = turn(dir, 90)

	to_chat(user,"We are currently at [speed] speed")
	move_delayer.delayNext(round(movement_delay,world.tick_lag)) //Delay

/**************************
	engine_fire_loop
**************************/
/obj/com_vehicle/proc/engine_fire_loop()
	while(speed)
		switch(speed)
			if(-1000 to -700)
				engine_fire_delay = 3
			if(-700 to -400)
				engine_fire_delay = 4
			if(-400 to -200)
				engine_fire_delay = 6
				in_reverse = TRUE
			if(-200 to -50)
				engine_fire_delay = 8
				in_reverse = TRUE
			if(-50 to 0)
				engine_fire_delay = 12
				in_reverse = TRUE
			//THE PIVOT POINT BETWEEN REVERSE AND NOT REVERSE
			if(0 to 50)
				engine_fire_delay = 12
				in_reverse = FALSE
			if(50 to 200)
				engine_fire_delay = 8
				in_reverse = FALSE
			if(200 to 300)
				engine_fire_delay = 4
				in_reverse = FALSE
			if(300 to 400)
				engine_fire_delay = 3
			if(400 to 500)
				engine_fire_delay = 2
			if(500 to 700)
				engine_fire_delay = 1
			if(700 to 800)
				engine_fire_delay = 1
			if(800 to 900)
				engine_fire_delay = 0.8
			if(900 to 1000)
				engine_fire_delay = 0.5

		if(!in_reverse)
			Move(get_step(src,dir), dir)
		else
			Move(get_step(src,turn(dir, -180)), dir)
	
		sleep(engine_fire_delay)

/**************************
		Process
**************************/
/obj/com_vehicle/proc/Process()
	switch(speed)
		if(-1000 to -50)
			speed += speed_loss
		
		if(-50 to 50)
			if(!engine_online)
				speed = FALSE

		if(50 to 1000)
			speed -= speed_loss
