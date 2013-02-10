package com.soatech.spelltrax.views
{
	import com.soatech.spelltrax.events.SelectToggleEvent;
	import com.soatech.spelltrax.events.SpellBookEvent;
	import com.soatech.spelltrax.events.SpellEvent;
	import com.soatech.spelltrax.models.SpellBooksProxy;
	import com.soatech.spelltrax.models.vo.Spell;
	import com.soatech.spelltrax.models.vo.SpellBook;
	import com.soatech.spelltrax.views.interfaces.ISpellBookEdit;
	import com.soatech.spelltrax.views.interfaces.ISpellBookEditMediator;
	
	import flash.events.MouseEvent;
	
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class SpellBookEditMediatorBase extends Mediator implements ISpellBookEditMediator, IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var spellBooksProxy:SpellBooksProxy;
		
		//-----------------------------
		// book
		//-----------------------------
		
		private var _book:SpellBook;
		
		public function get book():SpellBook
		{
			return _book;
		}
		
		public function set book(value:SpellBook):void
		{
			_book = value;
		}
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():ISpellBookEdit
		{
			return this.viewComponent as ISpellBookEdit;
		}
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var nameValidator:StringValidator;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// context events
			addContextListener( SpellBookEvent.CREATE_SUCCESS, this.book_createSuccessHandler );
			addContextListener( SpellBookEvent.SAVE_SUCCESS, this.book_saveSuccessHandler );
			addContextListener( SpellBookEvent.SPELL_LIST_CHANGED, book_spellListChangedHandler );
			
			// view events
			eventMap.mapListener( view.addBtn, MouseEvent.CLICK, addBtn_clickHandler );
			eventMap.mapListener( view.backBtn, MouseEvent.CLICK, backBtn_clickHandler );
			eventMap.mapListener( view.deleteBtn, MouseEvent.CLICK, backBtn_clickHandler );
			eventMap.mapListener( view.refreshBtn, MouseEvent.CLICK, refreshBtn_clickHandler );
			eventMap.mapListener( view.saveBtn, MouseEvent.CLICK, saveBtn_clickHandler );
			eventMap.mapListener( view.spellList, SelectToggleEvent.EDIT, spellList_selectEditHandler );
			eventMap.mapListener( view.spellList, SelectToggleEvent.TOGGLE, spellList_selectToggleHandler );
			
			setup();
			
			dispatch(new SpellBookEvent(SpellBookEvent.LOAD_SPELL_LIST, book));
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		public function populate():void
		{
			view.nameInput.text = book.name;
			
			view.deleteBtn.enabled = (book.pid > 0);
		}
		
		/**
		 * 
		 * 
		 */		
		public function setup():void
		{
			book = spellBooksProxy.selectedBook;
			
			if( !book )
				book = new SpellBook();
			
			setupValidators();
			populate();
		}
		
		/**
		 * 
		 * 
		 */		
		protected function setupValidators():void
		{
			nameValidator = new StringValidator();
			nameValidator.source = book;
			nameValidator.property = "name";
			nameValidator.listener = view.nameInput;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function validateAll():Boolean
		{
			var result:Array;
			
			result = Validator.validateAll( [nameValidator] );
			
			if( result && result.length )
				return false;
			
			return true;
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		public function addBtn_clickHandler(event:MouseEvent):void
		{
		}
		
		public function backBtn_clickHandler(event:MouseEvent):void
		{
			dispatch( new SpellBookEvent( SpellBookEvent.EDIT_BACK ) );
		}
		
		public function book_createSuccessHandler(event:SpellBookEvent):void
		{
			this.book_saveSuccessHandler(event);
		}
		
		public function book_saveSuccessHandler(event:SpellBookEvent):void
		{
			this.book = event.spellBook;
			
			this.populate();
		}
		
		public function book_spellListChangedHandler(event:SpellBookEvent):void
		{
			view.spellList.dataProvider = event.spellList;
		}
		
		public function refreshBtn_clickHandler(event:MouseEvent):void
		{
		}
		
		public function saveBtn_clickHandler(event:MouseEvent):void
		{
			book.name = view.nameInput.text;
			
			if( !validateAll() )
				return;
			
			if( book.pid )
				dispatch( new SpellBookEvent( SpellBookEvent.SAVE, book ) );
			else
				dispatch( new SpellBookEvent( SpellBookEvent.CREATE, book ) );
				
		}
		
		public function spellList_selectEditHandler(event:SelectToggleEvent):void
		{
			dispatch( new SpellEvent( SpellEvent.EDIT, (event.data as Spell) ) );
		}
		
		public function spellList_selectToggleHandler(event:SelectToggleEvent):void
		{
			dispatch( new SpellEvent( SpellEvent.TOGGLE_USE, (event.data as Spell) ) );
		}
	}
}