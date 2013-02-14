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
        public static const CREATE_SUCCESS:String = "SpellEvent.CREATE_SUCCESS";
		public static const EDIT:String = "SpellEvent.EDIT";
        public static const DELETE:String = "SpellEvent.DELETE";
        public static const DELETE_SUCCESS:String = "SpellEvent.DELETE_SUCCESS";
		public static const LIST_CHANGED:String = "SpellEvent.LIST_CHANGED";
		public static const LOAD:String = "SpellEvent.LOAD";
        public static const NEW_SPELL:String = "SpellEvent.NEW_SPELL";
		public static const SAVE:String = "SpellEvent.SAVE";
        public static const SAVE_SUCCESS:String = "SpellEvent.SAVE_SUCCESS";
		public static const SELECT:String = "SpellEvent.SELECT";
        public static const SELECTED_CHANGED:String = "SpellEvent.SELECTED_CHANGED";
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

        /**
         *
         * @param type
         * @param spell
         * @param spellList
         * @param bubbles
         * @param cancelable
         */
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