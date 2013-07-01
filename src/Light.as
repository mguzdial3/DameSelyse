package {
  import org.flixel.*;
 
  public class Light extends FlxSprite {
  	
    private var darkness:FlxSprite;
    private var currGoal: uint;
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
    }
    
    
    
    
    //Returns true if lerped all the way to passed in color
    //No passed in color the same as passing in white
    //Time it takes is literally the amount of time (in cycles) it will take to lerp to that color
    public function lerpColor(goalColor: uint= 0xFFFFFFFF, timeItTakes:Number=10): Boolean
    {
    
    	if(goalColor!=currGoal)
    	{
    		currGoal=goalColor;
    		timer=timeItTakes*2;
    	}
    
    	//Break colors into component parts
    	
    	//First our present color:
    	var red1: uint =this.color & 0x000000ff;
        var green1:uint = this.color & 0x0000ff00;
        var blue1:uint = this.color & 0x00ff0000;
        var alpha1:uint = this.color >> 24;
        
        //Now the goal color
        var red2: uint =goalColor & 0x000000ff;
        var green2:uint = goalColor & 0x0000ff00;
        var blue2:uint = goalColor & 0x00ff0000;
        var alpha2:uint = goalColor >> 24;
        
        //Linearly interpolate
        var red:uint = red1 + ((red2 - red1) * 1 / timeItTakes);
    	var blue:uint = blue1 + ((blue2 - blue1) * 1 / timeItTakes);
    	var green:uint = green1 + ((green2 - green1) * 1 / timeItTakes);
    	var a:uint = alpha1 + ((alpha2 - alpha1) * 1 / timeItTakes);
    	
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
   
 
    override public function draw():void {
  	  var screenXY:FlxPoint = getScreenXY();
 
 	  darkness.stamp(this,
      screenXY.x - this.width / 2,
      screenXY.y - this.height / 2);
	}
	}
}