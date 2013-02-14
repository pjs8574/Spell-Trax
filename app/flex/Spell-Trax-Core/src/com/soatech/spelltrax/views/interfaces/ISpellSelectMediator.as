package com.soatech.spelltrax.views.interfaces {
import com.soatech.spelltrax.events.SelectToggleEvent;
import com.soatech.spelltrax.events.SpellBookEvent;
import com.soatech.spelltrax.events.SpellEvent;

import flash.events.MouseEvent;

public interface ISpellSelectMediator {
    function get view():ISpellSelect;
    function addBtn_clickHandler(event:MouseEvent):void;
    function backBtn_clickHandler(event:MouseEvent):void;
    function book_linkSpellSuccessHandler(event:SpellBookEvent):void
    function spells_listChangedHandler(event:SpellEvent):void;
    function spellList_selectEditHandler(event:SelectToggleEvent):void
    function spellList_selectToggleHandler(event:SelectToggleEvent):void;
    function populate():void;
    function setup():void;
}
}
