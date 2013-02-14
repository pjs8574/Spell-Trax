package com.soatech.spelltrax.services.interfaces
{
	import com.soatech.spelltrax.models.vo.Spell;
	import com.soatech.spelltrax.models.vo.SpellBook;
	
	import mx.rpc.IResponder;

	public interface ISpellService
	{
		function create(spell:Spell, responder:IResponder):void;
		function load(responder:IResponder):void;
		function loadByBook(book:SpellBook, responder:IResponder):void;
        function save(spell:Spell,  responder:IResponder):void;
	}
}