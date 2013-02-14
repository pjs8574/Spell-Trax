package com.soatech.spelltrax.commands
{
	import com.soatech.spelltrax.events.SpellEvent;
	import com.soatech.spelltrax.models.SpellsProxy;
	import com.soatech.spelltrax.services.interfaces.ISpellService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Command;
	
	public class SpellsLoadCommand extends Command implements IResponder
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var event:SpellEvent;
		
		[Inject]
		public var spellsProxy:SpellsProxy;
		
		[Inject]
		public var spellService:ISpellService;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override public function execute():void
		{
			spellService.load(this);
		}
		
		//---------------------------------------------------------------------
		//
		// Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param data
		 * 
		 */		
		public function result(data:Object):void
		{
			spellsProxy.spellList = data as ArrayCollection;
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */		
		public function fault(info:Object):void
		{
			CONFIG::debugtrace{ trace("SpellsLoadCommand::fault: " + info.toString()); }
		}
	}
}