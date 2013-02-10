package com.soatech.spelltrax.views
{
	import com.soatech.spelltrax.models.vo.SpellBook;
	import com.soatech.spelltrax.views.components.SpellBookEdit;
	import com.soatech.spelltrax.views.interfaces.ISpellBookEditMediator;
	
	import org.robotlegs.core.IMediator;
	
	public class SpellBookEditMediator extends SpellBookEditMediatorBase implements ISpellBookEditMediator, IMediator
	{
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
		
		public function get localView():SpellBookEdit
		{
			return viewComponent as SpellBookEdit;
		}
	}
}