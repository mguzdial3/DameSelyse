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
		
		public function HideableObject(X:Number, Y:Number, imageOfObject: Class, _forcesOut: Boolean=false, _timeToEntry: Number=1, _timeToExit :Number=2
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
				loadGraphic(inUseImage);
			}
		}
		
		public function transferToNormalImage():void
		{
			loadGraphic(origImage);
		}
		
		
	
	}
}