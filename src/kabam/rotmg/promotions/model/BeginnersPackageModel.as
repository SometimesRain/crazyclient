package kabam.rotmg.promotions.model {
import com.company.assembleegameclient.util.TimeUtil;
import com.company.assembleegameclient.util.offer.Offer;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.model.OfferModel;

import org.osflash.signals.Signal;

public class BeginnersPackageModel {

    private static const REALM_GOLD_FOR_BEGINNERS_PKG:int = 2600;
    private static const ONE_WEEK_IN_SECONDS:int = 604800;

    [Inject]
    public var account:Account;
    [Inject]
    public var model:OfferModel;
    public var markedAsPurchased:Signal;
    private var beginnersOfferSecondsLeft:Number;
    private var beginnersOfferSetTimestamp:Number;

    public function BeginnersPackageModel() {
        this.markedAsPurchased = new Signal();
        super();
    }

    public function isBeginnerAvailable():Boolean {
        return ((this.getBeginnersOfferSecondsLeft() > 0));
    }

    public function setBeginnersOfferSecondsLeft(_arg_1:Number):void {
        this.beginnersOfferSecondsLeft = _arg_1;
        this.beginnersOfferSetTimestamp = this.getNowTimeSeconds();
    }

    private function getNowTimeSeconds():Number {
        var _local_1:Date = new Date();
        return (Math.round((_local_1.time * 0.001)));
    }

    public function getBeginnersOfferSecondsLeft():Number {
        return ((this.beginnersOfferSecondsLeft - (this.getNowTimeSeconds() - this.beginnersOfferSetTimestamp)));
    }

    public function getUserCreatedAt():Number {
        return (((this.getNowTimeSeconds() + this.getBeginnersOfferSecondsLeft()) - ONE_WEEK_IN_SECONDS));
    }

    public function getDaysRemaining():Number {
        return (Math.ceil(TimeUtil.secondsToDays(this.getBeginnersOfferSecondsLeft())));
    }

    public function getOffer():Offer {
        var _local_1:Offer;
        if (!this.model.offers) {
            return (null);
        }
        for each (_local_1 in this.model.offers.offerList) {
            if (_local_1.realmGold_ == REALM_GOLD_FOR_BEGINNERS_PKG) {
                return (_local_1);
            }
        }
        return (null);
    }

    public function markAsPurchased():void {
        this.setBeginnersOfferSecondsLeft(-1);
        this.markedAsPurchased.dispatch();
    }


}
}//package kabam.rotmg.promotions.model
