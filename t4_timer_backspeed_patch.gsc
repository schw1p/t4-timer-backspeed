#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

/*
	Displays an in-game timer and fixes player backspeed in Call Of Duty: World at War.
*/

init()
{
	thread onConnect();  
}

onConnect()
{
	for(;;)
	{
		level waittill( "connecting", player );
		player thread onPlayerSpawned();
	}
}

setGameTimer()
{	
	hud = create_simple_hud( self );
	hud.foreground = true; 
	hud.sort = 1; 
	hud.hidewheninmenu = true; 
	hud.alignX = "left"; 
	hud.alignY = "top";
	hud.horzAlign = "user_left"; 
	hud.vertAlign = "user_top";
	hud.x = hud.x - -700; 
	hud.y = hud.y + 35; 
	hud.alpha = 1;
	flag_wait("all_players_spawned");
	hud setTimerUp(1);
}

onPlayerSpawned()
{
	self endon( "disconnect" ); 

	for( ;; )
	{
		level waittill( "connected", player ); 
		self thread setGameTimer();
		self SetClientDvars( 
			"player_backSpeedScale", "1", 
			"player_strafeSpeedScale", "1");
	}
}   
