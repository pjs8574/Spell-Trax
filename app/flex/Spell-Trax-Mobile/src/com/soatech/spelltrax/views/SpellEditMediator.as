package com.soatech.spelltrax.views {
import com.soatech.spelltrax.models.vo.Spell;
import com.soatech.spelltrax.views.components.SpellEdit;
import com.soatech.spelltrax.views.interfaces.ISpellEditMediator;

import org.robotlegs.core.IMediator;

public class SpellEditMediator extends SpellEditMediatorBase implements ISpellEditMediator, IMediator {

    //-------------------------------------------------------------------------
    //
    // Properties
    //
    //-------------------------------------------------------------------------

    //-----------------------------
    // localView
    //-----------------------------

    public function get localView():SpellEdit
    {
        return viewComponent as SpellEdit;
    }

    //---------------------------------
    // spell
    //---------------------------------

    override public function get spell():Spell
    {
        return Spell(localView.data);
    }
}
}
