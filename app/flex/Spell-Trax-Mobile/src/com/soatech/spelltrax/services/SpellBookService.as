package com.soatech.spelltrax.services
{
	import com.soatech.spelltrax.models.vo.SpellBook;
	import com.soatech.spelltrax.services.interfaces.ISpellBookService;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class SpellBookService implements ISpellBookService
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
		
		/**
		 * 
		 * @param book
		 * @param responder
		 * 
		 */		
		public function create(book:SpellBook, responder:IResponder):void
		{
			book.pid = Math.floor(Math.random()*1337);
			
			responder.result(book);
		}
		
		/**
		 * 
		 * @param responder
		 * 
		 */		
		public function load(responder:IResponder):void
		{
			var list:Array = [];
			
			list.push(new SpellBook(123, "Combat"));
			list.push(new SpellBook(123, "Adenture"));
			
			responder.result(new ArrayCollection(list));
		}
	}
}