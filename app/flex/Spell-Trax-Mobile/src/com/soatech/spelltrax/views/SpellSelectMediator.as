package com.soatech.spelltrax.views {
import com.soatech.spelltrax.models.vo.SpellBook;
import com.soatech.spelltrax.views.components.SpellSelect;
import com.soatech.spelltrax.views.interfaces.ISpellSelectMediator;

import org.robotlegs.core.IMediator;

public class SpellSelectMediator extends SpellSelectMediatorBase implements ISpellSelectMediator, IMediator {
    //---------------------------------------------------------------------
    //
    // Properties
    //
    //---------------------------------------------------------------------

    //-----------------------------
    // book
    //-----------------------------

    override public function get book():SpellBook
    {
        return SpellBook(localView.data);
    }

    //-----------------------------
    // localView
    //-----------------------------

    public function get localView():SpellSelect
    {
        return viewComponent as SpellSelect;
    }
}
}
