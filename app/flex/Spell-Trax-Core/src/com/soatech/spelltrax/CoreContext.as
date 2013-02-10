package com.soatech.spelltrax
{
	import com.soatech.spelltrax.commands.SpellBookLoadSpellsCommand;
	import com.soatech.spelltrax.commands.SpellBooksLoadCommand;
	import com.soatech.spelltrax.commands.SpellsLoadCommand;
	import com.soatech.spelltrax.events.SpellBookEvent;
	import com.soatech.spelltrax.events.SpellEvent;
	import com.soatech.spelltrax.models.SpellBooksProxy;
	import com.soatech.spelltrax.models.SpellsProxy;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Context;
	
	public class CoreContext extends Context implements IContext
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
		public function CoreContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
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
			injector.mapSingleton( SpellBooksProxy );
			injector.mapSingleton( SpellsProxy );
			
			// services
			
			// commands
			commandMap.mapEvent( SpellBookEvent.LOAD, SpellBooksLoadCommand );
			commandMap.mapEvent( SpellBookEvent.LOAD_SPELL_LIST, SpellBookLoadSpellsCommand );
			commandMap.mapEvent( SpellEvent.LOAD, SpellsLoadCommand );
			
		}
	}
}