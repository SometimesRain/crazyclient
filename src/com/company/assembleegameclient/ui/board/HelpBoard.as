package com.company.assembleegameclient.ui.board {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.rotmg.graphics.DeleteXGraphic;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import flash.events.MouseEvent;

public class HelpBoard extends Frame {
	
    private var closeDialogs:CloseDialogsSignal;
    private var deleteButton:Sprite;
	private var scrollBar:Scrollbar;
	private var container:HelpContainer;
	private var title:TextFieldDisplayConcrete;

    public function HelpBoard() {
        super("");
		closeDialogs = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        w_ = 700;
        h_ = 550;
		container = new HelpContainer();
		addChild(container);
		createScrollbar();
		makeMask();
        makeDeleteButton();
    }

    private function createScrollbar():void {
        scrollBar = new Scrollbar(16, 510);
        scrollBar.x = 674;
        scrollBar.y = 32;
        scrollBar.setIndicatorSize(510, container.height);
        scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
        addChild(this.scrollBar);
    }
	
    private function onScrollBarChange(_arg_1:Event):void {
		container.setPos((-(scrollBar.pos()) * (container.height - 510)));
    }
    
	private function makeMask():void {
        var s:Shape = new Shape(); //mask
		s.x = -6;
		s.y = -6;
        var g:Graphics = s.graphics;
        g.beginFill(0);
        g.drawRect(0, 0, 701, 551);
        g.endFill();
        addChild(s);
        mask = s;
		s = new Shape(); //bottom line
		s.y = 544;
		g = s.graphics;
        g.beginFill(0xffffff);
        g.drawRect(0, 0, 670, 1);
        g.endFill();
        addChild(s);
		s = new Shape(); //top line
		s.y = -6;
		g = s.graphics;
        g.beginFill(0xffffff);
        g.drawRect(0, 0, 670, 1);
        g.endFill();
        addChild(s);
		s = new Shape(); //top shader
		s.y = 26;
		s.x = -5;
		g = s.graphics;
        g.beginFill(0, 100/255);
        g.drawRect(0, 0, 699, 1);
        g.endFill();
        addChild(s);
		s = new Shape(); //middle shader
		s.y = 27;
		s.x = -5;
		g = s.graphics;
        g.beginFill(0, 50/255);
        g.drawRect(0, 0, 699, 1);
        g.endFill();
        addChild(s);
		s = new Shape(); //bottom shader
		s.y = 28;
		s.x = -5;
		g = s.graphics;
        g.beginFill(0, 25/255);
        g.drawRect(0, 0, 699, 1);
        g.endFill();
        addChild(s);
		s = new Shape(); //top bar
		s.y = -5;
		g = s.graphics;
        g.beginFill(0x4d4d4d);
        g.drawRect(0, 0, 670, 31);
        g.endFill();
        addChild(s);
	}
    
	private function makeDeleteButton():void {
        title = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        title.setStringBuilder(new StaticStringBuilder("Commands"));
        title.filters = [new DropShadowFilter(0, 0, 0)];
        title.x = 5;
        title.y = 3;
        addChild(title);
        deleteButton = new DeleteXGraphic();
        deleteButton.addEventListener(MouseEvent.CLICK, onClose);
        deleteButton.x = 668;
        addChild(deleteButton);
    }

    private function onClick(e:MouseEvent):void {
		
    }

    private function onClose(e:MouseEvent):void {
        closeDialogs.dispatch();
    }

}
}