package kabam.rotmg.pets.view.components {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.pets.view.dialogs.CaretakerQueryDialog;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

import org.osflash.signals.Signal;

public class CaretakerQueryDialogCategoryItem extends Sprite {

    private static const WIDTH:int = (CaretakerQueryDialog.WIDTH - 40);//234
    private static const HEIGHT:int = 40;
    private static const BEVEL:int = 2;
    private static const OUT:uint = 0x5C5C5C;
    private static const OVER:uint = 0x7F7F7F;

    private const helper:GraphicsHelper = new GraphicsHelper();
    private const rect:BevelRect = new BevelRect(WIDTH, HEIGHT, BEVEL);
    private const background:Shape = makeBackground();
    private const textfield:TextFieldDisplayConcrete = makeTextfield();
    public const textChanged:Signal = textfield.textChanged;

    public var info:String;

    public function CaretakerQueryDialogCategoryItem(_arg_1:String, _arg_2:String) {
        this.info = _arg_2;
        this.textfield.setStringBuilder(new LineBuilder().setParams(_arg_1));
        this.makeInteractive();
    }

    private function makeBackground():Shape {
        var _local_1:Shape = new Shape();
        this.drawBackground(_local_1, OUT);
        addChild(_local_1);
        return (_local_1);
    }

    private function drawBackground(_arg_1:Shape, _arg_2:uint):void {
        _arg_1.graphics.clear();
        _arg_1.graphics.beginFill(_arg_2);
        this.helper.drawBevelRect(0, 0, this.rect, _arg_1.graphics);
        _arg_1.graphics.endFill();
    }

    private function makeTextfield():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE).setPosition((WIDTH / 2), (HEIGHT / 2));
        _local_1.mouseEnabled = false;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeInteractive():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.drawBackground(this.background, OVER);
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.drawBackground(this.background, OUT);
    }


}
}//package kabam.rotmg.pets.view.components
