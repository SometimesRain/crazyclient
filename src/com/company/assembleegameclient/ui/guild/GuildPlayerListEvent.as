package com.company.assembleegameclient.ui.guild {
import flash.events.Event;

public class GuildPlayerListEvent extends Event {

    public static const SET_RANK:String = "SET_RANK";
    public static const REMOVE_MEMBER:String = "REMOVE_MEMBER";

    public var name_:String;
    public var rank_:int;

    public function GuildPlayerListEvent(_arg_1:String, _arg_2:String, _arg_3:int = -1) {
        super(_arg_1, true);
        this.name_ = _arg_2;
        this.rank_ = _arg_3;
    }

}
}//package com.company.assembleegameclient.ui.guild
