package kabam.rotmg.arena.view {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.arena.component.AbridgedPlayerTooltip;
import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.components.PetIconFactory;
import kabam.rotmg.pets.view.components.PetTooltip;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class ArenaLeaderboardListItem extends Sprite {

    private static const HEIGHT:int = 60;

    public const showTooltip:Signal = new Signal(Sprite);
    public const hideTooltip:Signal = new Signal();

    private var playerIconContainer:Sprite;
    private var petIconContainer:Sprite;
    private var playerIcon:Bitmap;
    private var playerTooltip:AbridgedPlayerTooltip;
    private var petTooltip:PetTooltip;
    private var rank:int = 0;
    private var petBitmap:Bitmap;
    private var petIconBackground:Sprite;
    private var petIconFactory:PetIconFactory;
    private var rankNumber:StaticTextDisplay;
    private var playerName:StaticTextDisplay;
    private var waveNumber:StaticTextDisplay;
    private var runTime:StaticTextDisplay;
    private var background:Sprite;
    private var isActive:Boolean = false;
    private var isPersonalRecord:Boolean = false;
    private var rankNumberStringBuilder:StaticStringBuilder;
    private var playerNameStringBuilder:StaticStringBuilder;
    private var waveNumberStringBuilder:LineBuilder;
    private var runTimeStringBuilder:StaticStringBuilder;

    public function ArenaLeaderboardListItem() {
        this.playerIconContainer = new Sprite();
        this.petIconContainer = new Sprite();
        this.playerIcon = new Bitmap();
        this.petIconBackground = this.makePetIconBackground();
        this.rankNumber = this.makeTextDisplay();
        this.playerName = this.makeTextDisplay();
        this.waveNumber = this.makeTextDisplay();
        this.runTime = this.makeTextDisplay();
        this.background = this.makeBackground();
        this.rankNumberStringBuilder = new StaticStringBuilder();
        this.playerNameStringBuilder = new StaticStringBuilder();
        this.waveNumberStringBuilder = new LineBuilder();
        this.runTimeStringBuilder = new StaticStringBuilder();
        super();
        this.petIconFactory = StaticInjectorContext.getInjector().getInstance(PetIconFactory);
        this.rankNumber.setAutoSize(TextFieldAutoSize.RIGHT);
        this.addChildren();
        this.addEventListeners();
    }

    private function addEventListeners():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        this.playerIconContainer.addEventListener(MouseEvent.MOUSE_OVER, this.onPlayerIconOver);
        this.playerIconContainer.addEventListener(MouseEvent.MOUSE_OUT, this.onPlayerIconOut);
        this.petIconContainer.addEventListener(MouseEvent.MOUSE_OVER, this.onPetIconOver);
        this.petIconContainer.addEventListener(MouseEvent.MOUSE_OUT, this.onPetIconOut);
    }

    private function addChildren():void {
        addChild(this.background);
        addChild(this.playerIconContainer);
        addChild(this.petIconBackground);
        addChild(this.petIconContainer);
        addChild(this.rankNumber);
        addChild(this.playerName);
        addChild(this.waveNumber);
        addChild(this.runTime);
        this.playerIconContainer.addChild(this.playerIcon);
    }

    private function onPlayerIconOut(_arg_1:MouseEvent):void {
        this.hideTooltip.dispatch();
    }

    private function onPlayerIconOver(_arg_1:MouseEvent):void {
        if (this.playerTooltip) {
            this.showTooltip.dispatch(this.playerTooltip);
        }
    }

    private function onPetIconOut(_arg_1:MouseEvent):void {
        this.hideTooltip.dispatch();
    }

    private function onPetIconOver(_arg_1:MouseEvent):void {
        if (this.playerTooltip) {
            this.showTooltip.dispatch(this.petTooltip);
        }
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        if (this.isActive) {
            this.background.alpha = 0;
        }
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        if (this.isActive) {
            this.background.alpha = 1;
        }
    }

    public function apply(_arg_1:ArenaLeaderboardEntry, _arg_2:Boolean):void {
        this.isActive = !((_arg_1 == null));
        if (_arg_1) {
            this.initPlayerData(_arg_1);
            this.initArenaData(_arg_1);
            if (((_arg_1.rank) && (_arg_2))) {
                this.rankNumber.visible = true;
                this.rankNumber.setStringBuilder(this.rankNumberStringBuilder.setString((_arg_1.rank + ".")));
            }
            else {
                this.rankNumber.visible = false;
            }
            if (this.petBitmap) {
                this.destroyPetIcon();
            }
            if (_arg_1.pet) {
                this.initPetIcon(_arg_1);
            }
            this.rank = _arg_1.rank;
            this.isPersonalRecord = _arg_1.isPersonalRecord;
            this.setColor();
        }
        else {
            this.clear();
        }
        this.align();
    }

    private function initArenaData(_arg_1:ArenaLeaderboardEntry):void {
        this.waveNumber.setStringBuilder(this.waveNumberStringBuilder.setParams(TextKey.ARENA_LEADERBOARD_LIST_ITEM_WAVENUMBER, {"waveNumber": (_arg_1.currentWave - 1).toString()}));
        this.runTime.setStringBuilder(this.runTimeStringBuilder.setString(this.formatTime(Math.floor(_arg_1.runtime))));
    }

    private function initPlayerData(_arg_1:ArenaLeaderboardEntry):void {
        this.playerIcon.bitmapData = _arg_1.playerBitmap;
        this.playerTooltip = new AbridgedPlayerTooltip(_arg_1);
        this.playerName.setStringBuilder(this.playerNameStringBuilder.setString(_arg_1.name));
    }

    private function initPetIcon(_arg_1:ArenaLeaderboardEntry):void {
        this.petTooltip = new PetTooltip(_arg_1.pet);
        this.petBitmap = this.getPetBitmap(_arg_1.pet, 48);
        this.petIconContainer.addChild(this.petBitmap);
        this.petIconBackground.visible = true;
    }

    private function destroyPetIcon():void {
        this.petIconContainer.removeChild(this.petBitmap);
        this.petTooltip = null;
        this.petBitmap = null;
        this.petIconBackground.visible = false;
    }

    private function getPetBitmap(_arg_1:PetVO, _arg_2:int):Bitmap {
        return (new Bitmap(this.petIconFactory.getPetSkinTexture(_arg_1, _arg_2)));
    }

    public function setColor():void {
        var _local_1:uint = 0xFFFFFF;
        if (this.isPersonalRecord) {
            _local_1 = 16567065;
        }
        else {
            if (this.rank == 1) {
                _local_1 = 16777103;
            }
        }
        this.playerName.setColor(_local_1);
        this.waveNumber.setColor(_local_1);
        this.runTime.setColor(_local_1);
        this.rankNumber.setColor(_local_1);
    }

    public function clear():void {
        this.playerIcon.bitmapData = null;
        this.playerName.setStringBuilder(this.playerNameStringBuilder.setString(""));
        this.waveNumber.setStringBuilder(this.waveNumberStringBuilder.setParams(""));
        this.runTime.setStringBuilder(this.runTimeStringBuilder.setString(""));
        this.rankNumber.setStringBuilder(this.rankNumberStringBuilder.setString(""));
        if (this.petBitmap) {
            this.destroyPetIcon();
        }
        this.petBitmap = null;
        this.petIconBackground.visible = false;
        this.rank = 0;
    }

    private function makeTextDisplay():StaticTextDisplay {
        var _local_1:StaticTextDisplay;
        _local_1 = new StaticTextDisplay();
        _local_1.setBold(true).setSize(24);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        return (_local_1);
    }

    private function makeBackground():Sprite {
        var _local_1:Sprite = new Sprite();
        _local_1.graphics.beginFill(0, 0.5);
        _local_1.graphics.drawRect(0, 0, 750, 60);
        _local_1.graphics.endFill();
        _local_1.alpha = 0;
        return (_local_1);
    }

    private function makePetIconBackground():Sprite {
        var _local_1:Sprite = new Sprite();
        _local_1.graphics.beginFill(0x545454);
        _local_1.graphics.drawRoundRect(0, 0, 40, 40, 10, 10);
        _local_1.graphics.endFill();
        _local_1.visible = false;
        return (_local_1);
    }

    private function formatTime(_arg_1:int):String {
        var _local_2:int = Math.floor((_arg_1 / 60));
        var _local_3:String = ((((_local_2 < 10)) ? "0" : "") + _local_2.toString());
        var _local_4:int = (_arg_1 % 60);
        var _local_5:String = ((((_local_4 < 10)) ? "0" : "") + _local_4.toString());
        return (((_local_3 + ":") + _local_5));
    }

    private function align():void {
        this.rankNumber.x = 75;
        this.rankNumber.y = ((HEIGHT / 2) - (this.rankNumber.height / 2));
        this.playerIcon.x = 110;
        this.playerIcon.y = (((HEIGHT / 2) - (this.playerIcon.height / 2)) - 3);
        if (this.petBitmap) {
            this.petBitmap.x = 170;
            this.petBitmap.y = ((HEIGHT / 2) - (this.petBitmap.height / 2));
            this.petIconBackground.x = 175;
            this.petIconBackground.y = ((HEIGHT / 2) - (this.petIconBackground.height / 2));
        }
        this.playerName.x = 230;
        this.playerName.y = ((HEIGHT / 2) - (this.playerName.height / 2));
        this.waveNumber.x = 485;
        this.waveNumber.y = ((HEIGHT / 2) - (this.waveNumber.height / 2));
        this.runTime.x = 635;
        this.runTime.y = ((HEIGHT / 2) - (this.runTime.height / 2));
    }


}
}//package kabam.rotmg.arena.view
