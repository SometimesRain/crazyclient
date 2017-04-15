package com.company.assembleegameclient.ui.board {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class HelpContainer extends Sprite {

	private var articles:HelpXML = new HelpXML();
	
    public function HelpContainer() {
		makeContent();
    }
    
	private function makeContent():void {
		var i:int;
		var y:int = 32;
		var c:int;
		var he:HelpElement;
		//for (i = 0; i < 7; i++) {
		for (i = 0; i < articles.commands.length; i++) {
			//if (y > 544) break;
			//he = new HelpElement("/con <server> <character> <realm>", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy\ntext ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has\nsurvived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in\nthe 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software\nlike Aldus PageMaker including versions of Lorem Ipsum.", 4);
			c = count(articles.explanations[i], "\n");
			he = new HelpElement(articles.commands[i], articles.explanations[i], c);
			he.y = y;
			addChild(he);
			y += 42 + c * 12;
		}
	}
	
	private function count(s:String, letter:String):int {
		return s.match(new RegExp(letter,"g")).length;
	}

    public function setPos(_arg_1:Number):void {
        this.y = _arg_1;
    }

}
}