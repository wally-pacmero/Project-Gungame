package §_-V2§
{
   import flash.net.registerClassAlias;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class GameControllerMatchData implements IExternalizable
   {
      
      private static const §_-PP§ = registerClassAlias("GameControllerMatchData",GameControllerMatchData);
       
      
      public var §_-a§:Array;
      
      public var §_-fi§:Number;
      
      public var §_-dg§:Number;
      
      public var §_-7J§:Number;
      
      public var §_-WZ§:Class;
      
      public var active:Boolean;
      
      public var §_-Vn§:Boolean;
      
      public var complete:Boolean;
      
      public var §_-L5§:Boolean;
      
      public var §_-j1§:Number;
      
      public function GameControllerMatchData()
      {
         super();
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeInt(this.§_-fi§);
         param1.writeInt(this.§_-dg§);
         param1.writeInt(this.§_-a§.length);
         var _loc2_:* = 0;
         while(_loc2_ < this.§_-a§.length)
         {
            if(this.§_-a§[_loc2_] >= 0)
            {
               param1.writeInt(this.§_-a§[_loc2_]);
            }
            else
            {
               param1.writeInt(-1);
            }
            _loc2_++;
         }
         param1.writeUTF(getQualifiedClassName(this.§_-WZ§));
         param1.writeBoolean(this.active);
         param1.writeBoolean(this.§_-Vn§);
         param1.writeBoolean(this.complete);
         param1.writeInt(this.§_-7J§);
         param1.writeBoolean(this.§_-L5§);
         param1.writeInt(this.§_-j1§);
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         var _loc4_:Number = NaN;
         this.§_-fi§ = param1.readInt();
         this.§_-dg§ = param1.readInt();
         this.§_-a§ = new Array();
         var _loc2_:int = param1.readInt();
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = param1.readInt()) >= 0)
            {
               this.§_-a§[_loc3_] = _loc4_;
            }
            _loc3_++;
         }
         this.§_-WZ§ = getDefinitionByName(param1.readUTF()) as Class;
         this.active = param1.readBoolean();
         this.§_-Vn§ = param1.readBoolean();
         this.complete = param1.readBoolean();
         this.§_-7J§ = param1.readInt();
         this.§_-L5§ = param1.readBoolean();
         this.§_-j1§ = param1.readInt();
      }
   }
}
