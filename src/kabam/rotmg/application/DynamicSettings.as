package kabam.rotmg.application {
public class DynamicSettings {

    private static var _xml:XML;


    public static function get xml():XML {
        return (_xml);
    }

    public static function set xml(_arg_1:XML):void {
        _xml = _arg_1;
    }

    public static function settingExists(_arg_1:String):Boolean {
        return (((!((_xml == null))) && (_xml.hasOwnProperty(_arg_1))));
    }

    public static function getSettingValue(_arg_1:String):Number {
        return (Number(_xml.child(_arg_1).toString()));
    }


}
}//package kabam.rotmg.application
