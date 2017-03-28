package com.company.assembleegameclient.account.ui.components {
import flash.display.Shape;

public class BackgroundBox extends Shape {

    private var _width:int;
    private var _height:int;
    private var _color:int;


    public function setSize(_arg_1:int, _arg_2:int):void {
        this._width = _arg_1;
        this._height = _arg_2;
        this.drawFill();
    }

    public function setColor(_arg_1:int):void {
        this._color = _arg_1;
        this.drawFill();
    }

    private function drawFill():void {
        graphics.clear();
        graphics.beginFill(this._color);
        graphics.drawRect(0, 0, this._width, this._height);
        graphics.endFill();
    }


}
}//package com.company.assembleegameclient.account.ui.components
