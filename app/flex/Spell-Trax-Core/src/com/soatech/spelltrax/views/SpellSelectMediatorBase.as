package com.soatech.spelltrax.views {
import com.soatech.spelltrax.events.NavigationEvent;
import com.soatech.spelltrax.events.SpellEvent;
import com.soatech.spelltrax.models.SpellsProxy;
import com.soatech.spelltrax.models.vo.Spell;
import com.soatech.spelltrax.views.interfaces.ISpellSelect;
import com.soatech.spelltrax.views.interfaces.ISpellSelectMediator;

import flash.events.MouseEvent;

import org.robotlegs.core.IMediator;

import org.robotlegs.mvcs.Mediator;

import spark.events.IndexChangeEvent;

public class SpellSelectMediatorBase extends Mediator implements ISpellSelectMediator, IMediator {

    //-------------------------------------------------------------------------
    //
    // Properties
    //
    //-------------------------------------------------------------------------

    [Inject]
    public var spellsProxy:SpellsProxy;

    //---------------------------------
    // view
    //---------------------------------

    public function get view():ISpellSelect
    {
        return this.viewComponent as ISpellSelect;
    }

    //---------------------------------------------------------------------
    //
    // Overridden Methods
    //
    //---------------------------------------------------------------------

    override public function onRegister():void
    {
        super.onRegister();

        // context events
        addContextListener( SpellEvent.LIST_CHANGED, this.spells_listChangedHandler );

        // view events
        eventMap.mapListener( view.addBtn, MouseEvent.CLICK, this.addBtn_clickHandler );
        eventMap.mapListener( view.backBtn, MouseEvent.CLICK, this.backBtn_clickHandler );

        this.setup();
    }

    //---------------------------------------------------------------------
    //
    // Methods
    //
    //---------------------------------------------------------------------

    public function populate():void
    {
        view.spellList.dataProvider = spellsProxy.spellList;
    }

    public function setup():void
    {
        dispatch( new SpellEvent(SpellEvent.LOAD) );
    }

    //---------------------------------------------------------------------
    //
    // Event Handlers
    //
    //---------------------------------------------------------------------

    /**
     *
     * @param event
     */
    public function addBtn_clickHandler(event:MouseEvent):void {
        dispatch(new SpellEvent(SpellEvent.NEW_SPELL, new Spell()));
    }

    public function backBtn_clickHandler(event:MouseEvent):void {
        dispatch(new NavigationEvent(NavigationEvent.BACK));
    }

    public function spells_listChangedHandler(event:SpellEvent):void {
        this.populate();
    }

    public function spellList_changeHandler(event:IndexChangeEvent):void {
        // if we came from a spell book,
        // then link the spell to the book
        // then close view
    }
}
}
