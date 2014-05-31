package 
{
	import org.flixel.*;

	//Extends FlxSprite so it can be displayed easily
	public class Click extends InventoryItem
	{
		
		
		public function Click(x:Number, y:Number)
		{
			super(Assets.CLICK,x,y, "Click", new FlxPoint(1,1));
			
			
			loadGraphic(
					Assets.CLICK, // image to use
					true, // animated
					false, // don't generate "flipped" images since they're already in the image
					11, // width of each frame (in pixels)
					16 // height of each frame (in pixels)
			);
			//Set up animations
			//addAnimation("exiting", [0,0,1,1,2,2,3,3,4,5,6,7,7,8],15);
			addAnimation("hover", [3,3,3,3,3,3,3,3,3,3,0,1,2,3,3,3,3,3,3,3],13);
			addAnimation("still", [3],1);
			play("hover");
			
			
			
		}
		
		public function SetStill():void{
			play("still");
		}
		
		public function SetHover():void{
			play("hover");
		}
		
	}
}