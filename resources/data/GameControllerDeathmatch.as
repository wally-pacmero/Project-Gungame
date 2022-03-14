package §_-V2§
{
   import §_-Xl§.§_-If§;
   import events.§_-QV§;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   
   public class GameControllerDeathmatch extends §_-9M§
   {
      
      public static var $title1:String = "Deathmatch";
      
      public static var $title2:String = "Free for all";
      
      public static var $shortDescription1:String = "Game ends after:\nTime: 6 minutes";
      
      public static var $shortDescription2:String = "Get money for:\nKills";
      
      public static var $longDescription:String = "Straight up deathmatch. If it moves, kill it.";
      
      public static var $active = true;
      
      public static var $tinyDescription:String = "Deathmatch";
       
      
      public function GameControllerDeathmatch(param1:§_-LU§, param2:§_-If§, param3:Array, param4:§_-5S§, param5:Boolean)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function §_-4m§() : *
      {
         var _loc1_:Array = null;
         var _loc2_:Number = NaN;
         var _loc3_:Point = null;
         §_-QF§ = new Array();
         §_-j0§(0);
         §_-i6§ = 3000;
         if(§_-S2§.§_-MG§ == 0)
         {
            respawnChampionOld(§_-S2§.§_-MG§,§_-VF§);
            startWatchForEnoughPlayers();
            _matchBoxSmall.§_-Sm§();
         }
         else
         {
            _loc1_ = allSpawnPoints(§_-VF§);
            _loc2_ = Math.floor(Math.random() * _loc1_.length);
            _loc3_ = new Point(_loc1_[_loc2_].x,_loc1_[_loc2_].y);
            §_-S2§.§_-SB§.§_-19§.send("recvSpawnRequest",§_-S2§.§_-MG§,0,_loc3_.x,_loc3_.y);
         }
         §_-5b§.§_-Al§ = false;
         if(§_-5b§.§_-1W§)
         {
            §_-5b§.§_-e4§();
         }
         §_-5b§.§_-6I§ = true;
         §_-S2§.§_-ei§.§_-fp§(§_-5b§.§_-Al§,§_-5b§.§_-6I§,§_-5b§.teams,§_-5b§.§_-Pj§);
         §_-S2§.§_-ei§.§_-QO§ = true;
         §_-QO§ = true;
         §_-EU§ = true;
      }
      
      override protected function §_-g1§(param1:Event) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         --§_-J2§;
         if(§_-J2§ == 0 && §_-S2§.§_-MG§ == 0)
         {
            _loc2_ = §_-CS§();
            if(_loc2_ != -1)
            {
               _loc3_ = §_-S2§.§_-mn§[_loc2_].userName;
               §_-8I§(_loc3_);
               §_-S2§.§_-SB§.§_-19§.send("recvMatchComplete",_loc3_);
               §_-Xk§ = setTimeout(§_-Se§,§_-XU§);
            }
         }
      }
      
      override protected function §_-4r§() : *
      {
         §_-S2§.§_-SB§.§_-19§.send("recvCountdownComplete");
         this.§_-PQ§();
      }
      
      override public function recvCountdownComplete() : *
      {
         this.§_-PQ§();
      }
      
      override protected function §_-Pg§(param1:§_-QV§) : *
      {
         var _loc2_:String = null;
         if(!§_-l0§)
         {
            if(param1.shooterID != -99 && §_-S2§.§_-mn§[param1.shooterID])
            {
               §_-kd§(param1.shooterID,60);
            }
            if(§_-P5§)
            {
               grantDeath(param1.target.championID);
            }
            if(param1.shooterID != -99 && §_-P5§ && §_-S2§.§_-mn§[param1.shooterID])
            {
               §_-S2§.§_-mn§[param1.shooterID].matchCurrency += param1.§_-BE§.$killReward;
               §_-9w§(param1.shooterID,param1.§_-BE§.$killReward);
               if(param1.shooterID != -99)
               {
                  §_-P7§(param1.shooterID,1);
               }
               if(§_-QF§[param1.shooterID] >= 0)
               {
                  ++§_-QF§[param1.shooterID];
               }
               else
               {
                  §_-QF§[param1.shooterID] = 1;
               }
               if(§_-S2§.§_-MG§ == 0)
               {
                  if(§_-QF§[param1.shooterID] >= §_-4H§ || §_-J2§ < 0 && ChazTools.isThisTheHighestValueInArray(param1.shooterID,§_-QF§))
                  {
                     _loc2_ = §_-S2§.§_-mn§[param1.shooterID].userName;
                     §_-8I§(_loc2_);
                     §_-S2§.§_-SB§.§_-19§.send("recvMatchComplete",_loc2_);
                     §_-Xk§ = setTimeout(§_-Se§,§_-XU§);
                  }
               }
            }
            if(!§_-l0§)
            {
               if(§_-S2§.§_-MG§ == 0)
               {
                  §_-IF§.push(setTimeout(respawnChampionOld,§_-i6§,param1.target.championID,0));
               }
            }
         }
         if(param1.shooterID == §_-5b§.headsUpDisplay.§_-Ln§)
         {
            §_-5b§.headsUpDisplay.§_-nA§(§_-S2§.§_-mn§[param1.target.championID].userName,"$" + String(param1.§_-BE§.$killReward));
         }
      }
      
      private function §_-j5§() : Array
      {
         var _loc4_:Object = null;
         var _loc1_:Array = new Array();
         var _loc2_:* = 0;
         while(_loc2_ < §_-S2§.§_-mn§.length)
         {
            if(!§_-QF§[_loc2_] && §_-S2§.§_-mn§[_loc2_])
            {
               §_-QF§[_loc2_] = 0;
            }
            else if(!§_-S2§.§_-mn§[_loc2_] && §_-QF§[_loc2_] >= 0)
            {
               §_-QF§[_loc2_] = null;
            }
            _loc2_++;
         }
         var _loc3_:* = 0;
         while(_loc3_ < §_-QF§.length)
         {
            if(§_-QF§[_loc3_] != null && §_-QF§[_loc3_] >= 0)
            {
               (_loc4_ = new Object()).name = §_-S2§.§_-mn§[_loc3_].userName;
               _loc4_.score = §_-QF§[_loc3_];
               _loc1_.push(_loc4_);
            }
            _loc3_++;
         }
         _loc1_.sortOn(["score"],Array.NUMERIC | Array.DESCENDING);
         return _loc1_;
      }
      
      override public function §_-Om§() : *
      {
         §_-lo§.§_-Om§(this.§_-j5§());
         §_-lo§.§_-Z8§(§_-J2§);
         §_-lo§.§_-iB§(§_-4H§);
      }
      
      override public function set matchData(param1:GameControllerMatchData) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         §_-4H§ = param1.§_-fi§;
         §_-J2§ = param1.§_-dg§;
         §_-6X§ = param1.§_-7J§;
         §_-QF§ = param1.§_-a§;
         §_-P5§ = param1.active;
         §_-6W§ = param1.§_-Vn§;
         §_-l0§ = param1.complete;
         §_-YO§ = param1.§_-j1§;
         if(§_-l0§)
         {
            _loc2_ = 0;
            while(_loc2_ < §_-QF§.length)
            {
               if(§_-QF§[_loc2_] >= §_-4H§)
               {
                  _loc3_ = §_-S2§.§_-mn§[_loc2_].userName;
                  §_-8I§(_loc3_);
                  break;
               }
               _loc2_++;
            }
         }
         if(!§_-6W§ && §_-P5§)
         {
            _matchBoxSmall.§_-7p§(§_-J2§,false,"DM");
         }
         if(§_-P5§ && !§_-l0§)
         {
            §_-jN§();
         }
      }
      
      override public function §_-PQ§() : *
      {
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:Point = null;
         §_-P5§ = true;
         §_-5b§.§_-gi§();
         _matchBoxSmall.§_-7p§(§_-6X§,false,"DM");
         if(§_-MZ§)
         {
            §_-3w§();
            resetAllPlayersItems();
         }
         var _loc1_:* = 0;
         while(_loc1_ < §_-IF§.length)
         {
            clearInterval(§_-IF§[_loc1_]);
            §_-IF§[_loc1_] = null;
            _loc1_++;
         }
         if(§_-S2§.§_-MG§ == 0)
         {
            respawnChampionOld(§_-S2§.§_-MG§,§_-VF§);
         }
         else
         {
            _loc2_ = allSpawnPoints(§_-VF§);
            _loc3_ = Math.floor(Math.random() * _loc2_.length);
            _loc4_ = new Point(_loc2_[_loc3_].x,_loc2_[_loc3_].y);
            §_-S2§.§_-SB§.§_-19§.send("recvSpawnRequest",§_-S2§.§_-MG§,0,_loc4_.x,_loc4_.y);
         }
         §_-jN§();
      }
      
      override protected function §_-iI§() : *
      {
      }
      
      override protected function respawnAfterReset() : *
      {
         if(!§_-5b§.championArray[§_-S2§.§_-MG§])
         {
            if(§_-S2§.§_-MG§ == 0)
            {
               respawnChampionOld(§_-S2§.§_-MG§,§_-VF§);
            }
            else
            {
               §_-S2§.§_-SB§.§_-19§.send("recvSpawnRequest",§_-S2§.§_-MG§,0,-1,-1);
            }
         }
      }
   }
}
