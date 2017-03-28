package com.company.assembleegameclient.util.offer {
public class Offers {

    private static const BEST_DEAL:String = "(Best deal)";
    private static const MOST_POPULAR:String = "(Most popular)";

    public var tok:String;
    public var exp:String;
    public var offerList:Vector.<Offer>;

    public function Offers(_arg_1:XML) {
        this.tok = _arg_1.Tok;
        this.exp = _arg_1.Exp;
        this.makeOffers(_arg_1);
    }

    private function makeOffers(_arg_1:XML):void {
        this.makeOfferList(_arg_1);
        this.sortOfferList();
        this.defineBonuses();
        this.defineMostPopularTagline();
        this.defineBestDealTagline();
    }

    private function makeOfferList(_arg_1:XML):void {
        var _local_2:XML;
        this.offerList = new Vector.<Offer>(0);
        for each (_local_2 in _arg_1.Offer) {
            this.offerList.push(this.makeOffer(_local_2));
        }
    }

    private function makeOffer(_arg_1:XML):Offer {
        var _local_2:String = _arg_1.Id;
        var _local_3:Number = Number(_arg_1.Price);
        var _local_4:int = int(_arg_1.RealmGold);
        var _local_5:String = _arg_1.CheckoutJWT;
        var _local_6:String = _arg_1.Data;
        var _local_7:String = ((_arg_1.hasOwnProperty("Currency")) ? _arg_1.Currency : null);
        return (new Offer(_local_2, _local_3, _local_4, _local_5, _local_6, _local_7));
    }

    private function sortOfferList():void {
        this.offerList.sort(this.sortOffers);
    }

    private function defineBonuses():void {
        var _local_5:int;
        var _local_6:int;
        var _local_7:Number;
        var _local_8:Number;
        if (this.offerList.length == 0) {
            return;
        }
        var _local_1:int = this.offerList[0].realmGold_;
        var _local_2:int = this.offerList[0].price_;
        var _local_3:Number = (_local_1 / _local_2);
        var _local_4:int = 1;
        while (_local_4 < this.offerList.length) {
            _local_5 = this.offerList[_local_4].realmGold_;
            _local_6 = this.offerList[_local_4].price_;
            _local_7 = (_local_6 * _local_3);
            _local_8 = (_local_5 - _local_7);
            this.offerList[_local_4].bonus = (_local_8 / _local_6);
            _local_4++;
        }
    }

    private function sortOffers(_arg_1:Offer, _arg_2:Offer):int {
        return ((_arg_1.price_ - _arg_2.price_));
    }

    private function defineMostPopularTagline():void {
        var _local_1:Offer;
        for each (_local_1 in this.offerList) {
            if (_local_1.price_ == 10) {
                _local_1.tagline = MOST_POPULAR;
            }
        }
    }

    private function defineBestDealTagline():void {
        this.offerList[(this.offerList.length - 1)].tagline = BEST_DEAL;
    }


}
}//package com.company.assembleegameclient.util.offer
