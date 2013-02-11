package com.soatech.spelltrax.commands {
import com.soatech.spelltrax.events.SpellBookEvent;
import com.soatech.spelltrax.models.SpellBooksProxy;
import com.soatech.spelltrax.models.vo.SpellBook;
import com.soatech.spelltrax.services.interfaces.ISpellBookService;

import mx.rpc.IResponder;

import org.robotlegs.mvcs.Command;

public class SpellBookCreateCommand extends Command implements IResponder {

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
        spellBookService.create(event.spellBook, this);
    }

    //-------------------------------------------------------------------------
    //
    // Overridden Methods
    //
    //-------------------------------------------------------------------------

    public function result(data:Object):void
    {
        spellBooksProxy.addBook(data as SpellBook);
        dispatch(new SpellBookEvent(SpellBookEvent.CREATE_SUCCESS));
    }

    public function fault(info:Object):void
    {
        CONFIG::debugtrace{ trace("SpellBookCreateCommand::fault: " + info.toString()); }
    }
}
}
