package 
{
	import org.flixel.*;
	
	//Called HideableObject as in the character can hide within it
	public class HideableObject extends FlxSprite
	{
		private var timeToEnter: int; //The amount of time, in seconds, it takes to enter this hiding space
		private var timeToExit: int; //Amount of time, in seconds, it takes to exit this hiding space
		
		//These determine the directions the player can go from hiding in here
		private var canMoveLeft: Boolean;
		private var canMoveRight: Boolean;
		private var canMoveUp: Boolean;
		private var canMoveDown:Boolean;
		
		//Original image
		private var origImage:Class;
		
		//In Use Image
		private var inUseImage: Class;
		
		//CONSTRUCTOR
		
		public function HideableObject(X:Number, Y:Number, imageOfObject: Class, _timeToEntry: int=2, _timeToExit :int=2,
		_canMoveLeft:Boolean=true,_canMoveRight:Boolean=true, _canMoveUp:Boolean=true, _canMoveDown:Boolean=true
		, _inUseImage: Class=null)
		{
			super(X,Y, imageOfObject);
			
			origImage = imageOfObject
			
			
			inUseImage = _inUseImage;
			
			
			//HideableObjects cannot be moved
			super.immovable = true;
			timeToEnter = _timeToEntry;
			
			timeToExit = _timeToExit;
			
			canMoveLeft = _canMoveLeft;
			canMoveRight = _canMoveRight;
			canMoveUp = _canMoveUp;
			canMoveDown = _canMoveDown;
			
		}
		
		//GETTERS
		
		public function getTimeToEnter(): int
		{
			return timeToEnter;
		}
		
		public function getTimeToExit(): int
		{
			return timeToExit;
		}
		
		public function getCanMoveLeft(): Boolean
		{
			return canMoveLeft;
		}
		
		public function getCanMoveRight(): Boolean
		{
			return canMoveRight;
		}
		
		public function getCanMoveUp(): Boolean
		{
			return canMoveUp;
		}		
		
		public function getCanMoveDown(): Boolean
		{
			return canMoveDown;
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