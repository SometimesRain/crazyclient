package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.game.events.KeyInfoResponseSignal;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.util.BitmapUtil;
import com.company.util.KeyCodes;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.DropShadowFilter;
import flash.utils.Dictionary;

import kabam.rotmg.constants.ActivationType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.messaging.impl.data.StatData;
import kabam.rotmg.messaging.impl.incoming.KeyInfoResponse;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.model.HUDModel;

public class EquipmentToolTip extends ToolTip {

    private static const MAX_WIDTH:int = 230;

    public static var keyInfo:Dictionary = new Dictionary();
    private var icon:Bitmap;
    public var titleText:TextFieldDisplayConcrete;
    private var tierText:TextFieldDisplayConcrete;
    private var descText:TextFieldDisplayConcrete;
    private var line1:LineBreakDesign;
    private var effectsText:TextFieldDisplayConcrete;
    private var line2:LineBreakDesign;
    private var restrictionsText:TextFieldDisplayConcrete;
    private var player:Player;
    private var isEquippable:Boolean = false;
    private var objectType:int;
    private var titleOverride:String;
    private var descriptionOverride:String;
    private var curItemXML:XML = null;
    private var objectXML:XML = null;
    private var slotTypeToTextBuilder:SlotComparisonFactory;
    private var restrictions:Vector.<Restriction>;
    private var effects:Vector.<Effect>;
    private var uniqueEffects:Vector.<Effect>;
    private var itemSlotTypeId:int;
    private var invType:int;
    private var inventorySlotID:uint;
    private var inventoryOwnerType:String;
    private var isInventoryFull:Boolean;
    private var playerCanUse:Boolean;
    private var comparisonResults:SlotComparisonResult;
    private var powerText:TextFieldDisplayConcrete;
    private var keyInfoResponse:KeyInfoResponseSignal;
    private var originalObjectType:int;

    public function EquipmentToolTip(_arg_1:int, _arg_2:Player, _arg_3:int, _arg_4:String) {
        var _loc8_:HUDModel;
        this.uniqueEffects = new Vector.<Effect>();
        this.objectType = _arg_1;
        this.originalObjectType = this.objectType;
        this.player = _arg_2;
        this.invType = _arg_3;
        this.inventoryOwnerType = _arg_4;
        this.isInventoryFull = ((_arg_2) ? _arg_2.isInventoryFull() : false);
        if(this.objectType >= 0x9000 && this.objectType < 0xF000)
        {
            this.objectType = 0x8FFF;
        }
        this.playerCanUse = ((_arg_2) ? ObjectLibrary.isUsableByPlayer(this.objectType, _arg_2) : false);
        var _local_5:int = ((_arg_2) ? ObjectLibrary.getMatchingSlotIndex(this.objectType, _arg_2) : -1);
        var _local_6:uint = ((((this.playerCanUse) || ((this.player == null)))) ? 0x363636 : 0x5C1D1D);
        var _local_7:uint = ((((this.playerCanUse) || ((_arg_2 == null)))) ? 0x9B9B9B : 0xA7502F);
        super(_local_6, 1, _local_7, 1, true);
        this.slotTypeToTextBuilder = new SlotComparisonFactory();
        this.objectXML = ObjectLibrary.xmlLibrary_[this.objectType];
        this.isEquippable = !((_local_5 == -1));
        this.effects = new Vector.<Effect>();
        this.itemSlotTypeId = int(this.objectXML.SlotType);
        if (this.player == null) {
            this.curItemXML = this.objectXML;
        }
        else {
            if (this.isEquippable) {
                if (this.player.equipment_[_local_5] != -1) {
                    this.curItemXML = ObjectLibrary.xmlLibrary_[this.player.equipment_[_local_5]];
                }
            }
        }
        this.addIcon();
        if(this.originalObjectType >= 0x9000 && this.originalObjectType <= 0xF000)
        {
            if(keyInfo[this.originalObjectType] == null)
            {
                this.addTitle();
                this.addDescriptionText();
                this.keyInfoResponse = StaticInjectorContext.getInjector().getInstance(KeyInfoResponseSignal);
                this.keyInfoResponse.add(this.onKeyInfoResponse);
                _loc8_ = StaticInjectorContext.getInjector().getInstance(HUDModel);
                _loc8_.gameSprite.gsc_.keyInfoRequest(this.originalObjectType);
            }
            else
            {
                this.titleOverride = keyInfo[this.originalObjectType][0] + " Key";
                this.descriptionOverride = keyInfo[this.originalObjectType][1] + "\n" + "Created By: " + keyInfo[this.originalObjectType][2];
                this.addTitle();
                this.addDescriptionText();
            }
        }
        else
        {
            this.addTitle();
            this.addDescriptionText();
        }
        this.addTierText();
        this.handleWisMod();
        this.buildCategorySpecificText();
        this.addUniqueEffectsToList();
        this.addNumProjectilesTagsToEffectsList();
        this.addProjectileTagsToEffectsList();
        this.addActivateTagsToEffectsList();
        this.addActivateOnEquipTagsToEffectsList();
        this.addDoseTagsToEffectsList();
        this.addMpCostTagToEffectsList();
        this.addFameBonusTagToEffectsList();
        this.makeEffectsList();
        this.makeLineTwo();
        this.makeRestrictionList();
        this.makeRestrictionText();
        this.makeItemPowerText();
    }

