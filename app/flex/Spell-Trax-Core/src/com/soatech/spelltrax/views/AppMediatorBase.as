package com.soatech.spelltrax.views
{
import com.soatech.spelltrax.events.NavigationEvent;
import com.soatech.spelltrax.events.SpellBookEvent;
import com.soatech.spelltrax.events.SpellEvent;
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

            addContextListener( NavigationEvent.BACK, this.navigation_backHandler );
            addContextListener( SpellBookEvent.ADD_SPELL, this.book_addSpellHandler );
            addContextListener( SpellBookEvent.EDIT, this.book_editHandler );
            addContextListener( SpellBookEvent.EDIT_BACK, this.book_editBackHandler );
            addContextListener( SpellBookEvent.NEW_BOOK, this.book_newHandler );
            addContextListener( SpellEvent.NEW_SPELL, this.spell_newHandler );
            addContextListener( SpellEvent.EDIT, this.spell_editHandler );
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
        public function book_addSpellHandler(event:SpellBookEvent):void {
            CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::book_addSpellHandler" ); };
        }

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

        public function navigation_backHandler(event:NavigationEvent):void
        {
            CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::navigation_backHandler" ); };
        }

        public function spell_newHandler(event:SpellEvent):void
        {
            CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::spell_newHandler" ); };
        }

        public function spell_editHandler(event:SpellEvent):void
        {
            CONFIG::debugtrace{ trace("Not Yet Implemented: AppMediatorBase::spell_editHandler" ); };
        }
    }
}