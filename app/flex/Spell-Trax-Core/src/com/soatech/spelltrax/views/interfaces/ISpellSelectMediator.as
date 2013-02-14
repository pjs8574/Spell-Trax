package com.soatech.spelltrax.views.interfaces {
import com.soatech.spelltrax.events.SpellBookEvent;
import com.soatech.spelltrax.events.SpellEvent;

import flash.events.MouseEvent;

import spark.events.IndexChangeEvent;

public interface ISpellSelectMediator {
    function get view():ISpellSelect;
    function addBtn_clickHandler(event:MouseEvent):void;
    function backBtn_clickHandler(event:MouseEvent):void;
    function book_linkSpellSuccessHandler(event:SpellBookEvent):void
    function spells_listChangedHandler(event:SpellEvent):void;
    function spellList_changeHandler(event:IndexChangeEvent):void;
    function populate():void;
    function setup():void;
}
}
