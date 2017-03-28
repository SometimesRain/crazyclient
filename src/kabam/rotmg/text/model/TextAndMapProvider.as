package kabam.rotmg.text.model {
import flash.text.TextField;

import kabam.rotmg.language.model.StringMap;

public interface TextAndMapProvider {

    function getTextField():TextField;

    function getStringMap():StringMap;

}
}//package kabam.rotmg.text.model
