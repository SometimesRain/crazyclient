package com.company.assembleegameclient.mapeditor {
import flash.events.Event;

public class SubmitJMEvent extends Event {

    public static const SUBMIT_JM_EVENT:String = "SUBMIT_JM_EVENT";

    public var mapJSON_:String;
    public var mapInfo_:Object;

    public function SubmitJMEvent(param1:String, param2:Object)
    {
        super(SUBMIT_JM_EVENT);
        this.mapJSON_ = param1;
        this.mapInfo_ = param2;
    }

}
}
