package com.soatech.spelltrax.models
{
	import com.soatech.spelltrax.events.SpellBookEvent;
	import com.soatech.spelltrax.models.vo.SpellBook;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SpellBooksProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// bookList
		//-----------------------------
		
		private var _bookList : ArrayCollection;
		
		public function get bookList():ArrayCollection
		{
			return this._bookList;
		}
		
		public function set bookList(value:ArrayCollection):void
		{
			this._bookList = value;
			
			dispatch( new SpellBookEvent( SpellBookEvent.LIST_CHANGED, null, _bookList ) );
		}
		
		//-----------------------------
		// selectedBook
		//-----------------------------
		
		private var _selectedBook:SpellBook;
		
		public function get selectedBook():SpellBook
		{
			return this._selectedBook;
		}
		
		public function set selectedBook(value:SpellBook):void
		{
			this._selectedBook = value;
			
			dispatch( new SpellBookEvent( SpellBookEvent.SELECTED_CHANGED, value ) );
		}
		
		//-----------------------------
		// spellList
		//-----------------------------
		
		private var _spellList:ArrayCollection;
		
		public function get spellList():ArrayCollection
		{
			return this._spellList;
		}
		
		public function set spellList(value:ArrayCollection):void
		{
			this._spellList = value;
			
			dispatch( new SpellBookEvent( SpellBookEvent.SPELL_LIST_CHANGED, null, null, value ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param spellBook
		 * 
		 */		
		public function addBook(book:SpellBook):void
		{
			if( !_bookList )
				_bookList = new ArrayCollection();
			
			_bookList.addItem(book);
			
			dispatch( new SpellBookEvent( SpellBookEvent.LIST_CHANGED, null, _bookList ) );
		}
		
		/**
		 * 
		 * @param book
		 * 
		 */		
		public function removeBook(book:SpellBook):void
		{
			if( !_bookList )
				return;
			
			for( var i:int = 0; i < _bookList.length; i++ )
			{
				if( SpellBook(_bookList.getItemAt(i)).pid === book.pid )
					_bookList.removeItemAt(i);
			}
			
			dispatch( new SpellBookEvent( SpellBookEvent.LIST_CHANGED, null, _bookList ) );
		}
		
		/**
		 * 
		 * @param book
		 * 
		 */		
		public function replaceBook(book:SpellBook):void
		{
			if( !_bookList )
				return;
			
			for( var i:int = 0; i < _bookList.length; i++ )
			{
				if( SpellBook(_bookList.getItemAt(i)).pid === book.pid )
					_bookList.setItemAt(book, i);
			}
			
			dispatch( new SpellBookEvent( SpellBookEvent.LIST_CHANGED, null, _bookList ) );
		}
	}
}