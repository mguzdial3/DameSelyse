package 
{
	import org.flixel.*;
	
	//Called HideableObject as in the character can hide within it
	public class HideableObject extends FlxSprite
	{
		private var timeToEnter: Number; //The amount of time, in seconds, it takes to enter this hiding space
		private var timeToExit: Number; //Amount of time, in seconds, it takes to exit this hiding space
		
		private var forcesOut: Boolean;
		
		//Original image
		private var origImage:Class;
		
		//In Use Image
		private var inUseImage: Class;
		
		//CONSTRUCTOR
		
		public function HideableObject(X:Number, Y:Number, imageOfObject: Class, _forcesOut: Boolean=false, _timeToEntry: Number=0.75, _timeToExit :Number=0.75
		, _inUseImage: Class=null)
		{
			super(X,Y, imageOfObject);
			
			origImage = imageOfObject
			
			
			inUseImage = _inUseImage;
			
			forcesOut = _forcesOut;
			
			
			//HideableObjects cannot be moved
			super.immovable = true;
			timeToEnter = _timeToEntry;
			
			timeToExit = _timeToExit;
			
			
			if(forcesOut)
			{
				if(timeToExit<1)
				{
					timeToExit = 2.5;
				}
			}
			
		}
		
		//GETTERS
		
		public function getTimeToEnter(): Number
		{
			return timeToEnter;
		}
		
		public function getTimeToExit(): Number
		{
			return timeToExit;
		}
		
		public function getForcesOut(): Boolean
		{
			return forcesOut;
		}
		
		//NOT GETTERS
		
		//Called every frame the player is hiding within this object, returns true while still able to hide in it(to be overridden later)
		public function hidingWithin(): Boolean
		{
			return true;
		}
		
		public function transferToHidingImage():void
		{
			if(inUseImage!=null)
			{
				loadGraphic(
							inUseImage, // image to use
							true, // animated
							false, // don't generate "flipped" images since they're already in the image
							20, // width of each frame (in pixels)
							27 // height of each frame (in pixels)
					);
					//Set up animations
					addAnimation("hiding", [0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,3,3,3,3,3,3,3,3,4,3,3,3,3,2,1,0,0,0,0,0,5,6,7,7,7,7,7,7,7,7,7,8,7,7,7,6,5,0],12);
					play("hiding");
			}
			
			//y-=6;
		}
		
		public function transferToNormalImage():void
		{
			loadGraphic(origImage);
			//y+=6;
		}
		
		
	
	}
}