package kabam.rotmg.language {
import flash.text.TextField;

import kabam.rotmg.language.model.DebugStringMap;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.TextAndMapProvider;
import kabam.rotmg.text.view.DebugTextField;

public class DebugTextAndMapProvider implements TextAndMapProvider {

    [Inject]
    public var debugStringMap:DebugStringMap;


    public function getTextField():TextField {
        var _local_1:DebugTextField = new DebugTextField();
        _local_1.debugStringMap = this.debugStringMap;
        return (_local_1);
    }

    public function getStringMap():StringMap {
        return (this.debugStringMap);
    }


}
}//package kabam.rotmg.language
