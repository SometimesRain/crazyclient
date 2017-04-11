package kabam.rotmg.ui.view {
import com.company.assembleegameclient.objects.ImageFactory;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.BoostPanelButton;
import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
import com.company.assembleegameclient.ui.icons.IconButton;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

public class CharacterDetailsView extends Sprite {

    private var portrait_:Bitmap;
    private var button:IconButton;
    private var nameText_:TextFieldDisplayConcrete;

    public function CharacterDetailsView() {
        this.portrait_ = new Bitmap(null);
        this.nameText_ = new TextFieldDisplayConcrete().setSize(20).setColor(0xB3B3B3);
        super();
    }

    public function init(_arg_1:String, _arg_2:String):void {
        this.createPortrait();
        this.createNameText(_arg_1);
    }

    private function createPortrait():void {
        this.portrait_.x = -2;
        this.portrait_.y = -8;
        addChild(this.portrait_);
    }

    private function createNameText(_arg_1:String):void {
        this.nameText_.setBold(true);
        this.nameText_.x = 36;
        this.nameText_.y = 3;
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.setName(_arg_1);
        addChild(this.nameText_);
    }

    public function update(_arg_1:Player):void {
        this.portrait_.bitmapData = _arg_1.getPortrait();
    }

    public function setName(_arg_1:String):void {
		var fakename:String = Parameters.data_.fakeName;
		if (fakename != null) {
			_arg_1 = fakename;
		}
		this.nameText_.setStringBuilder(new StaticStringBuilder(_arg_1));
    }


}
}//package kabam.rotmg.ui.view
