package com.soatech.spelltrax.views.interfaces
{
import com.soatech.spelltrax.events.NavigationEvent;
import com.soatech.spelltrax.events.SpellBookEvent;

	public interface IAppMediator
	{
        function book_addSpellHandler(event:SpellBookEvent):void;
		function book_editHandler(event:SpellBookEvent):void;
		function book_editBackHandler(event:SpellBookEvent):void;
		function book_newHandler(event:SpellBookEvent):void;
        function navigation_backHandler(event:NavigationEvent):void;
	}
}