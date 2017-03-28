package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;
import flash.utils.Dictionary;

public class EnemyChooser extends Chooser {

    private var cache:Dictionary;
    private var lastSearch:String = "";
    private var filterTypes:Dictionary;

    function EnemyChooser(_arg_1:String = "")
    {
        this.filterTypes = new Dictionary(true);
        super(Layer.OBJECT);
        this.cache = new Dictionary();
        this.reloadObjects(_arg_1, "", 0, -1, true);
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[0]] = "";
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[1]] = "MaxHitPoints";
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[2]] = ObjectLibrary.ENEMY_FILTER_LIST[2];
    }

    public function getLastSearch() : String
    {
        return this.lastSearch;
    }

    public function reloadObjects(_arg_1:String, _arg_2:String = "", _arg_3:Number = 0, _arg_4:Number = -1, param5:Boolean = false) : void
    {
        var _local_8:XML;
        var _local_11:RegExp = null;
        var _local_13:String;
        var _local_14:int;
        var _local_15:ObjectElement;
        if(!param5)
        {
            removeElements();
        }
        this.lastSearch = _arg_1;
        var _local_6:Boolean = true;
        var _local_7:Boolean = true;
        var _local_9:Number = -1;
        var _local_10:Vector.<String> = new Vector.<String>();
        if(_arg_1 != "")
        {
            _local_11 = new RegExp(_arg_1, "gix");
        }
        if(_arg_2 != "")
        {
            _arg_2 = this.filterTypes[_arg_2];
        }
        var _local_12:Dictionary = GroupDivider.GROUPS["Enemies"];
        for each(_local_8 in _local_12)
        {
            _local_13 = String(_local_8.@id);
            if(!(_local_11 != null && _local_13.search(_local_11) < 0))
            {
                if(_arg_2 != "")
                {
                    _local_9 = _local_8.hasOwnProperty(_arg_2) ? Number(Number(_local_8.elements(_arg_2))) : Number(-1);
                    if(_local_9 < 0)
                    {
                        continue;
                    }
                    _local_6 = _local_9 >= _arg_3;
                    _local_7 = !(_arg_4 > 0 && _local_9 > _arg_4);
                }
                if(_local_6 && _local_7)
                {
                    _local_10.push(_local_13);
                }
            }
        }
        _local_10.sort(MoreStringUtil.cmp);
        for each(_local_13 in _local_10)
        {
            _local_14 = ObjectLibrary.idToType_[_local_13];
            if(!this.cache[_local_14])
            {
                _local_15 = new ObjectElement(ObjectLibrary.xmlLibrary_[_local_14]);
                this.cache[_local_14] = _local_15;
            }
            else
            {
                _local_15 = this.cache[_local_14];
            }
            addElement(_local_15);
        }
        scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
    }

}
}
