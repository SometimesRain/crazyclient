package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.dropdown.DropDown;
import com.company.ui.BaseSimpleText;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;

public class Filter extends Sprite{

    private static const GAP:int = 2;

    private var curY:int = 0;
    private var _isSearchEnabled:Boolean;
    private var _isValueFilterEnabled:Boolean;
    private var _search:TextInputField;
    private var _filterTypeDropdown:DropDown;
    private var _minInput:TextInputField;
    private var _maxInput:TextInputField;
    private var _dungeonDropDown:DropDown;
    private var _searchPrompt:BaseSimpleText;
    private var _minPrompt:BaseSimpleText;
    private var _maxPrompt:BaseSimpleText;

    public function Filter()
    {
        this.curY = 0;
        this._isSearchEnabled = true;
        this._isValueFilterEnabled = true;
        this._search = new TextInputField("" , false , Chooser.WIDTH , 20 , 16);
        this._search.addEventListener(FocusEvent.FOCUS_IN , this.onFocusIn);
        this._search.addEventListener(FocusEvent.FOCUS_OUT , this.onFocusOut);
        addChild(this._search);
        this._searchPrompt = new BaseSimpleText(14 , 9671571 , false , Chooser.WIDTH);
        this._searchPrompt.htmlText = "<p align=\"center\">search</p>";
        this._searchPrompt.y = this.curY + GAP;
        addChild(this._searchPrompt);
        this.curY = this.curY + (this._search.height + GAP);
        this._filterTypeDropdown = new DropDown(ObjectLibrary.TILE_FILTER_LIST , 80 , 20 , "Filter By");
        this._filterTypeDropdown.y = this.curY;
        this._filterTypeDropdown.addEventListener(Event.CHANGE , this.onFilterTypeChange);
        addChild(this._filterTypeDropdown);
        this._dungeonDropDown = new DropDown(GroupDivider.getDungeonsLabel() , Chooser.WIDTH , 26);
        this._dungeonDropDown.y = this.curY;
        this._dungeonDropDown.addEventListener(Event.CHANGE , this.onFilterTypeChange);
        addChild(this._dungeonDropDown);
        this._dungeonDropDown.visible = false;
        this.curY = this.curY + (this._filterTypeDropdown.height + GAP);
        this._minInput = new TextInputField("" , false , 60 , 20 , 11);
        this._minInput.y = this.curY;
        this._minInput.addEventListener(FocusEvent.FOCUS_IN , this.onFocusIn);
        this._minInput.addEventListener(FocusEvent.FOCUS_OUT , this.onFocusOut);
        addChild(this._minInput);
        this._minPrompt = new BaseSimpleText(14 , 9671571 , false , 60);
        this._minPrompt.htmlText = "<p align=\"center\">min</p>";
        this._minPrompt.x = 2;
        this._minPrompt.y = this.curY + GAP;
        addChild(this._minPrompt);
        this._maxInput = new TextInputField("" , false , 60 , 20 , 11);
        this._maxInput.x = 65;
        this._maxInput.y = this.curY;
        this._maxInput.addEventListener(FocusEvent.FOCUS_IN , this.onFocusIn);
        this._maxInput.addEventListener(FocusEvent.FOCUS_OUT , this.onFocusOut);
        addChild(this._maxInput);
        this._maxPrompt = new BaseSimpleText(14 , 9671571 , false , 60);
        this._maxPrompt.htmlText = "<p align=\"center\">max</p>";
        this._maxPrompt.x = 68;
        this._maxPrompt.y = this.curY + GAP;
        addChild(this._maxPrompt);
        this.enableSearch(this._isSearchEnabled);
        this.enableValueFilter(this._isValueFilterEnabled);
    }

    public function get searchStr():String
    {
        return this._search.text();
    }

    public function get filterType():String
    {
        return this._filterTypeDropdown.getValue();
    }

    public function get minValue():Number
    {
        if(this._minInput.text() == "")
        {
            return 0;
        }
        return Number(this._minInput.text());
    }

    public function get maxValue():Number
    {
        if(this._maxInput.text() == "")
        {
            return -1;
        }
        return Number(this._maxInput.text());
    }

    public function get dungeon():String
    {
        return this._dungeonDropDown.getValue();
    }

    public function setSearch(_arg_1:String):void
    {
        this._search.inputText_.text = _arg_1;
    }

    public function setFilterType(_arg_1:Vector.<String>):void
    {
        this._filterTypeDropdown.setListItems(_arg_1);
        this._filterTypeDropdown.setIndex(0);
    }

    public function enableSearch(_arg_1:Boolean):void
    {
        this._isSearchEnabled = _arg_1;
        this._search.visible = this._isSearchEnabled;
        this._searchPrompt.visible = this._isSearchEnabled;
    }

    public function enableDropDownFilter(_arg_1:Boolean):void
    {
        this._isValueFilterEnabled = _arg_1;
        this._filterTypeDropdown.visible = this._isValueFilterEnabled;
        this._filterTypeDropdown.setIndex(0);
    }

    public function enableValueFilter(_arg_1:Boolean):void
    {
        this._maxInput.visible = _arg_1;
        this._maxInput.inputText_.text = "";
        this._maxPrompt.visible = _arg_1;
        this._minInput.visible = _arg_1;
        this._minInput.inputText_.text = "";
        this._minPrompt.visible = _arg_1;
    }

    public function enableDungeonFilter(_arg_1:Boolean):void
    {
        this._dungeonDropDown.visible = _arg_1;
    }

    private function onFilterTypeChange(_arg_1:Event):void
    {
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function onFocusIn(_arg_1:Event):void
    {
        switch(_arg_1.currentTarget)
        {
            case this._search:
                this._searchPrompt.visible = false;
                break;
            case this._maxInput:
                this._maxPrompt.visible = false;
                break;
            case this._minInput:
                this._minPrompt.visible = false;
        }
    }

    private function onFocusOut(_arg_1:FocusEvent):void
    {
        switch(_arg_1.currentTarget)
        {
            case this._search:
                if(this._search.text() == "")
                {
                    this._searchPrompt.visible = this._isSearchEnabled;
                }
                break;
            case this._maxInput:
                if(this._maxInput.text() == "")
                {
                    this._maxPrompt.visible = this._isValueFilterEnabled;
                }
                break;
            case this._minInput:
                if(this._minInput.text() == "")
                {
                    this._minPrompt.visible = this._isValueFilterEnabled;
                }
        }
    }

}
}
