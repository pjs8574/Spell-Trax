package com.soatech.spelltrax.events
{
	import com.soatech.spelltrax.models.vo.Spell;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class SpellEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const CREATE:String = "SpellEvent.CREATE";
		public static const EDIT:String = "SpellEvent.EDIT";
		public static const LIST_CHANGED:String = "SpellEvent.LIST_CHANGED";
		public static const LOAD:String = "SpellEvent.LOAD";
		public static const SAVE:String = "SpellEvent.SAVE";
		public static const SELECT:String = "SpellEvent.SELECT";
		public static const TOGGLE_USE:String = "SpellEvent.USE";
		
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var spell:Spell;
		public var spellList:ArrayCollection;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		public function SpellEvent(type:String, spell:Spell=null, 
								   spellList:ArrayCollection=null, 
								   bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.spell = spell;
			this.spellList = spellList;
			
			super(type, bubbles, cancelable);
		}
	}
}