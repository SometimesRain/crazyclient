package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class DungeonChooser extends Chooser{

    public var currentDungon:String = "";
    private var cache:Dictionary;
    private var lastSearch:String = "";

    public function DungeonChooser(_arg_1:String = "")
    {
        super(Layer.OBJECT);
        this.cache = new Dictionary();
        this.reloadObjects(GroupDivider.DEFAULT_DUNGEON, _arg_1, true);
    }

    public function getLastSearch():String
    {
        return this.lastSearch;
    }

    public function reloadObjects(_arg_1:String, _arg_2:String, _arg_3:Boolean = false):void
    {
        var _local_5:RegExp = null;
        var _local_7:String;
        var _local_8:XML;
        var _local_9:int;
        var _local_10:ObjectElement;
        this.currentDungon = _arg_1;
        if(!_arg_3)
        {
            removeElements();
        }
        this.lastSearch = _arg_2;
        var _local_4:Vector.<String> = new Vector.<String>();
        if(_arg_2 != "")
        {
            _local_5 = new RegExp(_arg_2, "gix");
        }
        var _local_6:Dictionary = GroupDivider.getDungeonsXML(this.currentDungon);
        for each(_local_8 in _local_6)
        {
            _local_7 = String(_local_8.@id);
            if(_local_5 == null || _local_7.search(_local_5) >= 0)
            {
                _local_4.push(_local_7);
            }
        }
        _local_4.sort(MoreStringUtil.cmp);
        for each(_local_7 in _local_4)
        {
            _local_9 = ObjectLibrary.idToType_[_local_7];
            _local_8 = _local_6[_local_9];
            if(!this.cache[_local_9])
            {
                _local_10 = new ObjectElement(_local_8);
                this.cache[_local_9] = _local_10;
            }
            else
            {
                _local_10 = this.cache[_local_9];
            }
            addElement(_local_10);
        }
        scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
    }

}
}
