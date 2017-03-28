package com.company.util {
public class MoreObjectUtil {


    public static function addToObject(_arg_1:Object, _arg_2:Object):void {
        var _local_3:String;
        for (_local_3 in _arg_2) {
            _arg_1[_local_3] = _arg_2[_local_3];
        }
    }


}
}//package com.company.util
