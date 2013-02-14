package com.soatech.spelltrax.services.interfaces
{
import com.soatech.spelltrax.models.vo.Spell;
import com.soatech.spelltrax.models.vo.SpellBook;
	
	import mx.rpc.IResponder;

	public interface ISpellBookService
	{
		function create(book:SpellBook, responder:IResponder):void;
        function linkSpell(book:SpellBook, spell:Spell, responder:IResponder):void;
        function load(responder:IResponder):void;
        function remove(book:SpellBook, responder:IResponder):void;
        function save(book:SpellBook, responder:IResponder):void;
    }
}