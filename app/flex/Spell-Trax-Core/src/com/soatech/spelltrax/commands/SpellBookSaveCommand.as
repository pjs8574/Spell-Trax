package com.soatech.spelltrax.commands {
import com.soatech.spelltrax.events.SpellBookEvent;
import com.soatech.spelltrax.models.SpellBooksProxy;
import com.soatech.spelltrax.models.vo.SpellBook;
import com.soatech.spelltrax.services.interfaces.ISpellBookService;

import mx.rpc.IResponder;

import org.robotlegs.mvcs.Command;

public class SpellBookSaveCommand extends Command implements IResponder {

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
        spellBookService.save(event.spellBook, this);
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
        spellBooksProxy.replaceBook(data as SpellBook);
        dispatch(new SpellBookEvent(SpellBookEvent.SAVE_SUCCESS));
    }

    /**
     *
     * @param info
     */
    public function fault(info:Object):void
    {
        CONFIG::debugtrace{ trace("SpellBookSaveCommand::fault: " + info.toString()); }
    }
}
}