    private function makeItemPowerText():void {
        var _local_1:int;
        if (this.objectXML.hasOwnProperty("feedPower")) {
            _local_1 = ((((this.playerCanUse) || ((this.player == null)))) ? 0xFFFFFF : 16549442);
            this.powerText = new TextFieldDisplayConcrete().setSize(12).setColor(_local_1).setBold(true).setTextWidth((((MAX_WIDTH - this.icon.width) - 4) - 30)).setWordWrap(true);
            this.powerText.setStringBuilder(new StaticStringBuilder().setString(("Feed Power: " + this.objectXML.feedPower)));
            this.powerText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            waiter.push(this.powerText.textChanged);
            addChild(this.powerText);
        }
    }

    private function onKeyInfoResponse(_arg_1:KeyInfoResponse):void
    {
        this.keyInfoResponse.remove(this.onKeyInfoResponse);
        this.removeTitle();
        this.removeDesc();
        this.titleOverride = _arg_1.name;
        this.descriptionOverride = _arg_1.description;
        keyInfo[this.originalObjectType] = [_arg_1.name, _arg_1.description, _arg_1.creator];
        this.addTitle();
        this.addDescriptionText();
    }

    private function addUniqueEffectsToList():void {
        var _local_1:XMLList;
        var _local_2:XML;
        var _local_3:String;
        var _local_4:String;
        var _local_5:String;
        var _local_6:AppendingLineBuilder;
        if (this.objectXML.hasOwnProperty("ExtraTooltipData")) {
            _local_1 = this.objectXML.ExtraTooltipData.EffectInfo;
            for each (_local_2 in _local_1) {
                _local_3 = _local_2.attribute("name");
                _local_4 = _local_2.attribute("description");
                _local_5 = ((((_local_3) && (_local_4))) ? ": " : "\n");
                _local_6 = new AppendingLineBuilder();
                if (_local_3) {
                    _local_6.pushParams(_local_3);
                }
                if (_local_4) {
                    _local_6.pushParams(_local_4, {}, TooltipHelper.getOpenTag(16777103), TooltipHelper.getCloseTag());
                }
                _local_6.setDelimiter(_local_5);
                this.uniqueEffects.push(new Effect(TextKey.BLANK, {"data": _local_6}));
            }
        }
    }

    private function isEmptyEquipSlot():Boolean {
        return (((this.isEquippable) && ((this.curItemXML == null))));
    }

