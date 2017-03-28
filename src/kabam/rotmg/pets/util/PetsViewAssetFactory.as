package kabam.rotmg.pets.util {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.filters.DropShadowFilter;
import flash.text.TextFormatAlign;

import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.FameOrGoldBuyButtons;
import kabam.rotmg.pets.view.components.FeedFuseArrow;
import kabam.rotmg.pets.view.components.FusionStrength;
import kabam.rotmg.pets.view.components.PetAbilityMeter;
import kabam.rotmg.pets.view.components.PetFeeder;
import kabam.rotmg.pets.view.components.PetFuser;
import kabam.rotmg.pets.view.components.PetsButtonBar;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.pets.view.components.slot.FoodFeedFuseSlot;
import kabam.rotmg.pets.view.components.slot.PetFeedFuseSlot;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetsViewAssetFactory {


    public static function returnWindowBackground(_arg_1:uint, _arg_2:uint):PopupWindowBackground {
        var _local_3:PopupWindowBackground = new PopupWindowBackground();
        _local_3.draw(_arg_1, _arg_2);
        _local_3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, PetsConstants.WINDOW_LINE_ONE_POS_Y);
        _local_3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, PetsConstants.WINDOW_LINE_TWO_POS_Y);
        return (_local_3);
    }

    public static function returnFuserWindowBackground():PopupWindowBackground {
        var _local_1:PopupWindowBackground = new PopupWindowBackground();
        _local_1.draw(PetsConstants.WINDOW_BACKGROUND_WIDTH, PetsConstants.FUSER_WINDOW_BACKGROUND_HEIGHT);
        _local_1.divide(PopupWindowBackground.HORIZONTAL_DIVISION, PetsConstants.WINDOW_LINE_ONE_POS_Y);
        _local_1.divide(PopupWindowBackground.HORIZONTAL_DIVISION, PetsConstants.FUSER_WINDOW_LINE_TWO_POS_Y);
        return (_local_1);
    }

    public static function returnFameOrGoldButtonBar(_arg_1:String, _arg_2:uint):FameOrGoldBuyButtons {
        var _local_3:FameOrGoldBuyButtons = new FameOrGoldBuyButtons();
        _local_3.y = _arg_2;
        _local_3.setPrefix(_arg_1);
        return (_local_3);
    }

    public static function returnButtonBar():PetsButtonBar {
        var _local_1:PetsButtonBar;
        _local_1 = new PetsButtonBar();
        _local_1.y = (PetsConstants.WINDOW_BACKGROUND_HEIGHT - 35);
        return (_local_1);
    }

    private static function returnAbilityMeter():PetAbilityMeter {
        var _local_1:PetAbilityMeter;
        _local_1 = new PetAbilityMeter();
        _local_1.y = PetsConstants.METER_START_POSITION_Y;
        return (_local_1);
    }

    public static function returnAbilityMeters():Vector.<PetAbilityMeter> {
        return (Vector.<PetAbilityMeter>([returnAbilityMeter(), returnAbilityMeter(), returnAbilityMeter()]));
    }

    public static function returnFuseDescriptionTextfield():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.PET_FUSER_DESCRIPTION));
        _local_1.setTextWidth((PetsConstants.WINDOW_BACKGROUND_WIDTH - 20)).setWordWrap(true).setHorizontalAlign(TextFormatAlign.CENTER).setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(0xB3B3B3);
        _local_1.y = 42;
        return (_local_1);
    }

    public static function returnPetSlotTitle():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete;
        _local_1 = new TextFieldDisplayConcrete();
        _local_1.setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(0xB3B3B3).setBold(true).setHorizontalAlign(TextFormatAlign.CENTER).setWordWrap(true).setTextWidth(100);
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        _local_1.y = PetsConstants.PET_SLOT_TITLE_Y;
        return (_local_1);
    }

    public static function returnMediumCenteredTextfield(_arg_1:uint, _arg_2:uint):TextFieldDisplayConcrete {
        var _local_3:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_3.setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(_arg_1).setBold(true).setHorizontalAlign(TextFormatAlign.CENTER).setWordWrap(true).setTextWidth(_arg_2);
        return (_local_3);
    }

    public static function returnPetFeeder():PetFeeder {
        var _local_1:PetFeeder = new PetFeeder();
        _local_1.y = PetsConstants.PET_WINDOW_TOOL_Y_POS;
        return (_local_1);
    }

    public static function returnPetFuser():PetFuser {
        var _local_1:PetFuser = new PetFuser();
        _local_1.y = (PetsConstants.PET_WINDOW_TOOL_Y_POS + 50);
        return (_local_1);
    }

    public static function returnPetFeederArrow():FeedFuseArrow {
        var _local_1:FeedFuseArrow;
        _local_1 = new FeedFuseArrow();
        _local_1.x = PetsConstants.PET_FEEDER_ARROW_X;
        _local_1.y = PetsConstants.PET_FEEDER_ARROW_Y;
        return (_local_1);
    }

    public static function returnPetFeederRightSlot():FoodFeedFuseSlot {
        var _local_1:FoodFeedFuseSlot = new FoodFeedFuseSlot();
        _local_1.x = (PetsConstants.PET_FEEDER_ARROW_X + 35);
        _local_1.hideOuterSlot(true);
        return (_local_1);
    }

    public static function returnPetFuserRightSlot():PetFeedFuseSlot {
        var _local_1:PetFeedFuseSlot;
        _local_1 = new PetFeedFuseSlot();
        _local_1.x = (PetsConstants.PET_FEEDER_ARROW_X + 35);
        _local_1.hideOuterSlot(true);
        _local_1.showFamily = true;
        return (_local_1);
    }

    public static function returnPetSlotShape(_arg_1:uint, _arg_2:uint, _arg_3:int, _arg_4:Boolean, _arg_5:Boolean, _arg_6:int = 2):Shape {
        var _local_7:Shape;
        _local_7 = new Shape();
        ((_arg_4) && (_local_7.graphics.beginFill(0x464646, 1)));
        ((_arg_5) && (_local_7.graphics.lineStyle(_arg_6, _arg_2)));
        _local_7.graphics.drawRoundRect(0, _arg_3, _arg_1, _arg_1, 16, 16);
        _local_7.x = ((100 - _arg_1) * 0.5);
        return (_local_7);
    }

    public static function returnCloseButton(_arg_1:int):DialogCloseButton {
        var _local_2:DialogCloseButton = new DialogCloseButton();
        _local_2.y = 4;
        _local_2.x = ((_arg_1 - _local_2.width) - 5);
        return (_local_2);
    }

    public static function returnTooltipLineBreak():LineBreakDesign {
        var _local_1:LineBreakDesign;
        _local_1 = new LineBreakDesign(173, 0);
        _local_1.x = 5;
        _local_1.y = 64;
        return (_local_1);
    }

    public static function returnBitmap(_arg_1:uint, _arg_2:uint = 80):Bitmap {
        return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg_1, _arg_2, true)));
    }

    public static function returnInteractionBitmap():Bitmap {
        return (getBitmapForItem(6466));
    }

    public static function returnCaretakerBitmap(_arg_1:uint):Bitmap {
        return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg_1, 80, true)));
    }

    private static function getBitmapForItem(_arg_1:uint):Bitmap {
        var _local_2:Bitmap = new Bitmap();
        var _local_3:XML = ObjectLibrary.xmlLibrary_[_arg_1];
        var _local_4:int = 5;
        if (_local_3.hasOwnProperty("ScaleValue")) {
            _local_4 = _local_3.ScaleValue;
        }
        var _local_5:BitmapData = ObjectLibrary.getRedrawnTextureFromType(_arg_1, 80, true, true, _local_4);
        _local_5 = BitmapUtil.cropToBitmapData(_local_5, 4, 4, (_local_5.width - 8), (_local_5.height - 8));
        return (new Bitmap(_local_5));
    }

    public static function returnFusionStrength():FusionStrength {
        var _local_1:FusionStrength = new FusionStrength();
        _local_1.y = PetsConstants.FUSION_STRENGTH_Y_POS;
        _local_1.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - _local_1.width) * 0.5);
        return (_local_1);
    }

    public static function returnTopAlignedTextfield(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean = false):TextFieldDisplayConcrete {
        var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_5.setSize(_arg_2).setColor(_arg_1).setBold(_arg_3);
        _local_5.filters = ((_arg_4) ? [new DropShadowFilter(0, 0, 0)] : []);
        return (_local_5);
    }

    public static function returnTextfield(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean = false):TextFieldDisplayConcrete {
        var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_5.setSize(_arg_2).setColor(_arg_1).setBold(_arg_3);
        _local_5.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
        _local_5.filters = ((_arg_4) ? [new DropShadowFilter(0, 0, 0)] : []);
        return (_local_5);
    }

    public static function returnYardUpgradeWindowBackground(_arg_1:uint, _arg_2:uint):PopupWindowBackground {
        var _local_3:PopupWindowBackground = new PopupWindowBackground();
        _local_3.draw(_arg_1, _arg_2);
        _local_3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 30);
        _local_3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 212);
        _local_3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 349);
        return (_local_3);
    }

    public static function returnEggHatchWindowBackground(_arg_1:uint, _arg_2:uint):PopupWindowBackground {
        var _local_3:PopupWindowBackground = new PopupWindowBackground();
        _local_3.draw(_arg_1, _arg_2);
        _local_3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 30);
        _local_3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 206);
        return (_local_3);
    }


}
}//package kabam.rotmg.pets.util
