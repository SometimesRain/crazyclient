package kabam.rotmg.game.view {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;
import kabam.rotmg.ui.UIUtils;

public class GiftStatusDisplay extends Sprite implements TooltipAble {

    public static const IMAGE_NAME:String = "lofiObj2";
    public static const IMAGE_ID:int = 127;
    public static const NOTIFICATION_BACKGROUND_WIDTH:Number = 110;
    public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;
    public static const NOTIFICATION_BACKGROUND_ALPHA:Number = 0.4;
    public static const NOTIFICATION_BACKGROUND_COLOR:Number = 0;

    public var hoverTooltipDelegate:HoverTooltipDelegate;
    private var bitmap:Bitmap;
    private var background:Sprite;
    private var giftOpenProcessedTexture:BitmapData;
    private var text:TextFieldDisplayConcrete;
    private var tooltip:TextToolTip;

    public function GiftStatusDisplay() {
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        this.tooltip = new TextToolTip(0x363636, 0x9B9B9B, null, TextKey.BUYPACKAGETASK_NEWGIFTS, 200);
        super();
        mouseChildren = false;
        this.giftOpenProcessedTexture = TextureRedrawer.redraw(AssetLibrary.getImageFromSet(IMAGE_NAME, IMAGE_ID), 40, true, 0);
        this.background = UIUtils.makeStaticHUDBackground();
        this.bitmap = new Bitmap(this.giftOpenProcessedTexture);
        this.bitmap.x = -5;
        this.bitmap.y = -8;
        this.text = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF);
        this.text.setStringBuilder(new LineBuilder().setParams(TextKey.GIFTSTATUSDISPLAY_TEXT));
        this.text.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        this.text.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
        this.hoverTooltipDelegate.setDisplayObject(this);
        this.hoverTooltipDelegate.tooltip = this.tooltip;
        this.drawAsOpen();
        var _local_1:Rectangle = this.bitmap.getBounds(this);
        var _local_2:int = 10;
        this.text.x = (_local_1.right - _local_2);
        this.text.y = (_local_1.bottom - _local_2);
    }

    public function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void {
        this.hoverTooltipDelegate.setShowToolTipSignal(_arg_1);
    }

    public function getShowToolTip():ShowTooltipSignal {
        return (this.hoverTooltipDelegate.getShowToolTip());
    }

    public function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void {
        this.hoverTooltipDelegate.setHideToolTipsSignal(_arg_1);
    }

    public function getHideToolTips():HideTooltipsSignal {
        return (this.hoverTooltipDelegate.getHideToolTips());
    }

    public function drawAsOpen():void {
        addChild(this.background);
        addChild(this.text);
        addChild(this.bitmap);
    }

    public function drawAsClosed():void {
        if (((this.background) && ((this.background.parent == this)))) {
            removeChild(this.background);
        }
        if (((this.text) && ((this.text.parent == this)))) {
            removeChild(this.text);
        }
        if (((this.bitmap) && ((this.bitmap.parent == this)))) {
            removeChild(this.bitmap);
        }
    }


}
}//package kabam.rotmg.game.view
