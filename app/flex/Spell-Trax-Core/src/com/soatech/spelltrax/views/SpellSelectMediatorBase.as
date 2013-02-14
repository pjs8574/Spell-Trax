package com.soatech.spelltrax.views {
import com.soatech.spelltrax.events.NavigationEvent;
import com.soatech.spelltrax.events.SelectToggleEvent;
import com.soatech.spelltrax.events.SpellBookEvent;
import com.soatech.spelltrax.events.SpellEvent;
import com.soatech.spelltrax.models.SpellsProxy;
import com.soatech.spelltrax.models.vo.Spell;
import com.soatech.spelltrax.models.vo.SpellBook;
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

    //-----------------------------
    // book
    //-----------------------------

    private var _book:SpellBook;

    public function get book():SpellBook
    {
        return _book;
    }

    public function set book(value:SpellBook):void
    {
        _book = value;
    }

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
        addContextListener( SpellBookEvent.LINK_SPELL_SUCCESS, this.book_linkSpellSuccessHandler );
        addContextListener( SpellEvent.LIST_CHANGED, this.spells_listChangedHandler );

        // view events
        eventMap.mapListener( view.addBtn, MouseEvent.CLICK, this.addBtn_clickHandler );
        eventMap.mapListener( view.backBtn, MouseEvent.CLICK, this.backBtn_clickHandler );
        eventMap.mapListener( view.spellList, SelectToggleEvent.EDIT, spellList_selectEditHandler );
        eventMap.mapListener( view.spellList, SelectToggleEvent.TOGGLE, spellList_selectToggleHandler );

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

    /**
     *
     * @param event
     */
    public function backBtn_clickHandler(event:MouseEvent):void {
        dispatch(new NavigationEvent(NavigationEvent.BACK));
    }

    /**
     *
     * @param event
     */
    public function book_linkSpellSuccessHandler(event:SpellBookEvent):void {
        this.backBtn_clickHandler(null);
    }

    /**
     *
     * @param event
     */
    public function spells_listChangedHandler(event:SpellEvent):void {
        this.populate();
    }

    /**
     *
     * @param event
     *
     */
    public function spellList_selectEditHandler(event:SelectToggleEvent):void
    {
        dispatch( new SpellEvent( SpellEvent.EDIT, (event.data as Spell) ) );
    }

    /**
     *
     * @param event
     */
    public function spellList_selectToggleHandler(event:SelectToggleEvent):void
    {
        var spell:Spell = Spell(event.data);

        if( spell && spell.pid && book && book.pid )
            dispatch(new SpellBookEvent(SpellBookEvent.LINK_SPELL,book,null,null,spell));
    }
}
}
