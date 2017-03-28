package kabam.rotmg.util.components {
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

import org.osflash.signals.Signal;

public final class VerticalScrollbarGroove extends Sprite {

    public static const WIDTH:int = VerticalScrollbar.WIDTH;//20
    public static const BEVEL:int = (VerticalScrollbar.BEVEL + (VerticalScrollbar.PADDING * 0.5));//4

    public const clicked:Signal = new Signal(int);
    public const rect:BevelRect = new BevelRect(WIDTH, 0, BEVEL);
    private const helper:GraphicsHelper = new GraphicsHelper();


    public function redraw():void {
        graphics.clear();
        graphics.beginFill(0x545454);
        this.helper.drawBevelRect(0, 0, this.rect, graphics);
        graphics.endFill();
    }

    public function addMouseListeners():void {
        addEventListener(MouseEvent.CLICK, this.onClick);
    }

    public function removeMouseListeners():void {
        removeEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(_arg_1:MouseEvent):void {
        this.clicked.dispatch(int(mouseY));
    }


}
}//package kabam.rotmg.util.components
