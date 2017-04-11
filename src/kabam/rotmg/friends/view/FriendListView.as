package kabam.rotmg.friends.view {
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.dialogs.DialogCloser;
import com.company.ui.BaseSimpleText;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.friends.model.FriendConstant;
import kabam.rotmg.friends.model.FriendVO;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class FriendListView extends Sprite implements DialogCloser {

    public static const TEXT_WIDTH:int = 500;
    public static const TEXT_HEIGHT:int = 500;
    public static const LIST_ITEM_WIDTH:int = 474; //490
    public static const LIST_ITEM_HEIGHT:int = 40;
    private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(TEXT_WIDTH);
    public var closeDialogSignal:Signal;
    public var actionSignal:Signal;
    public var tabSignal:Signal;
    public var _tabView:FriendTabView;
    public var _w:int;
    public var _h:int;
    private var _friendTotalText:TextFieldDisplayConcrete;
    private var _friendDefaultText:TextFieldDisplayConcrete;
    private var _inviteDefaultText:TextFieldDisplayConcrete;
    private var _addButton:DeprecatedTextButton;
    private var _findButton:DeprecatedTextButton;
    private var _nameInput:TextInputField;
    private var _friendsContainer:FriendListContainer;
    private var _invitationsContainer:FriendListContainer;
    private var _currentServerName:String;
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0x333333, 1);
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];

    public function FriendListView() {
        this.closeDialogSignal = new Signal();
        this.actionSignal = new Signal(String, String);
        this.tabSignal = new Signal(String);
        super();
    }

    public function init(_arg_1:Vector.<FriendVO>, _arg_2:Vector.<FriendVO>, _arg_3:String):void {
        this._w = TEXT_WIDTH;
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this._tabView = new FriendTabView(TEXT_WIDTH, TEXT_HEIGHT);
        this._tabView.tabSelected.add(this.onTabClicked);
        addChild(this._tabView);
        this.createFriendTab();
        this.createInvitationsTab();
		closeButton.y = -2;
        addChild(this.closeButton);
        this.drawBackground();
        this._currentServerName = _arg_3;
        this.seedData(_arg_1, _arg_2);
        this._tabView.setSelectedTab(0);
    }

    public function destroy():void {
        while (numChildren > 0) {
            this.removeChildAt((numChildren - 1));
        }
        this._addButton.removeEventListener(MouseEvent.CLICK, this.onAddFriendClicked);
        this._addButton = null;
        this._tabView.destroy();
        this._tabView = null;
        this._nameInput.removeEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
        this._nameInput = null;
        this._friendsContainer = null;
        this._invitationsContainer = null;
    }

    public function updateFriendTab(_arg_1:Vector.<FriendVO>, _arg_2:String):void {
        var _local_3:FriendVO;
        var _local_4:FListItem;
        var _local_5:int;
        this._friendDefaultText.visible = (_arg_1.length <= 0);
        _local_5 = (this._friendsContainer.getTotal() - _arg_1.length);
        while (_local_5 > 0) {
            this._friendsContainer.removeChildAt((this._friendsContainer.getTotal() - 1));
            _local_5--;
        }
        _local_5 = 0;
        while (_local_5 < this._friendsContainer.getTotal()) {
            _local_3 = _arg_1.pop();
            if (_local_3 != null) {
                _local_4 = (this._friendsContainer.getChildAt(_local_5) as FListItem);
                _local_4.update(_local_3, _arg_2);
            }
            _local_5++;
        }
        for each (_local_3 in _arg_1) {
            _local_4 = new FriendListItem(_local_3, LIST_ITEM_WIDTH, LIST_ITEM_HEIGHT, _arg_2);
            _local_4.actionSignal.add(this.onListItemAction);
            _local_4.x = 2;
            this._friendsContainer.addListItem(_local_4);
        }
        _arg_1.length = 0;
        _arg_1 = null;
    }

    public function updateInvitationTab(_arg_1:Vector.<FriendVO>):void {
        var _local_2:FriendVO;
        var _local_3:FListItem;
        var _local_4:int;
        this._tabView.showTabBadget(1, _arg_1.length);
        this._inviteDefaultText.visible = (_arg_1.length == 0);
        _local_4 = (this._invitationsContainer.getTotal() - _arg_1.length);
        while (_local_4 > 0) {
            this._invitationsContainer.removeChildAt((this._invitationsContainer.getTotal() - 1));
            _local_4--;
        }
        _local_4 = 0;
        while (_local_4 < this._invitationsContainer.getTotal()) {
            _local_2 = _arg_1.pop();
            if (_local_2 != null) {
                _local_3 = (this._invitationsContainer.getChildAt(_local_4) as FListItem);
                _local_3.update(_local_2, "");
            }
            _local_4++;
        }
        for each (_local_2 in _arg_1) {
            _local_3 = new InvitationListItem(_local_2, LIST_ITEM_WIDTH, LIST_ITEM_HEIGHT);
            _local_3.actionSignal.add(this.onListItemAction);
            this._invitationsContainer.addListItem(_local_3);
        }
        _arg_1.length = 0;
        _arg_1 = null;
    }

    private function createFriendTab():void {
        var _local_1:Sprite = new Sprite();
        _local_1.name = "Friends";
		
        this._nameInput = new TextInputField(TextKey.FRIEND_ADD_TITLE, false);
        this._nameInput.x = 3;
        this._nameInput.y = 0;
        this._nameInput.addEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
        _local_1.addChild(this._nameInput);
		
        this._addButton = new DeprecatedTextButton(14, TextKey.FRIEND_ADD_BUTTON, 110);
        this._addButton.y = 30;
        this._addButton.x = 253;
        this._addButton.addEventListener(MouseEvent.CLICK, this.onAddFriendClicked);
        _local_1.addChild(this._addButton);
		
        this._findButton = new DeprecatedTextButton(14, "Search", 110);
        this._findButton.y = 30;
        this._findButton.x = 380;
        this._findButton.addEventListener(MouseEvent.CLICK, this.onSearchFriendClicked);
        _local_1.addChild(this._findButton);
		
        this._friendDefaultText = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this._friendDefaultText.setStringBuilder(new LineBuilder().setParams(TextKey.FRIEND_DEFAULT_TEXT));
        this._friendDefaultText.x = 250;
        this._friendDefaultText.y = 200;
        _local_1.addChild(this._friendDefaultText);
		
        this._friendTotalText = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this._friendTotalText.x = 400;
        this._friendTotalText.y = 0;
        _local_1.addChild(this._friendTotalText);
		
        this._friendsContainer = new FriendListContainer(TEXT_WIDTH, (TEXT_HEIGHT - 110));
        this._friendsContainer.x = 3;
        this._friendsContainer.y = 80;
        _local_1.addChild(this._friendsContainer);
		
        var _local_2:BaseSimpleText = new BaseSimpleText(18, 0xFFFFFF, false, 100, 26);
        _local_2.setAlignment(TextFormatAlign.CENTER);
        _local_2.text = FriendConstant.FRIEND_TAB;
        this._tabView.addTab(_local_2, _local_1);
    }

    private function createInvitationsTab():void {
        var _local_1:Sprite;
        _local_1 = new Sprite();
        _local_1.name = "Invitations";
		
        this._invitationsContainer = new FriendListContainer(TEXT_WIDTH, (TEXT_HEIGHT - 30));
        this._invitationsContainer.x = 3;
        _local_1.addChild(this._invitationsContainer);
		
        this._inviteDefaultText = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this._inviteDefaultText.setStringBuilder(new LineBuilder().setParams(TextKey.FRIEND_INVITATION_DEFAULT_TEXT));
        this._inviteDefaultText.x = 250;
        this._inviteDefaultText.y = 200;
        _local_1.addChild(this._inviteDefaultText);
		
        var _local_2:BaseSimpleText = new BaseSimpleText(18, 0xFFFFFF, false, 100, 26);
        _local_2.text = "Invites";
        _local_2.setAlignment(TextFormatAlign.CENTER);
        this._tabView.addTab(_local_2, _local_1);
    }

    private function seedData(_arg_1:Vector.<FriendVO>, _arg_2:Vector.<FriendVO>):void {
        this._friendTotalText.setStringBuilder(new LineBuilder().setParams(TextKey.FRIEND_TOTAL, {"total": _arg_1.length}));
        this.updateFriendTab(_arg_1, this._currentServerName);
        this.updateInvitationTab(_arg_2);
    }

    private function onTabClicked(_arg_1:String):void {
        this.tabSignal.dispatch(_arg_1);
    }

    public function getCloseSignal():Signal {
        return (this.closeDialogSignal);
    }

    public function updateInput(_arg_1:String, _arg_2:Object = null):void {
        this._nameInput.setError(_arg_1, _arg_2);
    }

    private function onFocusIn(_arg_1:FocusEvent):void {
        this._nameInput.clearText();
        this._nameInput.clearError();
        this.actionSignal.dispatch(FriendConstant.SEARCH, this._nameInput.text());
    }

    private function onAddFriendClicked(_arg_1:MouseEvent):void {
        this.actionSignal.dispatch(FriendConstant.INVITE, this._nameInput.text());
    }

    private function onSearchFriendClicked(_arg_1:MouseEvent):void {
        this.actionSignal.dispatch(FriendConstant.SEARCH, this._nameInput.text());
    }

    private function onListItemAction(_arg_1:String, _arg_2:String):void {
        this.actionSignal.dispatch(_arg_1, _arg_2);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.destroy();
    }

    private function drawBackground():void {
        this._h = (TEXT_HEIGHT + 8);
        x = (400 - (this._w / 2));
        y = (300 - (this._h / 2));
        graphics.clear();
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, (this._w + 12), (this._h + 12), 4, [1, 1, 1, 1], this.path_);
        graphics.drawGraphicsData(this.graphicsData_);
    }


}
}//package kabam.rotmg.friends.view
