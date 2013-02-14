package com.soatech.spelltrax.views.interfaces {
import com.soatech.spelltrax.events.SpellEvent;

import flash.events.MouseEvent;

public interface ISpellEditMediator {
    function get view():ISpellEdit;
    function addBtn_clickHandler(event:MouseEvent):void;
    function backBtn_clickHandler(event:MouseEvent):void;
    function deleteBtn_clickHandler(event:MouseEvent):void;
    function saveBtn_clickHandler(event:MouseEvent):void;
    function spell_createSuccessHandler(event:SpellEvent):void;
    function spell_deleteSuccessHandler(event:SpellEvent):void;
    function spell_saveSuccessHandler(event:SpellEvent):void;
    function populate():void;
    function setup():void;
}
}
