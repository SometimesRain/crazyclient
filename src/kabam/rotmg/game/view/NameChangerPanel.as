package kabam.rotmg.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.util.Currency;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFormatAlign;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.Signal;

public class NameChangerPanel extends Panel {

    public var chooseName:Signal;
    public var buy_:Boolean;
    private var title_:TextFieldDisplayConcrete;
    private var button_:Sprite;

    public function NameChangerPanel(_arg_1:GameSprite, _arg_2:int) {
        var _local_3:Player;
        var _local_4:String;
        this.chooseName = new Signal();
        super(_arg_1);
        if (this.hasMapAndPlayer()) {
            _local_3 = gs_.map.player_;
            this.buy_ = _local_3.nameChosen_;
            _local_4 = this.createNameText();
            if (this.buy_) {
                this.handleAlreadyHasName(_local_4);
            }
            else {
                if (_local_3.numStars_ < _arg_2) {
                    this.handleInsufficientRank(_arg_2);
                }
                else {
                    this.handleNoName();
                }
            }
        }
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
    }

    private function onAddedToStage(_arg_1:Event):void {
        if (this.button_) {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function hasMapAndPlayer():Boolean {
        return (((gs_.map) && (gs_.map.player_)));
    }

    private function createNameText():String {
        var _local_1:String;
        _local_1 = gs_.model.getName();
        this.title_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setTextWidth(WIDTH);
        this.title_.setBold(true).setWordWrap(true).setMultiLine(true).setHorizontalAlign(TextFormatAlign.CENTER);
        this.title_.filters = [new DropShadowFilter(0, 0, 0)];
        return (_local_1);
    }

    private function handleAlreadyHasName(_arg_1:String):void {
        this.title_.setStringBuilder(this.makeNameText(_arg_1));
        this.title_.y = 0;
        addChild(this.title_);
        var _local_2:LegacyBuyButton = new LegacyBuyButton(TextKey.NAME_CHANGER_CHANGE, 16, Parameters.NAME_CHANGE_PRICE, Currency.GOLD);
        _local_2.readyForPlacement.addOnce(this.positionButton);
        this.button_ = _local_2;
        addChild(this.button_);
        this.addListeners();
    }

    private function positionButton():void {
        this.button_.x = ((WIDTH / 2) - (this.button_.width / 2));
        this.button_.y = ((HEIGHT - (this.button_.height / 2)) - 17);
    }

    private function handleNoName():void {
        this.title_.setStringBuilder(new LineBuilder().setParams(TextKey.NAME_CHANGER_TEXT));
        this.title_.y = 6;
        addChild(this.title_);
        var _local_1:DeprecatedTextButton = new DeprecatedTextButton(16, TextKey.NAME_CHANGER_CHOOSE);
        _local_1.textChanged.addOnce(this.positionTextButton);
        this.button_ = _local_1;
        addChild(this.button_);
        this.addListeners();
    }

    private function positionTextButton():void {
        this.button_.x = ((WIDTH / 2) - (this.button_.width / 2));
        this.button_.y = ((HEIGHT - this.button_.height) - 4);
    }

    private function addListeners():void {
        this.button_.addEventListener(MouseEvent.CLICK, this.onButtonClick);
    }

    private function handleInsufficientRank(_arg_1:int):void {
        var _local_2:Sprite;
        var _local_4:Sprite;
        this.title_.setStringBuilder(new LineBuilder().setParams(TextKey.NAME_CHANGER_TEXT));
        addChild(this.title_);
        _local_2 = new Sprite();
        var _local_3:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF);
        _local_3.setBold(true);
        _local_3.setStringBuilder(new LineBuilder().setParams(TextKey.NAME_CHANGER_REQUIRE_RANK));
        _local_3.filters = [new DropShadowFilter(0, 0, 0)];
        _local_2.addChild(_local_3);
        _local_4 = new RankText(_arg_1, false, false);
        _local_4.x = (_local_3.width + 4);
        _local_4.y = ((_local_3.height / 2) - (_local_4.height / 2));
        _local_2.addChild(_local_4);
        _local_2.x = ((WIDTH / 2) - (_local_2.width / 2));
        _local_2.y = ((HEIGHT - (_local_2.height / 2)) - 20);
        addChild(_local_2);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function makeNameText(_arg_1:String):StringBuilder {
        return (new LineBuilder().setParams(TextKey.NAME_CHANGER_NAME_IS, {"name": _arg_1}));
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if ((((_arg_1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) {
            this.performAction();
        }
    }

    private function onButtonClick(_arg_1:MouseEvent):void {
        this.performAction();
    }

    private function performAction():void {
        this.chooseName.dispatch();
    }

    public function updateName(_arg_1:String):void {
        this.title_.setStringBuilder(this.makeNameText(_arg_1));
        this.title_.y = 0;
    }


}
}//package kabam.rotmg.game.view
