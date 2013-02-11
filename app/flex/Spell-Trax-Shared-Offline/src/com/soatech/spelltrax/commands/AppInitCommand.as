package com.soatech.spelltrax.commands
{
	import com.soatech.spelltrax.events.DataBaseEvent;
	import com.soatech.spelltrax.events.MigrationEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class AppInitCommand extends Command
	{
		override public function execute():void
		{
			dispatch( new MigrationEvent( MigrationEvent.BUILD ) );
			dispatch( new DataBaseEvent( DataBaseEvent.CONNECT ) );
		}
	}
}