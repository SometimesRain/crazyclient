package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.account.ui.CheckBoxField;
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;

import kabam.lib.json.JsonParser;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.editor.view.components.savedialog.TagsInputField;
import kabam.rotmg.fortune.components.TimerCallback;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

import ru.inspirit.net.MultipartURLLoader;

public class SubmitMapForm extends Frame {

    public static var cancel:Signal;

    private var mapName:TextInputField;
    private var descr:TextInputField;
    private var tags:TagsInputField;
    private var mapjm:String;
    private var mapInfo:Object;
    private var account:Account;
    private var checkbox:CheckBoxField;

    public function SubmitMapForm(_arg_1:String, _arg_2:Object, _arg_3:Account)
    {
        super("SubmitMapForm.Title", TextKey.FRAME_CANCEL, TextKey.WEB_CHANGE_PASSWORD_RIGHT, 300);
        cancel = new Signal();
        this.account = _arg_3;
        this.mapjm = _arg_1;
        this.mapInfo = _arg_2;
        this.mapName = new TextInputField("Map Name");
        addTextInputField(this.mapName);
        this.tags = new TagsInputField("", 238, 50, true);
        addComponent(this.tags, 12);
        this.descr = new TextInputField("Description", false, 238, 100, 20, 256, true);
        addTextInputField(this.descr);
        addSpace(35);
        this.checkbox = new CheckBoxField("Overwrite", true, 12);
        addCheckBox(this.checkbox);
        this.enableButtons();
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public static function isInitialized():Boolean
    {
        return cancel != null;
    }

    private function disableButtons():void
    {
        rightButton_.removeEventListener(MouseEvent.CLICK, this.onSubmit);
        leftButton_.removeEventListener(MouseEvent.CLICK, this.onCancel);
    }

    private function enableButtons():void
    {
        rightButton_.addEventListener(MouseEvent.CLICK, this.onSubmit);
        leftButton_.addEventListener(MouseEvent.CLICK, this.onCancel);
    }

    private function onSubmit(_arg_1:MouseEvent):void
    {
        this.disableButtons();
        this.mapName.clearError();
        var _local_2:JsonParser = StaticInjectorContext.getInjector().getInstance(JsonParser);
        var _local_3:Object = _local_2.parse(this.mapjm);
        var _local_4:int = _local_3["width"];
        var _local_5:int = _local_3["height"];
        var _local_6:MultipartURLLoader = new MultipartURLLoader();
        _local_6.addVariable("guid", this.account.getUserId());
        _local_6.addVariable("password", this.account.getPassword());
        _local_6.addVariable("name", this.mapName.text());
        _local_6.addVariable("description", this.descr.text());
        _local_6.addVariable("width", _local_4);
        _local_6.addVariable("height", _local_5);
        _local_6.addVariable("mapjm", this.mapjm);
        _local_6.addVariable("tags", this.tags.text());
        _local_6.addVariable("totalObjects", this.mapInfo.numObjects);
        _local_6.addVariable("totalTiles", this.mapInfo.numTiles);
        _local_6.addFile(this.mapInfo.thumbnail, "foo.png", "thumbnail");
        _local_6.addVariable("overwrite", this.checkbox.isChecked() ? "on" : "off");
        var _local_7:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        var _local_8:String = _local_7.getAppEngineUrl(true) + "/ugc/save";
        this.enableButtons();
        var _local_9:Object = {
            "name":this.mapName.text(), 
            "description":this.descr.text(), 
            "width":_local_4, 
            "height":_local_5, 
            "mapjm":this.mapjm, 
            "tags":this.tags.text(), 
            "totalObjects":this.mapInfo.numObjects, 
            "totalTiles":this.mapInfo.numTiles, 
            "thumbnail":this.mapInfo.thumbnail, 
            "overwrite":this.checkbox.isChecked() ? "on" : "off"
        };
        if(this.validated(_local_9))
        {
            _local_6.addEventListener(Event.COMPLETE, this.onComplete);
            _local_6.addEventListener(IOErrorEvent.IO_ERROR, this.onCompleteException);
            _local_6.load(_local_8);
        }
        else
        {
            this.enableButtons();
        }
    }

    private function onCompleteException(_arg_1:IOErrorEvent):void
    {
        this.descr.setError("Exception. If persists, please contact dev team.");
        this.enableButtons();
    }

    private function onComplete(_arg_1:Event):void
    {
        var _local_3:Array = null;
        var _local_4:String = null;
        var _local_2:MultipartURLLoader = MultipartURLLoader(_arg_1.target);
        if(_local_2.loader.data == "<Success/>")
        {
            this.descr.setError("Success! Thank you!");
            new TimerCallback(2, this.onCancel);
        }
        else
        {
            _local_3 = _local_2.loader.data.match("<.*>(.*)</.*>");
            _local_4 = _local_3.length > 1?_local_3[1]:_local_2.loader.data;
            this.descr.setError(_local_4);
        }
        this.enableButtons();
    }

    private function onCancel(_arg_1:MouseEvent = null):void
    {
        cancel.dispatch();
        if(parent)
        {
            parent.removeChild(this);
        }
    }

    private function onRemovedFromStage(_arg_1:Event):void
    {
        if(rightButton_)
        {
            rightButton_.removeEventListener(MouseEvent.CLICK, this.onSubmit);
        }
        if(cancel)
        {
            cancel.removeAll();
            cancel = null;
        }
    }

    private function validated(_arg_1:Object):Boolean
    {
        if(_arg_1["name"].length < 6 || _arg_1["name"].length > 24)
        {
            this.mapName.setError("Map name length out of range (6-24 chars)");
            return false;
        }
        if(_arg_1["description"].length < 10 || _arg_1["description"].length > 250)
        {
            this.descr.setError("Description length out of range (10-250 chars)");
            return false;
        }
        return this.isValidMap();
    }

    private function isValidMap():Boolean
    {
        if(this.mapInfo.numExits < 1)
        {
            this.descr.setError("Must have at least one User Dungeon End region drawn in this dungeon. (tmp)");
            return false;
        }
        if(this.mapInfo.numEntries < 1)
        {
            this.descr.setError("Must have at least one Spawn Region drawn in this dungeon. (tmp)");
            return false;
        }
        return true;
    }

}
}
