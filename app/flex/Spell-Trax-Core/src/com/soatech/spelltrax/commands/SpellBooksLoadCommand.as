package com.soatech.spelltrax.commands
{
	import com.soatech.spelltrax.events.SpellBookEvent;
	import com.soatech.spelltrax.models.SpellBooksProxy;
	import com.soatech.spelltrax.services.interfaces.ISpellBookService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;

	public class SpellBooksLoadCommand extends Command implements IResponder
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
		public var spellBookService:ISpellBookService;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function execute():void
		{
			spellBookService.load(this);
		}
		
		//---------------------------------------------------------------------
		//
		// Handlers
		//
		//---------------------------------------------------------------------
		
		public function result(data:Object):void
		{
			spellBooksProxy.bookList = data as ArrayCollection;
		}
		
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("SpellBooksLoadCommand::fault: " + info.toString()); }
		}
	}
}