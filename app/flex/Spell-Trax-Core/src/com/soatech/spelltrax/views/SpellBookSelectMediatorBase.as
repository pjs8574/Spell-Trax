package com.soatech.spelltrax.views
{
	import com.soatech.spelltrax.events.SpellBookEvent;
	import com.soatech.spelltrax.models.SpellBooksProxy;
	import com.soatech.spelltrax.models.vo.SpellBook;
	import com.soatech.spelltrax.views.interfaces.ISpellBookSelect;
	import com.soatech.spelltrax.views.interfaces.ISpellBookSelectMediator;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class SpellBookSelectMediatorBase extends Mediator implements ISpellBookSelectMediator, IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var spellBooksProxy:SpellBooksProxy;
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():ISpellBookSelect
		{
			return viewComponent as ISpellBookSelect;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// context events
			addContextListener( SpellBookEvent.LIST_CHANGED, this.books_listChangedHandler );
			
			// view events
			eventMap.mapListener( view.addBtn, MouseEvent.CLICK, this.addBtn_clickHandler );
			eventMap.mapListener( view.bookList, IndexChangeEvent.CHANGE, this.bookList_changeHandler );
			
			this.setup();
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------

		public function populate():void
		{
			view.bookList.dataProvider = spellBooksProxy.bookList;
		}
		
		public function setup():void
		{
			dispatch( new SpellBookEvent( SpellBookEvent.LOAD ) );
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function addBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new SpellBookEvent( SpellBookEvent.NEW_BOOK, new SpellBook() ) );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function books_listChangedHandler(event:SpellBookEvent):void
		{
			this.populate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function bookList_changeHandler(event:IndexChangeEvent):void
		{
			var book:SpellBook = view.bookList.dataProvider.getItemAt(event.newIndex) as SpellBook;
			
			if( !book )
				return;
			
			dispatch( new SpellBookEvent( SpellBookEvent.EDIT, book ) );
		}
	}
}