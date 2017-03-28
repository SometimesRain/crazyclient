package kabam.rotmg.characters.reskin.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class ReskinPanel extends Panel {

    private const title:TextFieldDisplayConcrete = makeTitle();
    private const button:DeprecatedTextButton = makeButton();
    private const click:Signal = new NativeMappedSignal(button, MouseEvent.CLICK);
    public const reskin:Signal = new Signal();

    public function ReskinPanel(_arg_1:GameSprite = null) {
        super(_arg_1);
        this.click.add(this.onClick);
    }

    private function onClick():void {
        this.reskin.dispatch();
    }

    private function makeTitle():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete;
        _local_1 = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setAutoSize(TextFieldAutoSize.CENTER);
        _local_1.x = (WIDTH / 2);
        _local_1.setBold(true);
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.RESKINPANEL_CHANGESKIN));
        addChild(_local_1);
        return (_local_1);
    }

    private function makeButton():DeprecatedTextButton {
        var _local_1:DeprecatedTextButton = new DeprecatedTextButton(16, TextKey.RESKINPANEL_CHOOSE);
        _local_1.textChanged.addOnce(this.onTextSet);
        addChild(_local_1);
        return (_local_1);
    }

    private function onTextSet():void {
        this.button.x = ((WIDTH / 2) - (this.button.width / 2));
        this.button.y = ((HEIGHT - this.button.height) - 4);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if ((((_arg_1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) {
            this.reskin.dispatch();
        }
    }


}
}//package kabam.rotmg.characters.reskin.view
