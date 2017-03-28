package com.company.util {
import flash.external.ExternalInterface;
import flash.xml.XMLDocument;
import flash.xml.XMLNode;
import flash.xml.XMLNodeType;

public class HTMLUtil {


    public static function unescape(_arg_1:String):String {
        return (new XMLDocument(_arg_1).firstChild.nodeValue);
    }

    public static function escape(_arg_1:String):String {
        return (XML(new XMLNode(XMLNodeType.TEXT_NODE, _arg_1)).toXMLString());
    }

    public static function refreshPageNoParams():void {
        var _local_1:String;
        var _local_2:Array;
        var _local_3:String;
        if (ExternalInterface.available) {
            _local_1 = ExternalInterface.call("window.location.toString");
            _local_2 = _local_1.split("?");
            if (_local_2.length > 0) {
                _local_3 = _local_2[0];
                if (_local_3.indexOf("www.kabam") != -1) {
                    _local_3 = "http://www.realmofthemadgod.com";
                }
                ExternalInterface.call("window.location.assign", _local_3);
            }
        }
    }


}
}//package com.company.util
