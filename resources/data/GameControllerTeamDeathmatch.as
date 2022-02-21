package §_-V2§
{
   import §_-Xl§.§_-If§;
   import events.§_-3K§;
   import events.§_-QV§;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   
   public class GameControllerTeamDeathmatch extends §_-9M§
   {
      
      public static var $title1:String = "Team Deathmatch";
      
      public static var $title2:String = "Teams";
      
      public static var $shortDescription1:String = "Game ends after:\nTime: 6 minutes";
      
      public static var $shortDescription2:String = "Get money for:\nKills";
      
      public static var $longDescription:String = "Classic team deathmatch. The team with the most kills when the time runs out is the winner.";
      
      public static var $active = true;
      
      public static var $tinyDescription:String = "Team DM";
       
      
      private var §_-Fz§:§_-dP§;
      
      private var §_-5o§:§_-hY§;
      
      public function GameControllerTeamDeathmatch(param1:§_-LU§, param2:§_-If§, param3:Array, param4:§_-5S§, param5:Boolean)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function §_-4m§() : *
      {
         §_-QF§ = [0,0,0];
         §_-j0§(0);
         §_-i6§ = 3000;
         this.§_-U7§();
         §_-aK§(§_-QF§[1],§_-QF§[2]);
         if(§_-S2§.§_-MG§ == 0)
         {
            startWatchForEnoughPlayers();
            _matchBoxSmall.§_-Sm§();
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
         §_-EU§ = false;
         §_-1d§();
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
               if(_loc2_ == 1)
               {
                  _loc3_ = "Blue Team";
               }
               else
               {
                  _loc3_ = "Red Team";
               }
               §_-8I§(_loc3_);
               §_-S2§.§_-SB§.§_-19§.send("recvMatchComplete",_loc3_);
               §_-Xk§ = setTimeout(§_-Se§,§_-XU§);
            }
         }
      }
      
      private function §_-U7§() : *
      {
         if(!this.§_-Fz§)
         {
            ++§_-eG§.§_-Vx§;
            this.§_-Fz§ = new §_-dP§();
            this.§_-Fz§.x = §_-9G§.stageWidth / 2;
            this.§_-Fz§.y = 500 / 2;
            addChild(this.§_-Fz§);
            this.§_-Fz§.addEventListener("bluePicked",this.§_-8E§);
            this.§_-Fz§.addEventListener("redPicked",this.§_-8E§);
         }
      }
      
      private function §_-dC§() : *
      {
         if(this.§_-Fz§)
         {
            this.§_-Fz§.removeEventListener("bluePicked",this.§_-8E§);
            this.§_-Fz§.removeEventListener("redPicked",this.§_-8E§);
            this.§_-Fz§.destroy();
            removeChild(this.§_-Fz§);
            this.§_-Fz§ = null;
            --§_-eG§.§_-Vx§;
         }
      }
      
      private function §_-8E§(param1:Event) : *
      {
         if(param1.type == "bluePicked")
         {
            §_-VF§ = 1;
         }
         else if(param1.type == "redPicked")
         {
            §_-VF§ = 2;
         }
         §_-S2§.§_-mn§[§_-S2§.§_-MG§].team = §_-VF§;
         §_-S2§.§_-SB§.§_-19§.send("recvTeamChoice",§_-S2§.§_-MG§,§_-VF§);
         this.§_-dC§();
         this.§_-9j§();
      }
      
      public function §_-9j§() : *
      {
         if(!this.§_-5o§)
         {
            ++§_-eG§.§_-Vx§;
            §_-eL§ = allSpawnPoints(§_-VF§);
            this.§_-5o§ = new §_-hY§(§_-8q§,§_-eL§,§_-4q§.brickSize);
            this.§_-5o§.x = §_-9G§.stageWidth / 2;
            this.§_-5o§.y = 500 / 2;
            addChild(this.§_-5o§);
            this.§_-5o§.addEventListener(§_-3K§.SPAWN_SELECTED,this.spawnBoxSpawnSelected);
            this.§_-5o§.addEventListener("selectTeamClicked",this.spawnBoxChangeTeamClicked);
         }
      }
      
      private function spawnBoxChangeTeamClicked(param1:Event) : *
      {
         §_-VF§ = 0;
         §_-S2§.§_-mn§[§_-S2§.§_-MG§].team = 0;
         §_-S2§.§_-SB§.§_-19§.send("recvTeamChoice",§_-S2§.§_-MG§,0);
         this.§_-IS§();
         this.§_-U7§();
      }
      
      private function spawnBoxSpawnSelected(param1:§_-3K§) : *
      {
         spawnAtPoint(param1.position);
      }
      
      private function §_-IS§() : *
      {
         if(this.§_-5o§)
         {
            this.§_-5o§.removeEventListener(§_-3K§.SPAWN_SELECTED,this.spawnBoxSpawnSelected);
            this.§_-5o§.removeEventListener("selectTeamClicked",this.spawnBoxChangeTeamClicked);
            removeChild(this.§_-5o§);
            this.§_-5o§ = null;
            --§_-eG§.§_-Vx§;
         }
      }
      
      override public function §_-3Y§() : *
      {
         if(this.§_-5o§)
         {
            this.§_-IS§();
            stage.focus = §_-eG§.focusTool;
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
               if(§_-QF§[param1.shooterTeam] >= 0)
               {
                  ++§_-QF§[param1.shooterTeam];
               }
               else
               {
                  §_-QF§[param1.shooterTeam] = 1;
               }
               if(param1.shooterID != -99)
               {
                  §_-P7§(param1.shooterID,1);
               }
               §_-aK§(§_-QF§[1],§_-QF§[2]);
               if(§_-S2§.§_-MG§ == 0)
               {
                  if(§_-QF§[param1.shooterTeam] >= §_-4H§ || §_-J2§ < 0 && ChazTools.isThisTheHighestValueInArray(param1.shooterTeam,§_-QF§))
                  {
                     if(param1.shooterTeam == 1)
                     {
                        _loc2_ = "Blue Team";
                     }
                     else
                     {
                        _loc2_ = "Red Team";
                     }
                     §_-8I§(_loc2_);
                     §_-S2§.§_-SB§.§_-19§.send("recvMatchComplete",_loc2_);
                     §_-Xk§ = setTimeout(§_-Se§,§_-XU§);
                  }
               }
            }
            if(!§_-l0§)
            {
               if(param1.target.championID == §_-S2§.§_-MG§)
               {
                  §_-IF§.push(setTimeout(this.§_-9j§,§_-i6§));
               }
            }
         }
         if(param1.shooterID == §_-5b§.headsUpDisplay.§_-Ln§)
         {
            §_-5b§.headsUpDisplay.§_-nA§(§_-S2§.§_-mn§[param1.target.championID].userName,"$" + String(param1.§_-BE§.$killReward));
         }
      }
      
      override public function §_-Om§() : *
      {
         var _loc1_:Array = new Array();
         var _loc2_:Object = new Object();
         _loc2_.name = "<font color=\'#00CCFF\'>Blue Team";
         if(§_-QF§[1] < 0)
         {
            §_-QF§[1] = 0;
         }
         if(§_-QF§[2] < 0)
         {
            §_-QF§[2] = 0;
         }
         _loc2_.score = §_-QF§[1];
         var _loc3_:Object = new Object();
         _loc3_.name = "<font color=\'#FFA4A4\'>Red Team";
         _loc3_.score = §_-QF§[2];
         _loc1_ = [_loc2_,_loc3_];
         _loc1_.sortOn(["score"],Array.NUMERIC | Array.DESCENDING);
         §_-lo§.§_-Om§(_loc1_);
         §_-lo§.§_-Z8§(§_-J2§);
         §_-lo§.§_-iB§(§_-4H§);
      }
      
      override public function set matchData(param1:GameControllerMatchData) : *
      {
         var _loc2_:String = null;
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
            if(§_-QF§[1] > §_-QF§[2])
            {
               _loc2_ = "Blue Team";
            }
            else
            {
               _loc2_ = "Red Team";
            }
            §_-8I§(_loc2_);
         }
         else if(!§_-6W§ && §_-P5§)
         {
            _matchBoxSmall.§_-7p§(§_-J2§,false,"TDM");
         }
         §_-aK§(§_-QF§[1],§_-QF§[2]);
         if(§_-P5§ && !§_-l0§)
         {
            §_-jN§();
         }
      }
      
      override public function §_-PQ§() : *
      {
         §_-P5§ = true;
         §_-5b§.§_-gi§();
         if(§_-MZ§)
         {
            §_-3w§();
            resetAllPlayersItems();
         }
         _matchBoxSmall.§_-7p§(§_-6X§,false,"TDM");
         var _loc1_:* = 0;
         while(_loc1_ < §_-IF§.length)
         {
            clearInterval(§_-IF§[_loc1_]);
            §_-IF§[_loc1_] = null;
            _loc1_++;
         }
         if(§_-VF§ != 0 && !this.§_-Fz§)
         {
            this.§_-9j§();
         }
         else
         {
            this.§_-U7§();
         }
         §_-jN§();
      }
      
      override protected function §_-iI§() : *
      {
         this.§_-dC§();
         this.§_-IS§();
      }
      
      override protected function respawnAfterReset() : *
      {
         if(!§_-5b§.championArray[§_-S2§.§_-MG§])
         {
            if(§_-VF§ != 0 && !this.§_-Fz§)
            {
               this.§_-9j§();
            }
            else
            {
               this.§_-U7§();
            }
         }
      }
   }
}
