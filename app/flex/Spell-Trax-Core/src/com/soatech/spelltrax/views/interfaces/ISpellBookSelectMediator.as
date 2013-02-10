package com.soatech.spelltrax.views.interfaces
{
	import com.soatech.spelltrax.events.SpellBookEvent;
	
	import flash.events.MouseEvent;
	
	import spark.events.IndexChangeEvent;
	
	public interface ISpellBookSelectMediator
	{
		function get view():ISpellBookSelect;
		function addBtn_clickHandler(event:MouseEvent):void;
		function books_listChangedHandler(event:SpellBookEvent):void;
		function bookList_changeHandler(event:IndexChangeEvent):void;
		function populate():void;
		function setup():void;
	}
}