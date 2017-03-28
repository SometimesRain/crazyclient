package com.company.assembleegameclient.screens {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.servers.api.Server;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import com.company.assembleegameclient.parameters.Parameters;

public class ServerBox extends Sprite {

    public static const WIDTH:int = 261; //253 384
    public static const HEIGHT:int = 47; //42 52

    public var value_:String;
    private var nameText_:TextFieldDisplayConcrete;
    private var statusText_:TextFieldDisplayConcrete;
    private var selected_:Boolean = false;
    private var over_:Boolean = false;

    public function ServerBox(_arg_1:Server) {
        this.value_ = (((_arg_1 == null)) ? null : _arg_1.name);
        this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true);
        if (_arg_1 == null) {
            this.nameText_.setStringBuilder(new LineBuilder().setParams("Best Server ("+Parameters.data_.bestServ+")"));
        }
        else {
            this.nameText_.setStringBuilder(new StaticStringBuilder(_arg_1.name));
        }
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.nameText_.x = 18;
        this.nameText_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.nameText_.y = (ServerBox.HEIGHT / 2);
        addChild(this.nameText_);
        this.addUI(_arg_1);
        this.draw();
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    private function addUI(server:Server):void { //server popul
        var onTextChanged:Function;
        var color:uint;
        var text:String;
        onTextChanged = function ():void {
            makeStatusText(color, text);
        };
        if (server != null && server.name != "Proxy") {
            color = 0xFF00;
            text = "ServerBox.normal";
            if (server.isFull()) {
                color = 0xFF0000;
                text = "ServerBox.full";
            }
            else {
                if (server.isCrowded()) {
                    color = 16549442;
                    text = "ServerBox.crowded";
                }
            }
            this.nameText_.textChanged.addOnce(onTextChanged);
        }
    }

    private function makeStatusText(_arg_1:uint, _arg_2:String):void {
        this.statusText_ = new TextFieldDisplayConcrete().setSize(18).setColor(_arg_1).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this.statusText_.setStringBuilder(new LineBuilder().setParams(_arg_2));
        this.statusText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.statusText_.x = ((WIDTH / 2) + (WIDTH / 4));
        this.statusText_.y = ((ServerBox.HEIGHT / 2) - (this.nameText_.height / 2));
        addChild(this.statusText_);
    }

    public function setSelected(_arg_1:Boolean):void {
        this.selected_ = _arg_1;
        this.draw();
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.over_ = true;
        this.draw();
    }

    private function onRollOut(_arg_1:MouseEvent):void {
        this.over_ = false;
        this.draw();
    }

    private function draw():void {
        graphics.clear();
        if (this.selected_) {
            graphics.lineStyle(2, 16777103);
        }
        graphics.beginFill(((this.over_) ? 0x6B6B6B : 0x5C5C5C), 1);
        graphics.drawRect(0, 0, WIDTH, HEIGHT);
        if (this.selected_) {
            graphics.lineStyle();
        }
    }


}
}//package com.company.assembleegameclient.screens
