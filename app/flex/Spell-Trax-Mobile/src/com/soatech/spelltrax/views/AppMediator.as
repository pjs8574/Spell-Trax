package com.soatech.spelltrax.views
{
	import com.soatech.spelltrax.events.SpellBookEvent;
	import com.soatech.spelltrax.views.components.SpellBookEdit;
	import com.soatech.spelltrax.views.interfaces.IAppMediator;
	
	import org.robotlegs.core.IMediator;
	
	public class AppMediator extends AppMediatorBase implements IAppMediator, IMediator
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// view
		//-----------------------------
		
		public function get view():Mobile
		{
			return viewComponent as Mobile;
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		override public function onRegister():void
		{
			super.onRegister();
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
		override public function book_editHandler(event:SpellBookEvent):void {
			view.navigator.pushView( SpellBookEdit, event.spellBook );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function book_editBackHandler(event:SpellBookEvent):void
		{
			view.navigator.popView();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		override public function book_newHandler(event:SpellBookEvent):void
		{
			view.navigator.pushView( SpellBookEdit, event.spellBook );
		}
	}
}