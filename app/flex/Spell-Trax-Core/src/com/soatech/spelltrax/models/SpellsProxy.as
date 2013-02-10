package com.soatech.spelltrax.models
{
	import com.soatech.spelltrax.events.SpellEvent;
	import com.soatech.spelltrax.models.vo.Spell;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SpellsProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// spellList
		//-----------------------------
		
		private var _spellList : ArrayCollection;
		
		public function get spellList():ArrayCollection {
			return this._spellList;
		}
		
		public function set spellList(value:ArrayCollection):void {
			this._spellList = value;
			
			dispatch( new SpellEvent( SpellEvent.LIST_CHANGED, null, _spellList ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param spell
		 * 
		 */		
		public function addSpell(spell:Spell):void
		{
			if( !_spellList )
				_spellList = new ArrayCollection();
			
			_spellList.addItem(spell);
			
			dispatch( new SpellEvent( SpellEvent.LIST_CHANGED, null, _spellList ) );
		}
		
		/**
		 * 
		 * @param spell
		 * 
		 */		
		public function removeSpell(spell:Spell):void
		{
			if( !_spellList )
				return;
			
			for( var i:int = 0; i < _spellList.length; i++ )
			{
				if( Spell(_spellList.getItemAt(i)).pid === spell.pid )
					_spellList.removeItemAt(i);
			}
			
			dispatch( new SpellEvent( SpellEvent.LIST_CHANGED, null, _spellList ) );
		}
		
		public function replaceSpell(spell:Spell):void
		{
			if( !_spellList )
				return;
			
			for( var i:int = 0; i < _spellList.length; i++ )
			{
				if( Spell(_spellList.getItemAt(i)).pid === spell.pid )
					_spellList.setItemAt(spell, i);
			}
			
			dispatch( new SpellEvent( SpellEvent.LIST_CHANGED, null, _spellList ) );
			
		}
	}
}