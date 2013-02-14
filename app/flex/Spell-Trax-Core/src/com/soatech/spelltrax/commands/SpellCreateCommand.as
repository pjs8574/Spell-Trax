package com.soatech.spelltrax.commands {
import com.soatech.spelltrax.events.SpellEvent;
import com.soatech.spelltrax.models.SpellsProxy;
import com.soatech.spelltrax.models.vo.Spell;
import com.soatech.spelltrax.services.interfaces.ISpellService;

import mx.rpc.IResponder;

import org.robotlegs.mvcs.Command;

public class SpellCreateCommand extends Command implements IResponder {

    //-------------------------------------------------------------------------
    //
    // Properties
    //
    //-------------------------------------------------------------------------

    [Inject]
    public var event:SpellEvent;

    [Inject]
    public var spellsProxy:SpellsProxy;

    [Inject]
    public var spellService:ISpellService;

    //-------------------------------------------------------------------------
    //
    // Overridden Methods
    //
    //-------------------------------------------------------------------------

    override public function execute():void
    {
        spellService.create(event.spell, this);
    }

    //-------------------------------------------------------------------------
    //
    // Overridden Methods
    //
    //-------------------------------------------------------------------------

    /**
     *
     * @param data
     */
    public function result(data:Object):void
    {
        spellsProxy.addSpell(data as Spell);
        dispatch(new SpellEvent(SpellEvent.CREATE_SUCCESS, data as Spell));
    }

    /**
     *
     * @param info
     */
    public function fault(info:Object):void
    {
        CONFIG::debugtrace{ trace("SpellCreateCommand::fault: " + info.toString()); }
    }
}
}
