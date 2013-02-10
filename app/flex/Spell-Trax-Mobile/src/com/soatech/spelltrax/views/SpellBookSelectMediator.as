package com.soatech.spelltrax.views
{
	import com.soatech.spelltrax.views.interfaces.ISpellBookSelectMediator;
	
	import org.robotlegs.core.IMediator;
	import com.soatech.spelltrax.views.components.SpellBookSelect;
	
	public class SpellBookSelectMediator extends SpellBookSelectMediatorBase implements ISpellBookSelectMediator, IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// localView
		//-----------------------------
		
		public function get localView():SpellBookSelect
		{
			return this.viewComponent as SpellBookSelect;
		}
	}
}