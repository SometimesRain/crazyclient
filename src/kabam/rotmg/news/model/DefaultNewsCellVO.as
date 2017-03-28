package kabam.rotmg.news.model {
public class DefaultNewsCellVO extends NewsCellVO {

    public function DefaultNewsCellVO(_arg_1:int) {
        imageURL = "";
        linkDetail = "https://www.reddit.com/r/RotMG/search?sort=new&restrict_sr=on&q=flair%3AOfficial%2BDeca";
        headline = _arg_1 == 0 ? "Official Deca Posts on Reddit" : "Deca on Reddit";
        startDate = (new Date().getTime() - 0x3B9ACA00);
        endDate = (new Date().getTime() + 0x3B9ACA00);
        networks = ["kabam.com", "kongregate", "steam", "rotmg"];
        linkType = NewsCellLinkType.OPENS_LINK;
        priority = 999999;
        slot = _arg_1;
    }

}
}//package kabam.rotmg.news.model
