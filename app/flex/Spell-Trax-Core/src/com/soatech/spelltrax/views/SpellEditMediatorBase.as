/**
 * Created with IntelliJ IDEA.
 * User: eric
 * Date: 2/13/13
 * Time: 5:14 PM
 * To change this template use File | Settings | File Templates.
 */
package com.soatech.spelltrax.views {
import com.soatech.spelltrax.events.NavigationEvent;
import com.soatech.spelltrax.events.SpellEvent;
import com.soatech.spelltrax.models.SpellsProxy;
import com.soatech.spelltrax.models.vo.Spell;
import com.soatech.spelltrax.views.interfaces.ISpellEdit;
import com.soatech.spelltrax.views.interfaces.ISpellEditMediator;

import flash.events.MouseEvent;

import mx.validators.StringValidator;
import mx.validators.Validator;

import org.robotlegs.core.IMediator;
import org.robotlegs.mvcs.Mediator;

import spark.validators.NumberValidator;

public class SpellEditMediatorBase extends Mediator implements ISpellEditMediator, IMediator {

    //-------------------------------------------------------------------------
    //
    // Properties
    //
    //-------------------------------------------------------------------------

    [Inject]
    public var spellsProxy:SpellsProxy;

    //---------------------------------
    // spell
    //---------------------------------

    private var _spell:Spell;

    public function get spell():Spell
    {
        return _spell;
    }

    public function set spell(value:Spell):void
    {
        _spell = value;
    }

    //---------------------------------
    // view
    //---------------------------------

    public function get view():ISpellEdit {
        return viewComponent as ISpellEdit;
    }

    //-------------------------------------------------------------------------
    //
    // Variables
    //
    //-------------------------------------------------------------------------

    protected var _nameValidator:StringValidator;
    protected var _levelValidator:NumberValidator;

    //-------------------------------------------------------------------------
    //
    // Overridden Methods
    //
    //-------------------------------------------------------------------------

    override public function onRegister():void
    {
        super.onRegister();

        // context events
        addContextListener(SpellEvent.CREATE_SUCCESS, this.spell_createSuccessHandler);
        addContextListener(SpellEvent.DELETE_SUCCESS, this.spell_deleteSuccessHandler);
        addContextListener(SpellEvent.SAVE_SUCCESS, this.spell_saveSuccessHandler);

        // view events
        eventMap.mapListener(view.backBtn, MouseEvent.CLICK, this.backBtn_clickHandler);
        eventMap.mapListener(view.deleteBtn, MouseEvent.CLICK, this.deleteBtn_clickHandler);
        eventMap.mapListener(view.saveBtn, MouseEvent.CLICK, this.saveBtn_clickHandler);

        setup();
    }

    //-------------------------------------------------------------------------
    //
    // Overridden Methods
    //
    //-------------------------------------------------------------------------

    public function populate():void
    {
        view.nameInput.text = spell.name;
        view.descTextArea.text = spell.description;
        view.notesTextArea.text = spell.notes;

        view.deleteBtn.enabled = (spell.pid > 0);
    }

    public function setup():void
    {
        spell = spellsProxy.selectedSpell;

        if( !spell )
            spell = new Spell();

        setupValidators();
        populate();
    }

    protected function setupValidators():void
    {
        _nameValidator = new StringValidator();
        _nameValidator.source = spell;
        _nameValidator.property = "name";
        _nameValidator.listener = view.nameInput;

        _levelValidator = new NumberValidator();
        _levelValidator.source = spell;
        _levelValidator.property = "level";
        _levelValidator.listener = view.levelInput;
    }

    protected function validateAll():Boolean
    {
        var result:Array;

        result = Validator.validateAll([_nameValidator, _levelValidator]);

        if( result && result.length )
            return false;

        return true;
    }

    //-------------------------------------------------------------------------
    //
    // Event Handlers
    //
    //-------------------------------------------------------------------------

    /**
     *
     * @param event
     */
    public function addBtn_clickHandler(event:MouseEvent):void
    {
        this.saveBtn_clickHandler(null);
    }

    /**
     *
     * @param event
     */
    public function backBtn_clickHandler(event:MouseEvent):void
    {
        dispatch(new NavigationEvent(NavigationEvent.BACK));
    }

    /**
     *
     * @param event
     */
    public function deleteBtn_clickHandler(event:MouseEvent):void
    {
        if( spell.pid )
            dispatch(new SpellEvent(SpellEvent.DELETE, spell));
    }

    /**
     *
     * @param event
     */
    public function saveBtn_clickHandler(event:MouseEvent):void
    {
        spell.description = view.descTextArea.text;
        spell.isDomain = view.domainCheckBox.selected;
        spell.level = int(view.levelInput.text);
        spell.name = view.nameInput.text;
        spell.notes = view.notesTextArea.text;

        if( !validateAll() )
            return;

        if( spell.pid )
            dispatch(new SpellEvent(SpellEvent.SAVE, spell));
        else
            dispatch(new SpellEvent(SpellEvent.CREATE, spell));
    }

    /**
     *
     * @param event
     */
    public function spell_createSuccessHandler(event:SpellEvent):void
    {
        this.spell_saveSuccessHandler(event);
    }

    /**
     *
     * @param event
     */
    public function spell_deleteSuccessHandler(event:SpellEvent):void
    {
        this.backBtn_clickHandler(null);
    }

    /**
     *
     * @param event
     */
    public function spell_saveSuccessHandler(event:SpellEvent):void
    {
        this.spell = event.spell;

        this.populate();
    }
}
}
