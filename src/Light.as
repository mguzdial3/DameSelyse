package {
  import org.flixel.*;
 
  public class Light extends FlxSprite {
  	
    private var darkness:FlxSprite;
    
   	 public function Light(LightImageClass: Class, x:Number, y:Number, darkness:FlxSprite, _color:uint = 0xFFFFFFFF, alphaNumber: Number=1.0):void {
	  super(x, y, LightImageClass);
 
      this.darkness = darkness;
      this.blend = "screen"
      
      this.alpha =alphaNumber;
      
      this.color = _color;
    }
   
 
    override public function draw():void {
  	  var screenXY:FlxPoint = getScreenXY();
 
 	  darkness.stamp(this,
      screenXY.x - this.width / 2,
      screenXY.y - this.height / 2);
	}
	}
}