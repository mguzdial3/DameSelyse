package {
  import org.flixel.*;
 
  public class Light extends FlxSprite {
  	
    private var darkness:FlxSprite;
    private var currGoal: uint;
    private var origColor: uint;
    private var timer:int;
    
   	 public function Light(LightImageClass: Class, x:Number, y:Number, darkness:FlxSprite, _color:uint = 0xFFFFFFFF, alphaNumber: Number=1.0):void {
	  super(x, y, LightImageClass);
 
      this.darkness = darkness;
      this.blend = "screen"
      
      this.alpha =alphaNumber;
      
      this.color = _color;
      
      
    }
    
    //Set the color automatically
    public function setColor(_color:uint=0xFFFFFFFF):void
    {
    	this.color = _color;
    	currGoal=_color;
    	timer = 0;
    }
    
    public function setNewScale(pnt: FlxPoint):void
    {
    	this.scale=pnt;
    }
    
    
    
    
    //Returns true if lerped all the way to passed in color
    //No passed in color the same as passing in white
    //Time it takes is literally the amount of time (in cycles) it will take to lerp to that color
    public function lerpColor(goalColor: uint= 0xFFFFFFFF, timeItTakes:Number=10): Boolean
    {
    
    	if(goalColor!=currGoal)
    	{
    		currGoal=goalColor;
    		origColor = this.color;
    		timer=timeItTakes*5; //used to be 2
    	}
    
    	//Break colors into component parts
    	
    	//First our present color:
    	var red1: uint =origColor & 0x000000ff;
        var green1:uint = origColor & 0x0000ff00;
        var blue1:uint = origColor & 0x00ff0000;
        var alpha1:uint = origColor >> 24;
        
        //Now the goal color
        var red2: uint =goalColor & 0x000000ff;
        var green2:uint = goalColor & 0x0000ff00;
        var blue2:uint = goalColor & 0x00ff0000;
        var alpha2:uint = goalColor >> 24;
        
        
        
        
        //Linearly interpolate
        var red:uint = red1 + ((red2 - red1) * 1 / timer); //used to be time it takes
    	var blue:uint = blue1 + ((blue2 - blue1) * 1 / timer);
    	var green:uint = green1 + ((green2 - green1) * 1 / timer);
    	var a:uint = alpha1 + ((alpha2 - alpha1) * 1 / timer);
    	
    	this.color = (a << 24) | blue | green | red;
    	
    	
    	timer--;
    	
    	if(timer<0)
    	{
    		return true;
    	}
    	else
    	{
    		return false;
    	}
        
        
    
    }
    
    public function lerpBetween(firstColor: uint= 0xFFFFFFFF, secondColor:uint=0xFFFFFFFF, t:Number=0.5): void
    {
    
    	
    	/**
    	//First our present color:
    	var red1: int = (int)(firstColor & 0x000000ff);
        var green1:int = (int)(firstColor & 0x0000ff00);
        var blue1:int = (int)(firstColor & 0x00ff0000);
        var alpha1:int = (int)(firstColor >> 24);
        
        //Now the goal color
        var red2: int = (int)(secondColor & 0x000000ff);
        var green2:int = (int)(secondColor & 0x0000ff00);
        var blue2:int = (int)(secondColor & 0x00ff0000);
        var alpha2:int = (int)(secondColor >> 24);
        */
        
        
        
        
        var red1: uint = (firstColor & 0x00ff0000);
        var green1:uint = (firstColor & 0x0000ff00);
        var blue1:uint = (firstColor & 0x000000ff);
        var alpha1:uint = (firstColor & 0xff000000);
        
        //Now the goal color
        var red2: uint = (secondColor & 0x00ff0000);
        var green2:uint = (secondColor & 0x0000ff00);
        var blue2:uint = (secondColor & 0x000000ff);
        var alpha2:uint = (secondColor & 0xff000000);
        
        
        var red1Val:int = (int)(red1/65536.0);
        var red2Val:int = (int)(red2/65536.0);
        
        var green1Val:int = (int)(green1/256.0);
        var green2Val:int = (int)(green2/256.0);
        
        var blue1Val:int = (int)(blue1);
        var blue2Val:int = (int)(blue2);
        
        
        
        //TopDownLevel.printText2.text = "First Color: "+red1Val+", "+green1Val+", "+blue1Val+"                            Second Color: "+
        //     red2Val+", "+green2Val+", "+blue2Val;   
        //Linearly interpolate
        var red:int = red1Val + ((red2Val - red1Val) *t); //used to be time it takes
    	var blue:int = blue1Val + ((blue2Val - blue1Val) * t);
    	var green:int = green1Val + ((green2Val - green1Val) * t);
    	var a:uint = alpha1 + ((alpha2 - alpha1) * t);
    	
    	
    	var redU:uint = (uint)(red*65536.0);
    	var blueU:uint = (uint)(blue);
    	var greenU:uint = (uint)(green*256.0);
    	
    	this.color = (a << 24) | redU | greenU | blueU;
    	
    }
   
 
    override public function draw():void {
  	  var screenXY:FlxPoint = getScreenXY();
 
 	  darkness.stamp(this,
      screenXY.x - this.width / 2,
      screenXY.y - this.height / 2);
	}
	}
}