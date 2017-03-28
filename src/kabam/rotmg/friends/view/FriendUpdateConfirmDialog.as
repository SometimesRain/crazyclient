package kabam.rotmg.friends.view {
import com.company.assembleegameclient.ui.dialogs.CloseDialogComponent;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.dialogs.DialogCloser;

import flash.events.Event;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.friends.controller.FriendActionSignal;
import kabam.rotmg.friends.model.FriendRequestVO;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class FriendUpdateConfirmDialog extends Dialog implements DialogCloser {

    private const closeDialogComponent:CloseDialogComponent = new CloseDialogComponent();

    private var _friendRequestVO:FriendRequestVO;

    public function FriendUpdateConfirmDialog(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:FriendRequestVO, _arg_6:Object = null) {
        super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_6);
        this._friendRequestVO = _arg_5;
        this.closeDialogComponent.add(this, Dialog.RIGHT_BUTTON);
        this.closeDialogComponent.add(this, Dialog.LEFT_BUTTON);
        addEventListener(Dialog.RIGHT_BUTTON, this.onRightButton);
    }

    private function onRightButton(_arg_1:Event):void {
        removeEventListener(Dialog.RIGHT_BUTTON, this.onRightButton);
        var _local_2:Injector = StaticInjectorContext.getInjector();
        var _local_3:FriendActionSignal = _local_2.getInstance(FriendActionSignal);
        _local_3.dispatch(this._friendRequestVO);
    }

    public function getCloseSignal():Signal {
        return (this.closeDialogComponent.getCloseSignal());
    }


}
}//package kabam.rotmg.friends.view
