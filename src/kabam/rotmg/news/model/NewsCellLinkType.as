package kabam.rotmg.news.model {
public class NewsCellLinkType {

    public static const OPENS_LINK:NewsCellLinkType = new (NewsCellLinkType)(1);
    public static const OPENS_PACKAGE:NewsCellLinkType = new (NewsCellLinkType)(2);
    public static const OPENS_SKIN:NewsCellLinkType = new (NewsCellLinkType)(3);
    private static const types:Object = {
        "1": OPENS_LINK,
        "2": OPENS_PACKAGE,
        "3": OPENS_SKIN
    };

    private var index:int;

    public function NewsCellLinkType(_arg_1:int) {
        this.index = _arg_1;
    }

    public static function parse(_arg_1:int):NewsCellLinkType {
        return (types[_arg_1]);
    }


    public function getIndex():int {
        return (this.index);
    }


}
}//package kabam.rotmg.news.model
