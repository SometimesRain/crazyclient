package kabam.lib.json {
import com.hurlant.util.Base64;

public class Base64Decoder {


    public function decode(_arg_1:String):String {
        var _local_2:RegExp = /-/g;
        var _local_3:RegExp = /_/g;
        var _local_4:int = (4 - (_arg_1.length % 4));
        while (_local_4--) {
            _arg_1 = (_arg_1 + "=");
        }
        _arg_1 = _arg_1.replace(_local_2, "+").replace(_local_3, "/");
        return (Base64.decode(_arg_1));
    }


}
}//package kabam.lib.json