    private function addIcon():void {
        var _local_1:XML = ObjectLibrary.xmlLibrary_[this.objectType];
        var _local_2:int = 5;
        if ((((this.objectType == 4874)) || ((this.objectType == 4618)))) {
            _local_2 = 8;
        }
        if (_local_1.hasOwnProperty("ScaleValue")) {
            _local_2 = _local_1.ScaleValue;
        }
        var _local_3:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.objectType, 60, true, true, _local_2);
        _local_3 = BitmapUtil.cropToBitmapData(_local_3, 4, 4, (_local_3.width - 8), (_local_3.height - 8));
        this.icon = new Bitmap(_local_3);
        addChild(this.icon);
    }

    private function addTierText():void {
        var _local_1:Boolean = (this.isPet() == false);
        var _local_2:Boolean = (this.objectXML.hasOwnProperty("Consumable") == false);
        var _local_3:Boolean = (this.objectXML.hasOwnProperty("Treasure") == false);
        var _local_4:Boolean = this.objectXML.hasOwnProperty("Tier");
        if (((((_local_1) && (_local_2))) && (_local_3))) {
            this.tierText = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(30).setBold(true);
            if (_local_4) {
                this.tierText.setStringBuilder(new LineBuilder().setParams(TextKey.TIER_ABBR, {"tier": this.objectXML.Tier}));
            }
            else {
                if (this.objectXML.hasOwnProperty("@setType")) {
                    this.tierText.setColor(0xFF9900);
                    this.tierText.setStringBuilder(new StaticStringBuilder("ST"));
                }
                else {
                    this.tierText.setColor(9055202);
                    this.tierText.setStringBuilder(new LineBuilder().setParams(TextKey.UNTIERED_ABBR));
                }
            }
            addChild(this.tierText);
        }
    }

    private function isPet():Boolean {
        var activateTags:XMLList;
        activateTags = this.objectXML.Activate.(text() == "PermaPet");
        return ((activateTags.length() >= 1));
    }

    private function removeTitle():void
    {
        removeChild(this.titleText);
    }

    private function removeDesc():void
    {
        removeChild(this.descText);
    }

    private function addTitle():void {
        var _local_1:int = ((((this.playerCanUse) || ((this.player == null)))) ? 0xFFFFFF : 16549442);
        this.titleText = new TextFieldDisplayConcrete().setSize(16).setColor(_local_1).setBold(true).setTextWidth((((MAX_WIDTH - this.icon.width) - 4) - 30)).setWordWrap(true);
        if(this.titleOverride)
        {
            this.titleText.setStringBuilder(new StaticStringBuilder(this.titleOverride));
        }
        else
        {
            this.titleText.setStringBuilder(new LineBuilder().setParams(ObjectLibrary.typeToDisplayId_[this.objectType]));
        }
        this.titleText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        waiter.push(this.titleText.textChanged);
        addChild(this.titleText);
    }

    private function buildUniqueTooltipData():String {
        var _local_1:XMLList;
        var _local_2:Vector.<Effect>;
        var _local_3:XML;
        if (this.objectXML.hasOwnProperty("ExtraTooltipData")) {
            _local_1 = this.objectXML.ExtraTooltipData.EffectInfo;
            _local_2 = new Vector.<Effect>();
            for each (_local_3 in _local_1) {
                _local_2.push(new Effect(_local_3.attribute("name"), _local_3.attribute("description")));
            }
        }
        return ("");
    }

    private function makeEffectsList():void {
        var _local_1:AppendingLineBuilder;
        if (((((!((this.effects.length == 0))) || (!((this.comparisonResults.lineBuilder == null))))) || (this.objectXML.hasOwnProperty("ExtraTooltipData")))) {
            this.line1 = new LineBreakDesign((MAX_WIDTH - 12), 0);
            this.effectsText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth(MAX_WIDTH).setWordWrap(true).setHTML(true);
            _local_1 = this.getEffectsStringBuilder();
            this.effectsText.setStringBuilder(_local_1);
            this.effectsText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            if (_local_1.hasLines()) {
                addChild(this.line1);
                addChild(this.effectsText);
            }
        }
    }

    private function getEffectsStringBuilder():AppendingLineBuilder {
        var _local_1:AppendingLineBuilder = new AppendingLineBuilder();
        this.appendEffects(this.uniqueEffects, _local_1);
        if (this.comparisonResults.lineBuilder.hasLines()) {
            _local_1.pushParams(TextKey.BLANK, {"data": this.comparisonResults.lineBuilder});
        }
        this.appendEffects(this.effects, _local_1);
        return (_local_1);
    }

    private function appendEffects(_arg_1:Vector.<Effect>, _arg_2:AppendingLineBuilder):void {
        var _local_3:Effect;
        var _local_4:String;
        var _local_5:String;
        for each (_local_3 in _arg_1) {
            _local_4 = "";
            _local_5 = "";
            if (_local_3.color_) {
                _local_4 = (('<font color="#' + _local_3.color_.toString(16)) + '">');
                _local_5 = "</font>";
            }
            _arg_2.pushParams(_local_3.name_, _local_3.getValueReplacementsWithColor(), _local_4, _local_5);
        }
    }

    private function addNumProjectilesTagsToEffectsList():void {
        if (((this.objectXML.hasOwnProperty("NumProjectiles")) && (!((this.comparisonResults.processedTags.hasOwnProperty(this.objectXML.NumProjectiles.toXMLString()) == true))))) {
            this.effects.push(new Effect(TextKey.SHOTS, {"numShots": this.objectXML.NumProjectiles}));
        }
    }

    private function addFameBonusTagToEffectsList():void {
        var _local_1:int;
        var _local_2:uint;
        var _local_3:int;
        if (this.objectXML.hasOwnProperty("FameBonus")) {
            _local_1 = int(this.objectXML.FameBonus);
            _local_2 = ((this.playerCanUse) ? TooltipHelper.BETTER_COLOR : TooltipHelper.NO_DIFF_COLOR);
            if (((!((this.curItemXML == null))) && (this.curItemXML.hasOwnProperty("FameBonus")))) {
                _local_3 = int(this.curItemXML.FameBonus.text());
                _local_2 = TooltipHelper.getTextColor((_local_1 - _local_3));
            }
            this.effects.push(new Effect(TextKey.FAME_BONUS, {"percent": (this.objectXML.FameBonus + "%")}).setReplacementsColor(_local_2));
        }
    }

    private function addMpCostTagToEffectsList():void {
        if (this.objectXML.hasOwnProperty("MpEndCost")) {
            if (!this.comparisonResults.processedTags[this.objectXML.MpEndCost[0].toXMLString()]) {
                this.effects.push(new Effect(TextKey.MP_COST, {"cost": this.objectXML.MpEndCost}));
            }
        }
        else {
            if (((this.objectXML.hasOwnProperty("MpCost")) && (!(this.comparisonResults.processedTags[this.objectXML.MpCost[0].toXMLString()])))) {
                if (!this.comparisonResults.processedTags[this.objectXML.MpCost[0].toXMLString()]) {
                    this.effects.push(new Effect(TextKey.MP_COST, {"cost": this.objectXML.MpCost}));
                }
            }
        }
    }

    private function addDoseTagsToEffectsList():void {
        if (this.objectXML.hasOwnProperty("Doses")) {
            this.effects.push(new Effect(TextKey.DOSES, {"dose": this.objectXML.Doses}));
        }
        if(this.objectXML.hasOwnProperty("Quantity"))
        {
            this.effects.push(new Effect("Quantity: {quantity}",{"quantity": this.objectXML.Quantity}));
        }
    }

    private function addProjectileTagsToEffectsList():void {
        var _local_1:XML;
        var _local_2:int;
        var _local_3:int;
        var _local_4:Number;
        var _local_5:XML;
        if (((this.objectXML.hasOwnProperty("Projectile")) && (!(this.comparisonResults.processedTags.hasOwnProperty(this.objectXML.Projectile.toXMLString()))))) {
            _local_1 = XML(this.objectXML.Projectile);
            _local_2 = int(_local_1.MinDamage);
            _local_3 = int(_local_1.MaxDamage);
            this.effects.push(new Effect(TextKey.DAMAGE, {"damage": (((_local_2 == _local_3)) ? _local_2 : ((_local_2 + " - ") + _local_3)).toString()}));
            _local_4 = ((Number(_local_1.Speed) * Number(_local_1.LifetimeMS)) / 10000);
            this.effects.push(new Effect(TextKey.RANGE, {"range": TooltipHelper.getFormattedRangeString(_local_4)}));
            if (this.objectXML.Projectile.hasOwnProperty("MultiHit")) {
                this.effects.push(new Effect(TextKey.MULTIHIT, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
            if (this.objectXML.Projectile.hasOwnProperty("PassesCover")) {
                this.effects.push(new Effect(TextKey.PASSES_COVER, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
            if (this.objectXML.Projectile.hasOwnProperty("ArmorPiercing")) {
                this.effects.push(new Effect(TextKey.ARMOR_PIERCING, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
            for each (_local_5 in _local_1.ConditionEffect) {
                if (this.comparisonResults.processedTags[_local_5.toXMLString()] == null) {
                    this.effects.push(new Effect(TextKey.SHOT_EFFECT, {"effect": ""}));
                    this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                        "effect": this.objectXML.Projectile.ConditionEffect,
                        "duration": this.objectXML.Projectile.ConditionEffect.@duration
                    }).setColor(TooltipHelper.NO_DIFF_COLOR));
                }
            }
        }
    }

    private function addActivateTagsToEffectsList():void {
        var _local_1:XML;
        var _local_2:String;
        var _local_3:int;
        var _local_4:int;
        var _local_5:String;
        var _local_6:String;
        var _local_7:Object;
        var _local_8:String;
        var _local_9:uint;
        var _local_10:XML;
        var _local_11:Object;
        var _local_12:String;
        var _local_13:uint;
        var _local_14:XML;
        var _local_15:String;
        var _local_16:Object;
        var _local_17:String;
        var _local_18:Object;
        var _local_19:Number;
        var _local_20:Number;
        var _local_21:Number;
        var _local_22:Number;
        var _local_23:Number;
        var _local_24:Number;
        var _local_25:Number;
        var _local_26:Number;
        var _local_27:Number;
        var _local_28:Number;
        var _local_29:Number;
        var _local_30:Number;
        var _local_31:AppendingLineBuilder;
        for each (_local_1 in this.objectXML.Activate) {
            _local_5 = this.comparisonResults.processedTags[_local_1.toXMLString()];
            if (this.comparisonResults.processedTags[_local_1.toXMLString()] != true) {
                _local_6 = _local_1.toString();
                switch (_local_6) {
                    case ActivationType.COND_EFFECT_AURA:
                        this.effects.push(new Effect(TextKey.PARTY_EFFECT, {"effect": new AppendingLineBuilder().pushParams(TextKey.WITHIN_SQRS, {"range": _local_1.@range}, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                        this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                            "effect": _local_1.@effect,
                            "duration": _local_1.@duration
                        }).setColor(TooltipHelper.NO_DIFF_COLOR));
                        break;
                    case ActivationType.COND_EFFECT_SELF:
                        this.effects.push(new Effect(TextKey.EFFECT_ON_SELF, {"effect": ""}));
                        this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                            "effect": _local_1.@effect,
                            "duration": _local_1.@duration
                        }));
                        break;
                    case ActivationType.HEAL:
                        this.effects.push(new Effect(TextKey.INCREMENT_STAT, {
                            "statAmount": (("+" + _local_1.@amount) + " "),
                            "statName": new LineBuilder().setParams(TextKey.STATUS_BAR_HEALTH_POINTS)
                        }));
                        break;
                    case ActivationType.HEAL_NOVA:
                        this.effects.push(new Effect(TextKey.PARTY_HEAL, {
                            "effect": new AppendingLineBuilder().pushParams(TextKey.HP_WITHIN_SQRS, {
                                "amount": _local_1.@amount,
                                "range": _local_1.@range
                            }, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())
                        }));
                        break;
                    case ActivationType.MAGIC:
                        this.effects.push(new Effect(TextKey.INCREMENT_STAT, {
                            "statAmount": (("+" + _local_1.@amount) + " "),
                            "statName": new LineBuilder().setParams(TextKey.STATUS_BAR_MANA_POINTS)
                        }));
                        break;
                    case ActivationType.MAGIC_NOVA:
                        this.effects.push(new Effect(TextKey.FILL_PARTY_MAGIC, (((_local_1.@amount + " MP at ") + _local_1.@range) + " sqrs")));
                        break;
                    case ActivationType.TELEPORT:
                        this.effects.push(new Effect(TextKey.BLANK, {"data": new LineBuilder().setParams(TextKey.TELEPORT_TO_TARGET)}));
                        break;
                    case ActivationType.VAMPIRE_BLAST:
                        this.effects.push(new Effect(TextKey.STEAL, {
                            "effect": new AppendingLineBuilder().pushParams(TextKey.HP_WITHIN_SQRS, {
                                "amount": _local_1.@totalDamage,
                                "range": _local_1.@radius
                            }, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())
                        }));
                        break;
                    case ActivationType.TRAP:
                        _local_7 = ((_local_1.hasOwnProperty("@condEffect")) ? _local_1.@condEffect : new LineBuilder().setParams(TextKey.CONDITION_EFFECT_SLOWED));
                        _local_8 = ((_local_1.hasOwnProperty("@condDuration")) ? _local_1.@condDuration : "5");
                        this.effects.push(new Effect(TextKey.TRAP, {
                            "data": new AppendingLineBuilder().pushParams(TextKey.HP_WITHIN_SQRS, {
                                "amount": _local_1.@totalDamage,
                                "range": _local_1.@radius
                            }, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag()).pushParams(TextKey.EFFECT_FOR_DURATION, {
                                "effect": _local_7,
                                "duration": _local_8
                            }, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())
                        }));
                        break;
                    case ActivationType.STASIS_BLAST:
                        this.effects.push(new Effect(TextKey.STASIS_GROUP, {"stasis": new AppendingLineBuilder().pushParams(TextKey.SEC_COUNT, {"duration": _local_1.@duration}, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                        break;
                    case ActivationType.DECOY:
                        this.effects.push(new Effect(TextKey.DECOY, {"data": new AppendingLineBuilder().pushParams(TextKey.SEC_COUNT, {"duration": _local_1.@duration}, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                        break;
                    case ActivationType.LIGHTNING:
                        this.effects.push(new Effect(TextKey.LIGHTNING, {
                            "data": new AppendingLineBuilder().pushParams(TextKey.DAMAGE_TO_TARGETS, {
                                "damage": _local_1.@totalDamage,
                                "targets": _local_1.@maxTargets
                            }, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())
                        }));
                        break;
                    case ActivationType.POISON_GRENADE:
                        this.effects.push(new Effect(TextKey.POISON_GRENADE, {"data": ""}));
                        this.effects.push(new Effect(TextKey.POISON_GRENADE_DATA, {
                            "damage": _local_1.@totalDamage,
                            "duration": _local_1.@duration,
                            "radius": _local_1.@radius
                        }).setColor(TooltipHelper.NO_DIFF_COLOR));
                        break;
                    case ActivationType.REMOVE_NEG_COND:
                        this.effects.push(new Effect(TextKey.REMOVES_NEGATIVE, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
                        break;
                    case ActivationType.REMOVE_NEG_COND_SELF:
                        this.effects.push(new Effect(TextKey.REMOVES_NEGATIVE, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
                        break;
                    case ActivationType.GENERIC_ACTIVATE:
                        _local_9 = 16777103;
                        if (this.curItemXML != null) {
                            _local_10 = this.getEffectTag(this.curItemXML, _local_1.@effect);
                            if (_local_10 != null) {
                                _local_19 = Number(_local_1.@range);
                                _local_20 = Number(_local_10.@range);
                                _local_21 = Number(_local_1.@duration);
                                _local_22 = Number(_local_10.@duration);
                                _local_23 = ((_local_19 - _local_20) + (_local_21 - _local_22));
                                if (_local_23 > 0) {
                                    _local_9 = 0xFF00;
                                }
                                else {
                                    if (_local_23 < 0) {
                                        _local_9 = 0xFF0000;
                                    }
                                }
                            }
                        }
                        _local_11 = {
                            "range": _local_1.@range,
                            "effect": _local_1.@effect,
                            "duration": _local_1.@duration
                        };
                        _local_12 = "Within {range} sqrs {effect} for {duration} seconds";
                        if (_local_1.@target != "enemy") {
                            this.effects.push(new Effect(TextKey.PARTY_EFFECT, {"effect": LineBuilder.returnStringReplace(_local_12, _local_11)}).setReplacementsColor(_local_9));
                        }
                        else {
                            this.effects.push(new Effect(TextKey.ENEMY_EFFECT, {"effect": LineBuilder.returnStringReplace(_local_12, _local_11)}).setReplacementsColor(_local_9));
                        }
                        break;
                    case ActivationType.STAT_BOOST_AURA:
                        _local_13 = 0xFFFF8F;
                        if (this.curItemXML != null) {
                            _local_14 = this.getStatTag(this.curItemXML, _local_1.@stat);
                            if (_local_14 != null) {
                                _local_24 = Number(_local_1.@range);
                                _local_25 = Number(_local_14.@range);
                                _local_26 = Number(_local_1.@duration);
                                _local_27 = Number(_local_14.@duration);
                                _local_28 = Number(_local_1.@amount);
                                _local_29 = Number(_local_14.@amount);
                                _local_30 = (((_local_24 - _local_25) + (_local_26 - _local_27)) + (_local_28 - _local_29));
                                if (_local_30 > 0) {
                                    _local_13 = 0xFF00;
                                }
                                else {
                                    if (_local_30 < 0) {
                                        _local_13 = 0xFF0000;
                                    }
                                }
                            }
                        }
                        _local_3 = int(_local_1.@stat);
                        _local_15 = LineBuilder.getLocalizedString2(StatData.statToName(_local_3));
                        _local_16 = {
                            "range": _local_1.@range,
                            "stat": _local_15,
                            "amount": _local_1.@amount,
                            "duration": _local_1.@duration
                        };
                        _local_17 = "Within {range} sqrs increase {stat} by {amount} for {duration} seconds";
                        this.effects.push(new Effect(TextKey.PARTY_EFFECT, {"effect": LineBuilder.returnStringReplace(_local_17, _local_16)}).setReplacementsColor(_local_13));
                        break;
                    case ActivationType.INCREMENT_STAT:
                        _local_3 = int(_local_1.@stat);
                        _local_4 = int(_local_1.@amount);
                        _local_18 = {};
                        if (((!((_local_3 == StatData.HP_STAT))) && (!((_local_3 == StatData.MP_STAT))))) {
                            _local_2 = TextKey.PERMANENTLY_INCREASES;
                            _local_18["statName"] = new LineBuilder().setParams(StatData.statToName(_local_3));
                            this.effects.push(new Effect(_local_2, _local_18).setColor(16777103));
                            break;
                        }
                        _local_2 = TextKey.BLANK;
                        _local_31 = new AppendingLineBuilder().setDelimiter(" ");
                        _local_31.pushParams(TextKey.BLANK, {"data": new StaticStringBuilder(("+" + _local_4))});
                        _local_31.pushParams(StatData.statToName(_local_3));
                        _local_18["data"] = _local_31;
                        this.effects.push(new Effect(_local_2, _local_18));
                        break;
                }
            }
        }
    }

    private function getEffectTag(xml:XML, effectValue:String):XML {
        var matches:XMLList;
        var tag:XML;
        matches = xml.Activate.(text() == ActivationType.GENERIC_ACTIVATE);
        for each (tag in matches) {
            if (tag.@effect == effectValue) {
                return (tag);
            }
        }
        return (null);
    }

    private function getStatTag(xml:XML, statValue:String):XML {
        var matches:XMLList;
        var tag:XML;
        matches = xml.Activate.(text() == ActivationType.STAT_BOOST_AURA);
        for each (tag in matches) {
            if (tag.@stat == statValue) {
                return (tag);
            }
        }
        return (null);
    }

    private function addActivateOnEquipTagsToEffectsList():void {
        var _local_1:XML;
        var _local_2:Boolean = true;
        for each (_local_1 in this.objectXML.ActivateOnEquip) {
            if (_local_2) {
                this.effects.push(new Effect(TextKey.ON_EQUIP, ""));
                _local_2 = false;
            }
            if (_local_1.toString() == "IncrementStat") {
                this.effects.push(new Effect(TextKey.INCREMENT_STAT, this.getComparedStatText(_local_1)).setReplacementsColor(this.getComparedStatColor(_local_1)));
            }
        }
    }

    private function getComparedStatText(_arg_1:XML):Object {
        var _local_2:int = int(_arg_1.@stat);
        var _local_3:int = int(_arg_1.@amount);
        var _local_4:String = (((_local_3) > -1) ? "+" : "");
        return ({
            "statAmount": ((_local_4 + String(_local_3)) + " "),
            "statName": new LineBuilder().setParams(StatData.statToName(_local_2))
        });
    }

    private function getComparedStatColor(activateXML:XML):uint {
        var match:XML;
        var otherAmount:int;
        var stat:int = int(activateXML.@stat);
        var amount:int = int(activateXML.@amount);
        var textColor:uint = ((this.playerCanUse) ? TooltipHelper.BETTER_COLOR : TooltipHelper.NO_DIFF_COLOR);
        var otherMatches:XMLList;
        if (this.curItemXML != null) {
            otherMatches = this.curItemXML.ActivateOnEquip.(@stat == stat);
        }
        if (((!((otherMatches == null))) && ((otherMatches.length() == 1)))) {
            match = XML(otherMatches[0]);
            otherAmount = int(match.@amount);
            textColor = TooltipHelper.getTextColor((amount - otherAmount));
        }
        if (amount < 0) {
            textColor = 0xFF0000;
        }
        return (textColor);
    }

    private function addEquipmentItemRestrictions():void {
        if (this.objectXML.hasOwnProperty("Treasure") == false) {
            this.restrictions.push(new Restriction(TextKey.EQUIP_TO_USE, 0xB3B3B3, false));
            if (((this.isInventoryFull) || ((this.inventoryOwnerType == InventoryOwnerTypes.CURRENT_PLAYER)))) {
                this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_EQUIP, 0xB3B3B3, false));
            }
            else {
                this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_TAKE, 0xB3B3B3, false));
            }
        }
    }

    private function addAbilityItemRestrictions():void {
        this.restrictions.push(new Restriction(TextKey.KEYCODE_TO_USE, 0xFFFFFF, false));
    }

    private function addConsumableItemRestrictions():void {
        this.restrictions.push(new Restriction(TextKey.CONSUMED_WITH_USE, 0xB3B3B3, false));
        if (((this.isInventoryFull) || ((this.inventoryOwnerType == InventoryOwnerTypes.CURRENT_PLAYER)))) {
            this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_OR_SHIFT_CLICK_TO_USE, 0xFFFFFF, false));
        }
        else {
            this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_TAKE_SHIFT_CLICK_USE, 0xFFFFFF, false));
        }
    }

    private function addReusableItemRestrictions():void {
        this.restrictions.push(new Restriction(TextKey.CAN_BE_USED_MULTIPLE_TIMES, 0xB3B3B3, false));
        this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_OR_SHIFT_CLICK_TO_USE, 0xFFFFFF, false));
    }

    private function makeRestrictionList():void {
        var _local_2:XML;
        var _local_3:Boolean;
        var _local_4:int;
        var _local_5:int;
        this.restrictions = new Vector.<Restriction>();
        if (((((this.objectXML.hasOwnProperty("VaultItem")) && (!((this.invType == -1))))) && (!((this.invType == ObjectLibrary.idToType_["Vault Chest"]))))) {
            this.restrictions.push(new Restriction(TextKey.STORE_IN_VAULT, 16549442, true));
        }
        if (this.objectXML.hasOwnProperty("Soulbound")) {
            this.restrictions.push(new Restriction(TextKey.ITEM_SOULBOUND, 0xB3B3B3, false));
        }
        if (this.objectXML.hasOwnProperty("@setType")) {
            this.restrictions.push(new Restriction(("This item is a part of " + this.objectXML.attribute("setName")), 0xFF9900, false));
        }
        if (this.playerCanUse) {
            if (this.objectXML.hasOwnProperty("Usable")) {
                this.addAbilityItemRestrictions();
                this.addEquipmentItemRestrictions();
            }
            else {
                if (this.objectXML.hasOwnProperty("Consumable")) {
                    this.addConsumableItemRestrictions();
                }
                else {
                    if (this.objectXML.hasOwnProperty("InvUse")) {
                        this.addReusableItemRestrictions();
                    }
                    else {
                        this.addEquipmentItemRestrictions();
                    }
                }
            }
        }
        else {
            if (this.player != null) {
                this.restrictions.push(new Restriction(TextKey.NOT_USABLE_BY, 16549442, true));
            }
        }
        var _local_1:Vector.<String> = ObjectLibrary.usableBy(this.objectType);
        if (_local_1 != null) {
            this.restrictions.push(new Restriction(TextKey.USABLE_BY, 0xB3B3B3, false));
        }
        for each (_local_2 in this.objectXML.EquipRequirement) {
            _local_3 = ObjectLibrary.playerMeetsRequirement(_local_2, this.player);
            if (_local_2.toString() == "Stat") {
                _local_4 = int(_local_2.@stat);
                _local_5 = int(_local_2.@value);
                this.restrictions.push(new Restriction(((("Requires " + StatData.statToName(_local_4)) + " of ") + _local_5), ((_local_3) ? 0xB3B3B3 : 16549442), ((_local_3) ? false : true)));
            }
        }
    }

    private function makeLineTwo():void {
        this.line2 = new LineBreakDesign((MAX_WIDTH - 12), 0);
        addChild(this.line2);
    }

    private function makeRestrictionText():void {
        if (this.restrictions.length != 0) {
            this.restrictionsText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth((MAX_WIDTH - 4)).setIndent(-10).setLeftMargin(10).setWordWrap(true).setHTML(true);
            this.restrictionsText.setStringBuilder(this.buildRestrictionsLineBuilder());
            this.restrictionsText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            waiter.push(this.restrictionsText.textChanged);
            addChild(this.restrictionsText);
        }
    }

    private function buildRestrictionsLineBuilder():StringBuilder {
        var _local_2:Restriction;
        var _local_3:String;
        var _local_4:String;
        var _local_5:String;
        var _local_1:AppendingLineBuilder = new AppendingLineBuilder();
        for each (_local_2 in this.restrictions) {
            _local_3 = ((_local_2.bold_) ? "<b>" : "");
            _local_3 = _local_3.concat((('<font color="#' + _local_2.color_.toString(16)) + '">'));
            _local_4 = "</font>";
            _local_4 = _local_4.concat(((_local_2.bold_) ? "</b>" : ""));
            _local_5 = ((this.player) ? ObjectLibrary.typeToDisplayId_[this.player.objectType_] : "");
            _local_1.pushParams(_local_2.text_, {
                "unUsableClass": _local_5,
                "usableClasses": this.getUsableClasses(),
                "keyCode": KeyCodes.CharCodeStrings[Parameters.data_.useSpecial]
            }, _local_3, _local_4);
        }
        return (_local_1);
    }

    private function getUsableClasses():StringBuilder {
        var _local_3:String;
        var _local_1:Vector.<String> = ObjectLibrary.usableBy(this.objectType);
        var _local_2:AppendingLineBuilder = new AppendingLineBuilder();
        _local_2.setDelimiter(", ");
        for each (_local_3 in _local_1) {
            _local_2.pushParams(_local_3);
        }
        return (_local_2);
    }

    private function addDescriptionText():void {
        this.descText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth(MAX_WIDTH).setWordWrap(true);
        if(this.descriptionOverride)
        {
            this.descText.setStringBuilder(new StaticStringBuilder(this.descriptionOverride));
        }
        else
        {
            this.descText.setStringBuilder(new LineBuilder().setParams(String(this.objectXML.Description)));
        }
        this.descText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        waiter.push(this.descText.textChanged);
        addChild(this.descText);
    }

    override protected function alignUI():void {
        this.titleText.x = (this.icon.width + 4);
        this.titleText.y = ((this.icon.height / 2) - (this.titleText.height / 2));
        if (this.tierText) {
            this.tierText.y = ((this.icon.height / 2) - (this.tierText.height / 2));
            this.tierText.x = (MAX_WIDTH - 30);
        }
        this.descText.x = 4;
        this.descText.y = (this.icon.height + 2);
        if (contains(this.line1)) {
            this.line1.x = 8;
            this.line1.y = ((this.descText.y + this.descText.height) + 8);
            this.effectsText.x = 4;
            this.effectsText.y = (this.line1.y + 8);
        }
        else {
            this.line1.y = (this.descText.y + this.descText.height);
            this.effectsText.y = this.line1.y;
        }
        this.line2.x = 8;
        this.line2.y = ((this.effectsText.y + this.effectsText.height) + 8);
        var _local_1:uint = (this.line2.y + 8);
        if (this.restrictionsText) {
            this.restrictionsText.x = 4;
            this.restrictionsText.y = _local_1;
            _local_1 = (_local_1 + this.restrictionsText.height);
        }
        if (this.powerText) {
            if (contains(this.powerText)) {
                this.powerText.x = 4;
                this.powerText.y = _local_1;
            }
        }
    }

    private function buildCategorySpecificText():void {
        if (this.curItemXML != null) {
            this.comparisonResults = this.slotTypeToTextBuilder.getComparisonResults(this.objectXML, this.curItemXML);
        }
        else {
            this.comparisonResults = new SlotComparisonResult();
        }
    }

    private function handleWisMod():void {
        var _local_3:XML;
        var _local_4:XML;
        var _local_5:String;
        var _local_6:String;
        if (this.player == null) {
            return;
        }
        var _local_1:Number = (this.player.wisdom_ + this.player.wisdomBoost_);
        if (_local_1 < 30) {
            return;
        }
        var _local_2:Vector.<XML> = new Vector.<XML>();
        if (this.curItemXML != null) {
            this.curItemXML = this.curItemXML.copy();
            _local_2.push(this.curItemXML);
        }
        if (this.objectXML != null) {
            this.objectXML = this.objectXML.copy();
            _local_2.push(this.objectXML);
        }
        for each (_local_4 in _local_2) {
            for each (_local_3 in _local_4.Activate) {
                _local_5 = _local_3.toString();
                if (_local_3.@effect != "Stasis") {
                    _local_6 = _local_3.@useWisMod;
                    if (!(((((((_local_6 == "")) || ((_local_6 == "false")))) || ((_local_6 == "0")))) || ((_local_3.@effect == "Stasis")))) {
                        switch (_local_5) {
                            case ActivationType.HEAL_NOVA:
                                _local_3.@amount = this.modifyWisModStat(_local_3.@amount, 0);
                                _local_3.@range = this.modifyWisModStat(_local_3.@range);
                                break;
                            case ActivationType.COND_EFFECT_AURA:
                                _local_3.@duration = this.modifyWisModStat(_local_3.@duration);
                                _local_3.@range = this.modifyWisModStat(_local_3.@range);
                                break;
                            case ActivationType.COND_EFFECT_SELF:
                                _local_3.@duration = this.modifyWisModStat(_local_3.@duration);
                                break;
                            case ActivationType.STAT_BOOST_AURA:
                                _local_3.@amount = this.modifyWisModStat(_local_3.@amount, 0);
                                _local_3.@duration = this.modifyWisModStat(_local_3.@duration);
                                _local_3.@range = this.modifyWisModStat(_local_3.@range);
                                break;
                            case ActivationType.GENERIC_ACTIVATE:
                                _local_3.@duration = this.modifyWisModStat(_local_3.@duration);
                                _local_3.@range = this.modifyWisModStat(_local_3.@range);
                                break;
                        }
                    }
                }
            }
        }
    }

    private function modifyWisModStat(input:String, expo:Number = 1):String {
        var toBeModiefied:Number;
        var posOrNeg:int;
        var _local_7:Number;
        var stringVal:String = "-1";
        var totalWis:Number = (this.player.wisdom_ + this.player.wisdomBoost_);
        if (totalWis < 30) { //no modification
            stringVal = input;
        }
        else {
            toBeModiefied = Number(input);
            posOrNeg = (((toBeModiefied) < 0) ? -1 : 1);
            _local_7 = (((toBeModiefied * totalWis) / 150) + (toBeModiefied * posOrNeg)); //formula
            _local_7 = (Math.floor((_local_7 * Math.pow(10, expo))) / Math.pow(10, expo)); //set decimals NICE JOB KABAM
            if ((_local_7 - int(_local_7) * posOrNeg) >= ((1 / Math.pow(10, expo)) * posOrNeg)) {
                stringVal = _local_7.toFixed(1);
            }
            else {
                stringVal = _local_7.toFixed(0);
            }
        }
        return (stringVal);
    }


}
}//package com.company.assembleegameclient.ui.tooltip

import com.adobe.errors.IllegalStateError;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

class Effect {

    public var name_:String;
    public var valueReplacements_:Object;
    public var replacementColor_:uint = 16777103;
    public var color_:uint = 0xB3B3B3;

    public function Effect(_arg_1:String, _arg_2:Object) {
        this.name_ = _arg_1;
        this.valueReplacements_ = _arg_2;
    }

    public function setColor(_arg_1:uint):Effect {
        this.color_ = _arg_1;
        return (this);
    }

    public function setReplacementsColor(_arg_1:uint):Effect {
        this.replacementColor_ = _arg_1;
        return (this);
    }

    public function getValueReplacementsWithColor():Object {
        var _local_4:String;
        var _local_5:LineBuilder;
        var _local_1:Object = {};
        var _local_2:String = "";
        var _local_3:String = "";
        if (this.replacementColor_) {
            _local_2 = (('</font><font color="#' + this.replacementColor_.toString(16)) + '">');
            _local_3 = (('</font><font color="#' + this.color_.toString(16)) + '">');
        }
        for (_local_4 in this.valueReplacements_) {
            if ((this.valueReplacements_[_local_4] is AppendingLineBuilder)) {
                _local_1[_local_4] = this.valueReplacements_[_local_4];
            }
            else {
                if ((this.valueReplacements_[_local_4] is LineBuilder)) {
                    _local_5 = (this.valueReplacements_[_local_4] as LineBuilder);
                    _local_5.setPrefix(_local_2).setPostfix(_local_3);
                    _local_1[_local_4] = _local_5;
                }
                else {
                    _local_1[_local_4] = ((_local_2 + this.valueReplacements_[_local_4]) + _local_3);
                }
            }
        }
        return (_local_1);
    }


}
class Restriction {

    public var text_:String;
    public var color_:uint;
    public var bold_:Boolean;

    public function Restriction(_arg_1:String, _arg_2:uint, _arg_3:Boolean) {
        this.text_ = _arg_1;
        this.color_ = _arg_2;
        this.bold_ = _arg_3;
    }

}
