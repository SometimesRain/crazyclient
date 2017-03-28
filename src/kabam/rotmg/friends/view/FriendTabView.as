package kabam.rotmg.friends.view {
import com.company.ui.BaseSimpleText;
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.game.view.components.TabBackground;
import kabam.rotmg.game.view.components.TabConstants;
import kabam.rotmg.game.view.components.TabTextView;
import kabam.rotmg.game.view.components.TabView;

import org.osflash.signals.Signal;

public class FriendTabView extends Sprite {

    public const tabSelected:Signal = new Signal(String);
    private const TAB_WIDTH:int = 120;
    private const TAB_HEIGHT:int = 30;
    private const tabSprite:Sprite = new Sprite();
    private const background:Sprite = new Sprite();
    private const containerSprite:Sprite = new Sprite();

    public var tabs:Vector.<TabView>;
    public var currentTabIndex:int;
    private var _width:Number;
    private var _height:Number;
    private var contents:Vector.<Sprite>;

    public function FriendTabView(_arg_1:Number, _arg_2:Number) {
        this.tabs = new Vector.<TabView>();
        this.contents = new Vector.<Sprite>();
        super();
        this._width = _arg_1;
        this._height = _arg_2;
        this.tabSprite.addEventListener(MouseEvent.CLICK, this.onTabClicked);
        addChild(this.tabSprite);
        this.drawBackground();
        addChild(this.containerSprite);
    }

    public function destroy():void {
        while (numChildren > 0) {
            this.removeChildAt((numChildren - 1));
        }
        this.tabSprite.removeEventListener(MouseEvent.CLICK, this.onTabClicked);
        this.tabs = null;
        this.contents = null;
    }

    public function addTab(_arg_1:BaseSimpleText, _arg_2:Sprite):void {
        var _local_3:int = this.tabs.length;
        var _local_4:TabView = this.addTextTab(_local_3, (_arg_1 as BaseSimpleText));
        this.tabs.push(_local_4);
        this.tabSprite.addChild(_local_4);
        _arg_2.y = (this.TAB_HEIGHT + 5);
        this.contents.push(_arg_2);
        this.containerSprite.addChild(_arg_2);
        if (_local_3 > 0) {
            _arg_2.visible = false;
        }
        else {
            _local_4.setSelected(true);
            this.showContent(0);
            this.tabSelected.dispatch(_arg_2.name);
        }
    }

    public function clearTabs():void {
        var _local_1:uint;
        this.currentTabIndex = 0;
        var _local_2:uint = this.tabs.length;
        _local_1 = 0;
        while (_local_1 < _local_2) {
            this.tabSprite.removeChild(this.tabs[_local_1]);
            this.containerSprite.removeChild(this.contents[_local_1]);
            _local_1++;
        }
        this.tabs = new Vector.<TabView>();
        this.contents = new Vector.<Sprite>();
    }

    public function removeTab():void {
    }

    public function setSelectedTab(_arg_1:uint):void {
        this.selectTab(this.tabs[_arg_1]);
    }

    public function showTabBadget(_arg_1:uint, _arg_2:int):void {
        var _local_3:TabView = this.tabs[_arg_1];
        (_local_3 as TabTextView).setBadge(_arg_2);
    }

    private function onTabClicked(_arg_1:MouseEvent):void {
        this.selectTab((_arg_1.target.parent as TabView));
    }

    private function selectTab(_arg_1:TabView):void {
        var _local_2:TabView;
        if (_arg_1) {
            _local_2 = this.tabs[this.currentTabIndex];
            if (_local_2.index != _arg_1.index) {
                _local_2.setSelected(false);
                _arg_1.setSelected(true);
                this.showContent(_arg_1.index);
                this.tabSelected.dispatch(this.contents[_arg_1.index].name);
            }
        }
    }

    private function addTextTab(_arg_1:int, _arg_2:BaseSimpleText):TabTextView {
        var _local_4:TabTextView;
        var _local_3:Sprite = new TabBackground(this.TAB_WIDTH, this.TAB_HEIGHT);
        _local_4 = new TabTextView(_arg_1, _local_3, _arg_2);
        _local_4.x = (_arg_1 * (_arg_2.width + 12));
        _local_4.y = 4;
        return (_local_4);
    }

    private function showContent(_arg_1:int):void {
        var _local_2:Sprite;
        var _local_3:Sprite;
        if (_arg_1 != this.currentTabIndex) {
            _local_2 = this.contents[this.currentTabIndex];
            _local_3 = this.contents[_arg_1];
            _local_2.visible = false;
            _local_3.visible = true;
            this.currentTabIndex = _arg_1;
        }
    }

    private function drawBackground():void {
        var _local_1:GraphicsSolidFill = new GraphicsSolidFill(TabConstants.BACKGROUND_COLOR, 1);
        var _local_2:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        var _local_3:Vector.<IGraphicsData> = new <IGraphicsData>[_local_1, _local_2, GraphicsUtil.END_FILL];
        GraphicsUtil.drawCutEdgeRect(0, 0, this._width, (this._height - TabConstants.TAB_TOP_OFFSET), 6, [1, 1, 1, 1], _local_2);
        this.background.graphics.drawGraphicsData(_local_3);
        this.background.y = TabConstants.TAB_TOP_OFFSET;
        addChild(this.background);
    }


}
}//package kabam.rotmg.friends.view
