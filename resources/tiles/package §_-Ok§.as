package §_-Ok§
{
   import flash.display.MovieClip;
   
   public class §_-7d§ extends MovieClip
   {
      
      public static var §_-1A§:Number = 10;
       
      
      private var §_-6S§:Array;
      
      public function §_-7d§(param1:String)
      {
         super();
         this.§_-6S§ = new Array();
         this.§_-ci§(param1);
         this.§_-Oq§();
      }
      
      private function §_-ci§(param1:String) : *
      {
         switch(param1)
         {
            case "block":
               this.§_-6S§.push(new IconObject(new gp1_none(),1,"block","Standard ground block. Can be damaged and destroyed by most weapons"));
               this.§_-6S§.push(new IconObject(new gp1_bluegatedemo(),2,"block","Blue gate. Indestructible, and only players on blue team can pass through these"));
               this.§_-6S§.push(new IconObject(new gp1_redgatedemo(),3,"block","Red gate. Indestructible, and only players on red team can pass through these"));
               this.§_-6S§.push(new IconObject(new gp1_crate(),4,"block","Crate. Indestructible."));
               this.§_-6S§.push(new IconObject(new gp1_upboost(),5,"block","Upwards booster. Accelerates players upwards"));
               this.§_-6S§.push(new IconObject(new gp1_leftboost(),6,"block","Left booster. Accelerates players to the left"));
               this.§_-6S§.push(new IconObject(new gp1_rightboost(),7,"block","Right booster. Accelerates players to the right"));
               this.§_-6S§.push(new IconObject(new gp1_indestructibledemo(),8,"block","Indestructible ground. No weapons or players can pass through these"));
               break;
            case "scenery":
               this.§_-6S§.push(new IconObject(new gp1_s_0(),0,"scenery","Large tree, 3x3 blocks"));
               this.§_-6S§.push(new IconObject(new gp1_s_1(),1,"scenery","Medium tree, 2x2 blocks"));
               this.§_-6S§.push(new IconObject(new gp1_s_2(),2,"scenery","Small shrub"));
               this.§_-6S§.push(new IconObject(new gp1_s_3(),3,"scenery","Low grass"));
               this.§_-6S§.push(new IconObject(new gp1_s_4(),4,"scenery","Large toadstool"));
               this.§_-6S§.push(new IconObject(new gp1_s_5(),5,"scenery","Small toadstool"));
               this.§_-6S§.push(new IconObject(new gp1_s_6(),6,"scenery","Flower"));
               this.§_-6S§.push(new IconObject(new gp1_s_7(),7,"scenery","Ladder"));
               this.§_-6S§.push(new IconObject(new gp1_s_9(),9,"scenery","Fence post left"));
               this.§_-6S§.push(new IconObject(new gp1_s_10(),10,"scenery","Fence post middle"));
               this.§_-6S§.push(new IconObject(new gp1_s_8(),8,"scenery","Fence post right"));
               this.§_-6S§.push(new IconObject(new gp1_s_11(),11,"scenery","Signpost, once it\'s placed press T to edit it, and Shift-Enter to save"));
               this.§_-6S§.push(new IconObject(new gp1_s_12(),12,"scenery","Tall grass"));
               this.§_-6S§.push(new IconObject(new gp1_s_13(),13,"scenery","Chair facing right"));
               this.§_-6S§.push(new IconObject(new gp1_s_14(),14,"scenery","Chair facing left"));
               this.§_-6S§.push(new IconObject(new gp1_s_15(),15,"scenery","Table left side"));
               this.§_-6S§.push(new IconObject(new gp1_s_16(),16,"scenery","Table middle"));
               this.§_-6S§.push(new IconObject(new gp1_s_17(),17,"scenery","Table right side"));
               this.§_-6S§.push(new IconObject(new gp1_s_18(),18,"scenery","Large blue toadstools"));
               this.§_-6S§.push(new IconObject(new gp1_s_19(),19,"scenery","Large red toadstools"));
               this.§_-6S§.push(new IconObject(new gp1_s_20(),20,"scenery","Small blue toadstools"));
               this.§_-6S§.push(new IconObject(new gp1_s_21(),21,"scenery","Small red toadstools"));
               this.§_-6S§.push(new IconObject(new gp1_s_22(),22,"scenery","Tree stump"));
               this.§_-6S§.push(new IconObject(new gp1_s_23(),23,"scenery","Large rock pile"));
               this.§_-6S§.push(new IconObject(new gp1_s_24(),24,"scenery","Small rock pile"));
               break;
            case "objectives":
               this.§_-6S§.push(new IconObject(new gp1_p_0(),0,"spawn","Free for all spawn. Players not on any team use these to spawn"));
               this.§_-6S§.push(new IconObject(new gp1_p_1(),1,"spawn","Blue team spawn point"));
               this.§_-6S§.push(new IconObject(new gp1_p_2(),2,"spawn","Red team spawn point"));
               this.§_-6S§.push(new IconObject(new gp1_f_1(),1,"flag","Blue teams flag. This should be placed in the blue team base"));
               this.§_-6S§.push(new IconObject(new gp1_f_2(),2,"flag","Red teams flag. This should be placed in the red team base"));
               break;
            case "fluids":
               this.§_-6S§.push(new IconObject(new gp1_waterwavey(),1,"medium","Water. Will slow you down a lot, but you can still fire weapons underwater"));
         }
      }
      
      private function §_-Oq§() : *
      {
         var _loc1_:* = 0;
         while(_loc1_ < this.§_-6S§.length)
         {
            addChild(this.§_-6S§[_loc1_]);
            this.§_-6S§[_loc1_].x = _loc1_ * (32 + §_-1A§);
            _loc1_++;
         }
      }
   }
}
