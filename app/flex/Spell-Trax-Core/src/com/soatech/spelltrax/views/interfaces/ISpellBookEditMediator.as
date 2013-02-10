package com.soatech.spelltrax.views.interfaces
{
	import com.soatech.spelltrax.events.SelectToggleEvent;
	import com.soatech.spelltrax.events.SpellBookEvent;
	
	import flash.events.MouseEvent;

	public interface ISpellBookEditMediator
	{
		function get view():ISpellBookEdit;
		function addBtn_clickHandler(event:MouseEvent):void;
		function backBtn_clickHandler(event:MouseEvent):void;
		function book_createSuccessHandler(event:SpellBookEvent):void;
		function book_saveSuccessHandler(event:SpellBookEvent):void;
		function book_spellListChangedHandler(event:SpellBookEvent):void;
		function refreshBtn_clickHandler(event:MouseEvent):void;
		function saveBtn_clickHandler(event:MouseEvent):void;
		function spellList_selectEditHandler(event:SelectToggleEvent):void;
		function spellList_selectToggleHandler(event:SelectToggleEvent):void;
		function populate():void;
		function setup():void;
	}
}