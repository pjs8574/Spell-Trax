package com.soatech.spelltrax
{
	import com.soatech.spelltrax.commands.AppInitCommand;
	import com.soatech.spelltrax.commands.DatabaseConnectCommand;
	import com.soatech.spelltrax.commands.MigrationsBuildCommand;
	import com.soatech.spelltrax.events.AppEvent;
	import com.soatech.spelltrax.events.DataBaseEvent;
	import com.soatech.spelltrax.events.MigrationEvent;
	import com.soatech.spelltrax.services.SpellBookService;
	import com.soatech.spelltrax.services.SpellService;
	import com.soatech.spelltrax.services.interfaces.ISpellBookService;
	import com.soatech.spelltrax.services.interfaces.ISpellService;
	import com.soatech.spelltrax.views.AppMediator;
	import com.soatech.spelltrax.views.SpellBookEditMediator;
	import com.soatech.spelltrax.views.SpellBookSelectMediator;
	import com.soatech.spelltrax.views.components.SpellBookEdit;
	import com.soatech.spelltrax.views.components.SpellBookSelect;
	
	import flash.display.DisplayObjectContainer;
	
	public class PhoneContext extends CoreContext
	{
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param contextView
		 * @param autoStartup
		 * 
		 */		
		public function PhoneContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function startup():void
		{
			super.startup();
			
			// model
			
			// commands
			commandMap.mapEvent( AppEvent.INIT, AppInitCommand );
			commandMap.mapEvent( DataBaseEvent.CONNECT, DatabaseConnectCommand );
			commandMap.mapEvent( MigrationEvent.BUILD, MigrationsBuildCommand );
			
			// services
			injector.mapClass( ISpellBookService, SpellBookService );
			injector.mapClass( ISpellService, SpellService );
			
			// views
			mediatorMap.mapView( Mobile, AppMediator );
			mediatorMap.mapView( SpellBookEdit, SpellBookEditMediator );
			mediatorMap.mapView( SpellBookSelect, SpellBookSelectMediator );
		}
	}
}