package 
{
	import org.flixel.*;
	
	//Called HideableObject as in the character can hide within it
	public class HideablePlant extends HideableObject
	{
	
		private var totalLife: Number = 6;
		private var currLife: Number;
	
		//CONSTRUCTOR
		public function HideablePlant(X:Number, Y:Number)
		{
			super(X,Y, Assets.SINGLE_PLANT);
			
			isAPlant=true;
			origImage = Assets.SINGLE_PLANT;
			
			
			inUseImage = Assets.REGROW_PLANT;
			
			
			
			//HideableObjects cannot be moved
			super.immovable = true;
			timeToEnter = 0.5;
			
			timeToExit = 1;
			
		}
		
		//GETTERS
		
		public override function getTimeToEnter(): Number
		{
			return timeToEnter;
		}
		
		public override function getTimeToExit(): Number
		{
			return timeToExit;
		}
		
		public override function getForcesOut(): Boolean
		{
			return forcesOut;
		}
		
		//NOT GETTERS
		
		//Called every frame the player is hiding within this object, returns true while still able to hide in it(to be overridden later)
		public override function hidingWithin(): Boolean
		{
			return true;
		}


		public function takeLife(amountToTake:Number): Boolean
		{
		
			currLife-=amountToTake; 
			
			if(currLife<=0)
			{
				return true;
			}
			else
			{
				return false;
			}
					
		}		
		
		public function getRatio(): Number
		{
			return currLife/totalLife;
		}
		
		public override function transferToHidingImage():void
		{
		
			currLife = totalLife;
		
			loadGraphic(
						inUseImage, // image to use
						true, // animated
						false, // don't generate "flipped" images since they're already in the image
						24, // width of each frame (in pixels)
						28 // height of each frame (in pixels)
				);
				//Set up animations
				addAnimation("regrow", [0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,6,7,7,7,7,7,7,7,7,7],12,false);
				play("regrow");
			
		}
		
		public override function transferToNormalImage():void
		{
			
			loadGraphic(origImage);
			
		}
		
		
	
	}
}