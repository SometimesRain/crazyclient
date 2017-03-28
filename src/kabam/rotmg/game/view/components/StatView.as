package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.natives.NativeSignal;

public class StatView extends Sprite {

    public var fullName_:String;
    public var description_:String;
    public var nameText_:TextFieldDisplayConcrete;
    public var valText_:TextFieldDisplayConcrete;
    public var redOnZero_:Boolean;
    public var val_:int = -1;
    public var boost_:int = -1;
    public var valColor_:uint = 0xB3B3B3;
    public var toolTip_:TextToolTip;
    public var mouseOver:NativeSignal;
    public var mouseOut:NativeSignal;

    public function StatView(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Boolean) {
        this.toolTip_ = new TextToolTip(0x363636, 0x9B9B9B, "", "", 200);
        super();
        this.fullName_ = _arg_2;
        this.description_ = _arg_3;
        this.nameText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.nameText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
        this.configureTextAndAdd(this.nameText_);
        this.valText_ = new TextFieldDisplayConcrete().setSize(13).setColor(this.valColor_).setBold(true);
        this.valText_.setStringBuilder(new StaticStringBuilder("-"));
        this.configureTextAndAdd(this.valText_);
        this.redOnZero_ = _arg_4;
        this.mouseOver = new NativeSignal(this, MouseEvent.MOUSE_OVER, MouseEvent);
        this.mouseOut = new NativeSignal(this, MouseEvent.MOUSE_OUT, MouseEvent);
    }

    public function configureTextAndAdd(_arg_1:TextFieldDisplayConcrete):void {
        _arg_1.setAutoSize(TextFieldAutoSize.LEFT);
        _arg_1.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(_arg_1);
    }

    public function addTooltip():void {
        this.toolTip_.setTitle(new LineBuilder().setParams(this.fullName_));
        this.toolTip_.setText(new LineBuilder().setParams(this.description_));
        if (!stage.contains(this.toolTip_)) {
            stage.addChild(this.toolTip_);
        }
    }

    public function removeTooltip():void {
        if (this.toolTip_.parent != null) {
            this.toolTip_.parent.removeChild(this.toolTip_);
        }
    }

    public function draw(_arg_1:int, _arg_2:int, _arg_3:int):void {
        var _local_4:uint;
        if ((((_arg_1 == this.val_)) && ((_arg_2 == this.boost_)))) {
            return;
        }
        this.val_ = _arg_1;
        this.boost_ = _arg_2;
		/*if (l2m && _arg_3 - _arg_1 != 0) {
            _local_4 = 0xB3B3B3; //gray; normal
		}
        else */
		if ((_arg_1 - _arg_2) >= _arg_3) {
            _local_4 = 0xFCDF00; //yellow; maxed
        }
        else {
            if (((((this.redOnZero_) && ((this.val_ <= 0)))) || ((this.boost_ < 0)))) {
                _local_4 = 16726072; //red; zero
            }
            else {
                if (this.boost_ > 0) {
                    _local_4 = 6206769; //green; item bonuses
                }
                else {
                    _local_4 = 0xB3B3B3; //gray; normal
                }
            }
        }
        if (this.valColor_ != _local_4) {
            this.valColor_ = _local_4;
            this.valText_.setColor(this.valColor_);
        }
        var _local_5:String = this.val_.toString();
        if (this.boost_ != 0) {
            _local_5 = (_local_5 + (((" (" + (((this.boost_ > 0)) ? "+" : "")) + this.boost_.toString()) + ")"));
        }
        this.valText_.setStringBuilder(new StaticStringBuilder(_local_5));
        this.valText_.x = this.nameText_.getBounds(this).right;
    }


}
}//package kabam.rotmg.game.view.components
