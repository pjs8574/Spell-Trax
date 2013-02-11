package com.soatech.spelltrax.events {
import flash.events.Event;

public class NavigationEvent extends Event {

    //-------------------------------------------------------------------------
    //
    // Events
    //
    //-------------------------------------------------------------------------

    public static const BACK:String = "NavigationEvent.BACK";

    //-------------------------------------------------------------------------
    //
    // Events
    //
    //-------------------------------------------------------------------------

    /**
     *
     * @param type
     * @param bubbles
     * @param cancelable
     */
    public function NavigationEvent(type:String,  bubbles:Boolean=false, cancelable:Boolean=false) {
        super(type, bubbles, cancelable);
    }
}
}
