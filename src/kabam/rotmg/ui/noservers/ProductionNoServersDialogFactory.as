package kabam.rotmg.ui.noservers {
import com.company.assembleegameclient.ui.dialogs.Dialog;

import kabam.rotmg.text.model.TextKey;

public class ProductionNoServersDialogFactory implements NoServersDialogFactory {

    private static const forums_link:String = '<font color="#7777EE"><a href="http://forums.wildshadow.com/">forums.wildshadow.com</a></font>';


    public function makeDialog():Dialog {
        var _local_1:Dialog = new Dialog(TextKey.PRODUCTIONNOSERVERSDIALOGFACTORY_TILE, "", null, null);
        _local_1.textText_.setHTML(true);
        _local_1.setTextParams(TextKey.PRODUCTIONNOSERVERSDIALOGFACTORY_BODY, {"forums_link": forums_link});
        return (_local_1);
    }


}
}//package kabam.rotmg.ui.noservers
