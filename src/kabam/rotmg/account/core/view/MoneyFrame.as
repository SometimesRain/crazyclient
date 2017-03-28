package kabam.rotmg.account.core.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.OfferRadioButtons;
import com.company.assembleegameclient.account.ui.PaymentMethodRadioButtons;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.util.PaymentMethod;
import com.company.assembleegameclient.util.offer.Offer;
import com.company.assembleegameclient.util.offer.Offers;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class MoneyFrame extends Sprite {

    private static const TITLE:String = TextKey.MONEY_FRAME_TITLE;//"MoneyFrame.title"
    private static const PAYMENT_SUBTITLE:String = TextKey.MONEY_FRAME_PAYMENT;//"MoneyFrame.payment"
    private static const GOLD_SUBTITLE:String = TextKey.MONEY_FRAME_GOLD;//"MoneyFrame.gold"
    private static const BUY_NOW:String = TextKey.MONEY_FRAME_BUY;//"MoneyFrame.buy"
    private static const WIDTH:int = 550;

    public var buyNow:Signal;
    public var cancel:Signal;
    private var offers:Offers;
    private var config:MoneyConfig;
    private var frame:Frame;
    private var paymentMethodButtons:PaymentMethodRadioButtons;
    private var offerButtons:OfferRadioButtons;
    public var buyNowButton:DeprecatedTextButton;
    public var cancelButton:DeprecatedClickableText;

    public function MoneyFrame() {
        this.buyNow = new Signal(Offer, String);
        this.cancel = new Signal();
    }

    public function initialize(_arg_1:Offers, _arg_2:MoneyConfig):void {
        this.offers = _arg_1;
        this.config = _arg_2;
        this.frame = new Frame(TITLE, "", "", WIDTH);
        ((_arg_2.showPaymentMethods()) && (this.addPaymentMethods()));
        this.addOffers();
        this.addBuyNowButton();
        addChild(this.frame);
        this.addCancelButton(TextKey.MONEY_FRAME_RIGHT_BUTTON);
        this.cancelButton.addEventListener(MouseEvent.CLICK, this.onCancel);
    }

    public function addPaymentMethods():void {
        this.makePaymentMethodRadioButtons();
        this.frame.addTitle(PAYMENT_SUBTITLE);
        this.frame.addRadioBox(this.paymentMethodButtons);
        this.frame.addSpace(14);
        this.addLine(0x7F7F7F, 536, 2, 10);
        this.frame.addSpace(6);
    }

    private function makePaymentMethodRadioButtons():void {
        var _local_1:Vector.<String> = this.makePaymentMethodLabels();
        this.paymentMethodButtons = new PaymentMethodRadioButtons(_local_1);
        this.paymentMethodButtons.setSelected(Parameters.data_.paymentMethod);
    }

    private function makePaymentMethodLabels():Vector.<String> {
        var _local_2:PaymentMethod;
        var _local_1:Vector.<String> = new Vector.<String>();
        for each (_local_2 in PaymentMethod.PAYMENT_METHODS) {
            _local_1.push(_local_2.label_);
        }
        return (_local_1);
    }

    private function addLine(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void {
        var _local_5:Shape = new Shape();
        _local_5.graphics.beginFill(_arg_1);
        _local_5.graphics.drawRect(_arg_4, 0, (_arg_2 - (_arg_4 * 2)), _arg_3);
        _local_5.graphics.endFill();
        this.frame.addComponent(_local_5, 0);
    }

    private function addOffers():void {
        this.offerButtons = new OfferRadioButtons(this.offers, this.config);
        this.offerButtons.showBonuses(this.config.showBonuses());
        this.frame.addTitle(GOLD_SUBTITLE);
        this.frame.addComponent(this.offerButtons);
    }

    public function addBuyNowButton():void {
        this.buyNowButton = new DeprecatedTextButton(16, BUY_NOW);
        this.buyNowButton.addEventListener(MouseEvent.CLICK, this.onBuyNowClick);
        this.buyNowButton.x = 8;
        this.buyNowButton.y = (this.frame.h_ - 52);
        this.frame.addChild(this.buyNowButton);
    }

    public function addCancelButton(_arg_1:String):void {
        this.cancelButton = new DeprecatedClickableText(18, true, _arg_1);
        if (_arg_1 != "") {
            this.cancelButton.buttonMode = true;
            this.cancelButton.x = ((((800 / 2) + (this.frame.w_ / 2)) - this.cancelButton.width) - 26);
            this.cancelButton.y = (((600 / 2) + (this.frame.h_ / 2)) - 52);
            this.cancelButton.setAutoSize(TextFieldAutoSize.RIGHT);
            addChild(this.cancelButton);
        }
    }

    protected function onBuyNowClick(_arg_1:MouseEvent):void {
        this.disable();
        var _local_2:Offer = this.offerButtons.getChoice().offer;
        var _local_3:String = ((this.paymentMethodButtons) ? this.paymentMethodButtons.getSelected() : null);
        this.buyNow.dispatch(_local_2, ((_local_3) || ("")));
    }

    public function disable():void {
        this.frame.disable();
        this.cancelButton.setDefaultColor(0xB3B3B3);
        this.cancelButton.mouseEnabled = false;
        this.cancelButton.mouseChildren = false;
    }

    public function enableOnlyCancel():void {
        this.cancelButton.removeOnHoverEvents();
        this.cancelButton.mouseEnabled = true;
        this.cancelButton.mouseChildren = true;
    }

    protected function onCancel(_arg_1:MouseEvent):void {
        stage.focus = stage;
        this.cancel.dispatch();
    }


}
}//package kabam.rotmg.account.core.view
