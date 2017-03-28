package kabam.rotmg.friends.view {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import kabam.rotmg.chat.control.ShowChatInputSignal;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.controller.FriendActionSignal;
import kabam.rotmg.friends.model.FriendConstant;
import kabam.rotmg.friends.model.FriendModel;
import kabam.rotmg.friends.model.FriendRequestVO;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.signals.EnterGameSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FriendListMediator extends Mediator {

    [Inject]
    public var view:FriendListView;
    [Inject]
    public var model:FriendModel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;
    [Inject]
    public var actionSignal:FriendActionSignal;
    [Inject]
    public var chatSignal:ShowChatInputSignal;
    [Inject]
    public var enterGame:EnterGameSignal;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var playGame:PlayGameSignal;


    override public function initialize():void {
        this.view.actionSignal.add(this.onFriendActed);
        this.view.tabSignal.add(this.onTabSwitched);
        this.model.dataSignal.add(this.initView);
        this.model.loadData();
    }

    override public function destroy():void {
        this.view.actionSignal.removeAll();
        this.view.tabSignal.removeAll();
    }

    private function initView(_arg_1:Boolean = false):void {
        if (_arg_1) {
            this.view.init(this.model.getAllFriends(), this.model.getAllInvitations(), this.model.getCurrentServerName());
        }
        else {
            this.reportError(this.model.errorStr);
        }
    }

    private function reportError(_arg_1:String):void {
        this.openDialog.dispatch(new ErrorDialog(_arg_1));
    }

    private function onTabSwitched(_arg_1:String):void {
        switch (_arg_1) {
            case FriendConstant.FRIEND_TAB:
                this.view.updateFriendTab(this.model.getAllFriends(), this.model.getCurrentServerName());
                return;
            case FriendConstant.INVITE_TAB:
                this.view.updateInvitationTab(this.model.getAllInvitations());
                return;
        }
    }

    private function onFriendActed(_arg_1:String, _arg_2:String):void {
        var _local_4:String;
        var _local_5:String;
        var _local_3:FriendRequestVO = new FriendRequestVO(_arg_1, _arg_2);
        switch (_arg_1) {
            case FriendConstant.SEARCH:
                if (((!((_arg_2 == null))) && (!((_arg_2 == ""))))) {
                    this.view.updateFriendTab(this.model.getFilterFriends(_arg_2), this.model.getCurrentServerName());
                }
                else {
                    if (_arg_2 == "") {
                        this.view.updateFriendTab(this.model.getAllFriends(), this.model.getCurrentServerName());
                    }
                }
                return;
            case FriendConstant.INVITE:
                if (this.model.ifReachMax()) {
                    this.view.updateInput(TextKey.FRIEND_REACH_CAPACITY);
                    return;
                }
                _local_3.callback = this.inviteFriendCallback;
                break;
            case FriendConstant.REMOVE:
                _local_3.callback = this.removeFriendCallback;
                _local_4 = TextKey.FRIEND_REMOVE_TITLE;
                _local_5 = TextKey.FRIEND_REMOVE_TEXT;
                this.openDialog.dispatch(new FriendUpdateConfirmDialog(_local_4, _local_5, TextKey.FRAME_CANCEL, TextKey.FRIEND_REMOVE_BUTTON, _local_3, {"name": _local_3.target}));
                return;
            case FriendConstant.ACCEPT:
                _local_3.callback = this.acceptInvitationCallback;
                break;
            case FriendConstant.REJECT:
                _local_3.callback = this.rejectInvitationCallback;
                break;
            case FriendConstant.BLOCK:
                _local_3.callback = this.blockInvitationCallback;
                _local_4 = TextKey.FRIEND_BLOCK_TITLE;
                _local_5 = TextKey.FRIEND_BLOCK_TEXT;
                this.openDialog.dispatch(new FriendUpdateConfirmDialog(_local_4, _local_5, TextKey.FRAME_CANCEL, TextKey.FRIEND_BLOCK_BUTTON, _local_3, {"name": _local_3.target}));
                return;
            case FriendConstant.WHISPER:
                this.whisperCallback(_arg_2);
                return;
            case FriendConstant.JUMP:
                this.jumpCallback(_arg_2);
                return;
        }
        this.actionSignal.dispatch(_local_3);
    }

    private function inviteFriendCallback(_arg_1:Boolean, _arg_2:String, _arg_3:String):void {
        if (_arg_1) {
            this.view.updateInput(TextKey.FRIEND_SENT_INVITATION_TEXT, {"name": _arg_3});
        }
        else {
            if (_arg_2 == "Blocked") {
                this.view.updateInput(TextKey.FRIEND_SENT_INVITATION_TEXT, {"name": _arg_3});
            }
            else {
                this.view.updateInput(_arg_2);
            }
        }
    }

    private function removeFriendCallback(_arg_1:Boolean, _arg_2:String, _arg_3:String):void {
        if (_arg_1) {
            this.model.removeFriend(_arg_3);
        }
        else {
            this.reportError(_arg_2);
        }
    }

    private function acceptInvitationCallback(_arg_1:Boolean, _arg_2:String, _arg_3:String):void {
        if (_arg_1) {
            this.model.seedFriends(XML(_arg_2));
            if (this.model.removeInvitation(_arg_3)) {
                this.view.updateInvitationTab(this.model.getAllInvitations());
            }
        }
        else {
            this.reportError(_arg_2);
        }
    }

    private function rejectInvitationCallback(_arg_1:Boolean, _arg_2:String, _arg_3:String):void {
        if (_arg_1) {
            if (this.model.removeInvitation(_arg_3)) {
                this.view.updateInvitationTab(this.model.getAllInvitations());
            }
        }
        else {
            this.reportError(_arg_2);
        }
    }

    private function blockInvitationCallback(_arg_1:String):void {
        this.model.removeInvitation(_arg_1);
    }

    private function whisperCallback(_arg_1:String):void {
        this.chatSignal.dispatch(true, (("/tell " + _arg_1) + " "));
        this.view.getCloseSignal().dispatch();
    }

    private function jumpCallback(_arg_1:String):void {
        Parameters.data_.preferredServer = _arg_1;
        Parameters.save();
        this.enterGame.dispatch();
        var _local_2:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
        var _local_3:GameInitData = new GameInitData();
        _local_3.createCharacter = false;
        _local_3.charId = _local_2.charId();
        _local_3.isNewGame = true;
        this.playGame.dispatch(_local_3);
        this.closeDialog.dispatch();
    }


}
}//package kabam.rotmg.friends.view
