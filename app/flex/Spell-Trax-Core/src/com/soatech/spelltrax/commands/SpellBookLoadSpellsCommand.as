package com.soatech.spelltrax.commands
{
	import com.soatech.spelltrax.events.SpellBookEvent;
	import com.soatech.spelltrax.models.SpellBooksProxy;
	import com.soatech.spelltrax.services.interfaces.ISpellService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class SpellBookLoadSpellsCommand extends Command implements IResponder
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var event:SpellBookEvent;
		
		[Inject]
		public var spellBooksProxy:SpellBooksProxy;
		
		[Inject]
		public var spellService:ISpellService;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function execute():void
		{
			spellService.loadByBook( event.spellBook, this );
		}
		
		public function result(data:Object):void
		{
			spellBooksProxy.spellList = data as ArrayCollection;
		}
		
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("SpellBookLoadSpellsCommand::fault: " + info.toString()); }
		}
	}
}