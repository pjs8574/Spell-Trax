package com.soatech.spelltrax.views
{
	import com.soatech.spelltrax.events.SpellBookEvent;
	import com.soatech.spelltrax.views.interfaces.IAppMediator;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class AppMediatorBase extends Mediator implements IAppMediator, IMediator
	{
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( SpellBookEvent.EDIT, this.book_editHandler );
			addContextListener( SpellBookEvent.EDIT_BACK, this.book_editBackHandler );
			addContextListener( SpellBookEvent.NEW_BOOK, this.book_newHandler );
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
		public function book_editHandler(event:SpellBookEvent):void {
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::book_editHandler" ); };
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function book_editBackHandler(event:SpellBookEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::book_newBackHandler" ); };
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		public function book_newHandler(event:SpellBookEvent):void
		{
			CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::book_newHandler" ); };
		}
	}
}