package kabam.rotmg.ui.view {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.dialogs.Dialog;

import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.ui.components.DateField;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class AgeVerificationDialog extends Dialog {

    private static const WIDTH:int = 300;

    private const BIRTH_DATE_BELOW_MINIMUM_ERROR:String = "AgeVerificationDialog.tooYoung";
    private const BIRTH_DATE_INVALID_ERROR:String = "AgeVerificationDialog.invalidBirthDate";
    private const MINIMUM_AGE:uint = 13;
    public const response:Signal = new Signal(Boolean);

    private var ageVerificationField:DateField;
    private var errorLabel:TextFieldDisplayConcrete;

    public function AgeVerificationDialog() {
        super(TextKey.AGE_VERIFICATION_DIALOG_TITLE, "", TextKey.AGE_VERIFICATION_DIALOG_LEFT, TextKey.AGE_VERIFICATION_DIALOG_RIGHT, "/ageVerificationDialog");
        addEventListener(Dialog.LEFT_BUTTON, this.onCancel);
        addEventListener(Dialog.RIGHT_BUTTON, this.onVerify);
    }

    override protected function makeUIAndAdd():void {
        this.makeAgeVerificationAndErrorLabel();
        this.addChildren();
    }

    private function makeAgeVerificationAndErrorLabel():void {
        this.makeAgeVerificationField();
        this.makeErrorLabel();
    }

    private function addChildren():void {
        uiWaiter.pushArgs(this.ageVerificationField.getTextChanged());
        box_.addChild(this.ageVerificationField);
        box_.addChild(this.errorLabel);
    }

    override protected function initText(_arg_1:String):void {
        textText_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3);
        textText_.setTextWidth((WIDTH - 40));
        textText_.x = 20;
        textText_.setMultiLine(true).setWordWrap(true).setHTML(true);
        textText_.setAutoSize(TextFieldAutoSize.LEFT);
        textText_.mouseEnabled = true;
        textText_.filters = [new DropShadowFilter(0, 0, 0, 1, 6, 6, 1)];
        this.setText();
    }

    private function setText():void {
        var _local_1:String = (('<font color="#7777EE"><a href="' + Parameters.TERMS_OF_USE_URL) + '" target="_blank">');
        var _local_2:String = (('<font color="#7777EE"><a href="' + Parameters.PRIVACY_POLICY_URL) + '" target="_blank">');
        var _local_3:String = "</a></font>";
        textText_.setStringBuilder(new LineBuilder().setParams("AgeVerificationDialog.text", {
            "tou": _local_1,
            "_tou": _local_3,
            "policy": _local_2,
            "_policy": _local_3
        }));
    }

    override protected function drawAdditionalUI():void {
        this.ageVerificationField.y = (textText_.getBounds(box_).bottom + 8);
        this.ageVerificationField.x = 20;
        this.errorLabel.y = ((this.ageVerificationField.y + this.ageVerificationField.height) + 8);
        this.errorLabel.x = 20;
    }

    private function makeAgeVerificationField():void {
        this.ageVerificationField = new DateField();
        this.ageVerificationField.setTitle(TextKey.BIRTHDAY);
    }

    private function makeErrorLabel():void {
        this.errorLabel = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
        this.errorLabel.setMultiLine(true);
        this.errorLabel.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
    }

    private function onCancel(_arg_1:Event):void {
        this.response.dispatch(false);
    }

    private function onVerify(_arg_1:Event):void {
        var _local_3:Boolean;
        var _local_2:uint = this.getPlayerAge();
        var _local_4:String = "";
        if (!this.ageVerificationField.isValidDate()) {
            _local_4 = this.BIRTH_DATE_INVALID_ERROR;
            _local_3 = true;
        }
        else {
            if ((((_local_2 < this.MINIMUM_AGE)) && (!(_local_3)))) {
                _local_4 = this.BIRTH_DATE_BELOW_MINIMUM_ERROR;
                _local_3 = true;
            }
            else {
                _local_4 = "";
                _local_3 = false;
                this.response.dispatch(true);
            }
        }
        this.errorLabel.setStringBuilder(new LineBuilder().setParams(_local_4));
        this.ageVerificationField.setErrorHighlight(_local_3);
        drawButtonsAndBackground();
    }

    private function getPlayerAge():uint {
        var _local_1:Date = new Date(this.getBirthDate());
        var _local_2:Date = new Date();
        var _local_3:uint = (Number(_local_2.fullYear) - Number(_local_1.fullYear));
        if ((((_local_1.month > _local_2.month)) || ((((_local_1.month == _local_2.month)) && ((_local_1.date > _local_2.date)))))) {
            _local_3--;
        }
        return (_local_3);
    }

    private function getBirthDate():Number {
        return (Date.parse(this.ageVerificationField.getDate()));
    }


}
}//package kabam.rotmg.ui.view
