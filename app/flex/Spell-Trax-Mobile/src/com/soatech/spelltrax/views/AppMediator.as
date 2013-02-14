package com.soatech.spelltrax.views
{
	import com.soatech.spelltrax.events.DataBaseEvent;
import com.soatech.spelltrax.events.NavigationEvent;
import com.soatech.spelltrax.events.SpellBookEvent;
import com.soatech.spelltrax.events.SpellEvent;
import com.soatech.spelltrax.views.components.SpellBookEdit;
	import com.soatech.spelltrax.views.components.SpellBookSelect;
import com.soatech.spelltrax.views.components.SpellEdit;
import com.soatech.spelltrax.views.components.SpellSelect;
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
			
			addContextListener(DataBaseEvent.CONNECTED, db_connectedHandler);
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------

        /**
         *
         * @param event
         */
        override public function book_addSpellHandler(event:SpellBookEvent):void {
            view.navigator.pushView( SpellSelect, event.spellBook );
        }

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
		
		/**
		 * 
		 * @param event
		 * 
		 */
		protected function db_connectedHandler(event:DataBaseEvent):void
		{
			view.navigator.pushView(SpellBookSelect);
		}

        /**
         *
         * @param event
         */
        override public function navigation_backHandler(event:NavigationEvent):void
        {
            view.navigator.popView();
        }

        /**
         *
         * @param event
         */
        override public function spell_newHandler(event:SpellEvent):void
        {
            view.navigator.pushView(SpellEdit, event.spell);
        }

        /**
         *
         * @param event
         */
        override public function spell_editHandler(event:SpellEvent):void
        {
            view.navigator.pushView(SpellEdit, event.spell);
        }
	}
}