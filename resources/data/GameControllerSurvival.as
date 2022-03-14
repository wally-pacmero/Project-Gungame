package §_-V2§
{
   import §_-Xl§.§_-If§;
   import §_-Zb§.§_-V5§;
   import boots.§_-RA§;
   import events.§_-QV§;
   import flash.utils.setTimeout;
   import weapons.WD_P1;
   import weapons.§_-3B§;
   
   public class GameControllerSurvival extends §_-9M§
   {
      
      public static var $title1:String = "Survival";
      
      public static var $title2:String = "Free For All";
      
      public static var $shortDescription1:String = "Continuous game";
      
      public static var $shortDescription2:String = "Get money for:\nKills";
      
      public static var $longDescription:String = "Survive for as long as you can. When you die you must start again with nothing, and your killer gains half of your score. Team up with other players if you think you can trust them.";
      
      public static var $active = true;
      
      public static var $tinyDescription:String = "Survival";
       
      
      private var §_-ez§:Number = 2;
      
      public function GameControllerSurvival(param1:§_-LU§, param2:§_-If§, param3:Array, param4:§_-5S§, param5:Boolean)
      {
         super(param1,param2,param3,param4,param5);
         §_-FJ§ = 300;
         §_-h9§ = 0;
         §_-S2§.§_-ei§.§_-QO§ = true;
         §_-QO§ = true;
         §_-5b§.§_-Al§ = false;
         if(§_-5b§.§_-1W§)
         {
            §_-5b§.§_-e4§();
         }
         §_-5b§.§_-6I§ = true;
         §_-EU§ = true;
         §_-S2§.§_-ei§.§_-fp§(§_-5b§.§_-Al§,§_-5b§.§_-6I§,§_-5b§.teams,§_-5b§.§_-Pj§);
      }
      
      override protected function §_-Pg§(param1:§_-QV§) : *
      {
         var _loc2_:Number = NaN;
         if(param1.target.championID == §_-S2§.§_-MG§)
         {
            §_-IF§.push(setTimeout(§_-mi§,§_-i6§));
         }
         if(param1.shooterID != -99 && §_-S2§.§_-mn§[param1.shooterID])
         {
            _loc2_ = Math.round(§_-S2§.§_-mn§[param1.target.championID].score / this.§_-ez§);
            §_-S2§.§_-mn§[param1.shooterID].matchCurrency += _loc2_;
            §_-9w§(param1.shooterID,_loc2_);
            §_-P7§(param1.shooterID,_loc2_);
            if(param1.shooterID == §_-S2§.§_-MG§)
            {
               if(§_-eG§.localPlayerAccount.playerStats.currentSurvivalScore < §_-S2§.§_-mn§[§_-S2§.§_-MG§].score)
               {
                  §_-eG§.localPlayerAccount.playerStats.currentSurvivalScore = §_-S2§.§_-mn§[§_-S2§.§_-MG§].score;
               }
            }
            §_-kd§(param1.shooterID,60);
         }
         if(param1.shooterID == §_-S2§.§_-MG§)
         {
            if(§_-V5§.§_-Hi§(§_-S2§.§_-mn§[param1.target.championID].liveKey) == true)
            {
               §_-V5§.§_-QZ§ = true;
            }
         }
         grantDeath(param1.target.championID);
         §_-S2§.§_-mn§[param1.target.championID].score = §_-FJ§;
         this.§_-Hj§(param1.target.championID);
         if(param1.shooterID == §_-5b§.headsUpDisplay.§_-Ln§)
         {
            §_-5b§.headsUpDisplay.§_-nA§(§_-S2§.§_-mn§[param1.target.championID].userName,"$" + String(_loc2_));
         }
      }
      
      private function §_-Hj§(param1:Number) : *
      {
         if(§_-S2§.§_-mn§[param1])
         {
            §_-S2§.§_-mn§[param1].weaponArray[0] = WD_P1;
            §_-S2§.§_-mn§[param1].weaponArray[1] = §_-3B§;
            §_-S2§.§_-mn§[param1].jetpack = JetpackTutorial;
            §_-S2§.§_-mn§[param1].boots = §_-RA§;
            §_-S2§.§_-mn§[param1].matchCurrency = §_-YO§;
         }
      }
      
      override protected function §_-Mx§() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < §_-QF§.length)
         {
            §_-QF§[_loc1_] = §_-FJ§;
            _loc1_++;
         }
         §_-S2§.§_-Mx§(§_-FJ§);
      }
      
      override public function set matchData(param1:GameControllerMatchData) : *
      {
         §_-4H§ = param1.§_-fi§;
         §_-J2§ = param1.§_-dg§;
         §_-QF§ = param1.§_-a§;
         §_-P5§ = param1.active;
         §_-6W§ = param1.§_-Vn§;
         §_-l0§ = param1.complete;
         §_-MZ§ = param1.§_-L5§;
         §_-YO§ = param1.§_-j1§;
      }
   }
}
