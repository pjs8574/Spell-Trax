package com.soatech.spelltrax.commands {
import com.soatech.spelltrax.events.SpellBookEvent;
import com.soatech.spelltrax.models.SpellBooksProxy;
import com.soatech.spelltrax.services.interfaces.ISpellBookService;

import mx.rpc.IResponder;

import org.robotlegs.mvcs.Command;

public class SpellBookLinkSpellCommand extends Command implements IResponder {

    //-------------------------------------------------------------------------
    //
    // Properties
    //
    //-------------------------------------------------------------------------

    [Inject]
    public var event:SpellBookEvent;

    [Inject]
    public var spellBooksProxy:SpellBooksProxy;

    [Inject]
    public var spellBookService:ISpellBookService;

    //-------------------------------------------------------------------------
    //
    // Overridden Methods
    //
    //-------------------------------------------------------------------------

    override public function execute():void
    {
        spellBookService.linkSpell(event.spellBook, event.spell, this);
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
        dispatch(new SpellBookEvent(SpellBookEvent.LINK_SPELL_SUCCESS, event.spellBook, null, null, event.spell));
    }

    /**
     *
     * @param info
     */
    public function fault(info:Object):void
    {
        CONFIG::debugtrace{ trace("SpellBookLinkSpellCommand::fault: " + info.toString()); }
    }
}
}
