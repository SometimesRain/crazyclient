package kabam.lib.json {
import com.adobe.serialization.json.JSON;

public class SoftwareJsonParser implements JsonParser {


    public function stringify(_arg_1:Object):String {
        return com.adobe.serialization.json.JSON.encode(_arg_1);
    }

    public function parse(_arg_1:String):Object {
        return com.adobe.serialization.json.JSON.decode(_arg_1);
    }


}
}//package kabam.lib.json
