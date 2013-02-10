package com.soatech.spelltrax.services
{
	import com.soatech.spelltrax.models.vo.Spell;
	import com.soatech.spelltrax.models.vo.SpellBook;
	import com.soatech.spelltrax.services.interfaces.ISpellService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class SpellService implements ISpellService
	{
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var _responder:IResponder;
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		public function create(spell:Spell, responder:IResponder):void
		{
			spell.pid = Math.floor(Math.random()*1337);
			
			responder.result(spell);
		}
		
		/**
		 * 
		 * @param responder
		 * 
		 */		
		public function load(responder:IResponder):void
		{
			this._responder = responder;
			
			responder.result(new ArrayCollection());
		}
		
		public function loadByBook(book:SpellBook, responder:IResponder):void
		{
			this._responder = responder;
			
			var list:ArrayCollection = new ArrayCollection();
			list.addItem(new Spell(1, "Cure Minor Wounds"));
			list.addItem(new Spell(2, "Cure Light Wounds", 1));
			list.addItem(new Spell(3, "Cure Moderate Wounds", 2));
			list.addItem(new Spell(4, "Cure Light Wounds", 1, true));
			list.addItem(new Spell(5, "Cure Moderate Wounds", 2, true));
			
			responder.result(list);
		}
	}
}