package com.soatech.spelltrax
{
import com.soatech.spelltrax.commands.SpellBookCreateCommand;
import com.soatech.spelltrax.commands.SpellBookDeleteCommand;
import com.soatech.spelltrax.commands.SpellBookLinkSpellCommand;
import com.soatech.spelltrax.commands.SpellBookLoadSpellsCommand;
import com.soatech.spelltrax.commands.SpellBookSaveCommand;
import com.soatech.spelltrax.commands.SpellBooksLoadCommand;
import com.soatech.spelltrax.commands.SpellCreateCommand;
import com.soatech.spelltrax.commands.SpellDeleteCommand;
import com.soatech.spelltrax.commands.SpellSaveCommand;
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
            commandMap.mapEvent( SpellBookEvent.CREATE, SpellBookCreateCommand );
			commandMap.mapEvent( SpellBookEvent.LOAD, SpellBooksLoadCommand );
			commandMap.mapEvent( SpellBookEvent.LOAD_SPELL_LIST, SpellBookLoadSpellsCommand );
            commandMap.mapEvent( SpellBookEvent.DELETE, SpellBookDeleteCommand );
			commandMap.mapEvent( SpellBookEvent.SAVE, SpellBookSaveCommand );
            commandMap.mapEvent( SpellBookEvent.LINK_SPELL, SpellBookLinkSpellCommand );
            commandMap.mapEvent( SpellEvent.CREATE, SpellCreateCommand );
			commandMap.mapEvent( SpellEvent.LOAD, SpellsLoadCommand );
            commandMap.mapEvent( SpellEvent.SAVE, SpellSaveCommand );
            commandMap.mapEvent( SpellEvent.DELETE, SpellDeleteCommand );
		}
	}
}