package com.soatech.spelltrax.events
{
import com.soatech.spelltrax.models.vo.Spell;
import com.soatech.spelltrax.models.vo.SpellBook;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class SpellBookEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------

        public static const ADD_SPELL:String = "SpellBookEvent.ADD_SPELL";
		public static const CREATE:String = "SpellBookEvent.CREATE";
		public static const CREATE_SUCCESS:String = "SpellBookEvent.CREATE_SUCCESS";
        public static const DELETE:String = "SpellBookEvent.DELETE";
        public static const DELETE_SUCCESS:String = "SpellBookEvent.DELETE_SUCCESS";
		public static const EDIT:String = "SpellBookEvent.EDIT";
		public static const EDIT_BACK:String = "SpellBookEvent.EDIT_BACK";
        public static const LINK_SPELL:String = "SpellBookEvent.LINK_SPELL";
        public static const LINK_SPELL_SUCCESS:String = "SpellBookEvent.LINK_SPELL_SUCCESS";
		public static const LIST_CHANGED:String = "SpellBookEvent.LIST_CHANGED";
		public static const LOAD:String = "SpellBookEvent.LOAD";
		public static const LOAD_SPELL_LIST:String = "SpellBookEvent.LOAD_SPELL_LIST";
		public static const NEW_BOOK:String = "SpellBookEvent.NEW_BOOK";
		public static const SAVE:String = "SpellBookEvent.SAVE";
		public static const SAVE_SUCCESS:String = "SpellBookEvent.SAVE_SUCCESS";
		public static const SELECT:String = "SpellBookEvent.SELECT";
		public static const SELECTED_CHANGED:String = "SpellBookEvent.SELECTED_CHANGED";
		public static const SPELL_LIST_CHANGED:String = "SpellBookEvent.SPELL_LIST_CHANGED";
		
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var spellBook:SpellBook;
		public var bookList:ArrayCollection;
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
		 * @param spellBook
		 * @param bookList
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function SpellBookEvent(type:String, spellBook:SpellBook=null, 
									   bookList:ArrayCollection=null, 
									   spellList:ArrayCollection=null,
                                       spell:Spell = null,
									   bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			this.spellBook = spellBook;
			this.bookList = bookList;
			this.spellList = spellList;
            this.spell = spell;
			
			super(type, bubbles, cancelable);
		}
	}
}