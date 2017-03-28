package com.company.assembleegameclient.screens.events {
import com.company.assembleegameclient.appengine.SavedCharacter;

import flash.events.Event;

public class DeleteCharacterEvent extends Event {

    public static const DELETE_CHARACTER_EVENT:String = "DELETE_CHARACTER_EVENT";

    public var savedChar_:SavedCharacter;

    public function DeleteCharacterEvent(_arg_1:SavedCharacter) {
        super(DELETE_CHARACTER_EVENT);
        this.savedChar_ = _arg_1;
    }

}
}//package com.company.assembleegameclient.screens.events
