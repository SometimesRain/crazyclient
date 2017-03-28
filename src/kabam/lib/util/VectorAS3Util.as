package kabam.lib.util {
public class VectorAS3Util {


    public static function toArray(_arg_1:Object):Array {
        var _local_3:Object;
        var _local_2:Array = [];
        for each (_local_3 in _arg_1) {
            _local_2.push(_local_3);
        }
        return (_local_2);
    }


}
}//package kabam.lib.util
