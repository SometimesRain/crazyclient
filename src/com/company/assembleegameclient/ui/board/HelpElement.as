package com.company.assembleegameclient.ui.board {
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class HelpElement extends Sprite {
	
	private var title:TextFieldDisplayConcrete;
	private var content:TextFieldDisplayConcrete;

    public function HelpElement(title_:String, content_:String, lines:int) {
		//graphics.beginFill(0x4D4D4D);
		graphics.beginFill(0x545454);
		graphics.drawRoundRect(0, 0, 670, 36 + lines * 12, 8, 8); //60
		graphics.endFill();
		
		title = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
		title.x = 5;
		title.y = 2;
        title.setStringBuilder(new StaticStringBuilder(title_));
        title.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
		addChild(title);
		
		content = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
		content.x = 5;
		content.y = 18;
        content.setStringBuilder(new StaticStringBuilder(content_));
        content.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
		addChild(content);
		
		/*content = new TextField();
		content.width = 650;
		content.autoSize = TextFieldAutoSize.NONE;
		content.multiline = true;
		content.wordWrap = true;
		content.text = content_;
		content.x = 5;
		content.y = 18;
		textFormat = new TextFormat("Myriad Pro", 12, 0xb3b3b3);
		content.setTextFormat(textFormat);
        content.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
		while(content.numLines > 3) {
			var txt:String = content.getLineText(content.numLines - 1 );
			content.replaceText(content.text.length - txt.length,content.text.length, "");
		}
		addChild(content);*/
    }
}
}