package 
{
	import org.flixel.*;
	
	//Called HideableObject as in the character can hide within it
	public class HideableObject extends FlxSprite
	{
		protected var timeToEnter: Number; //The amount of time, in seconds, it takes to enter this hiding space
		protected var timeToExit: Number; //Amount of time, in seconds, it takes to exit this hiding space
		
		protected var forcesOut: Boolean;
		
		//Original image
		protected var origImage:Class;
		
		//In Use Image
		protected var inUseImage: Class;
		
		public var isAPlant: Boolean;		
		//CONSTRUCTOR
		
		public function HideableObject(X:Number, Y:Number, imageOfObject: Class, _forcesOut: Boolean=false, _timeToEntry: Number=0.75, _timeToExit :Number=0.75
		, _inUseImage: Class=null)
		{
			
			
			super(X,Y, imageOfObject);
			
			
			if(_forcesOut)
			{
				loadGraphic(
						imageOfObject, // image to use
						true, // animated
						false, // don't generate "flipped" images since they're already in the image
						21, // width of each frame (in pixels)
						17 // height of each frame (in pixels)
				);
				
				addAnimation("boil", [0,1,2,3,1,0,2],(14+(Math.random()*3)),true);
				play("boil");
			}
			
			
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
					timeToExit = 3;
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
		
			if(!forcesOut)
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
			}
			else
			{
			
				if(inUseImage!=null)
				{
					loadGraphic(
							inUseImage, // image to use
							true, // animated
							false, // don't generate "flipped" images since they're already in the image
							21, // width of each frame (in pixels)
							23 // height of each frame (in pixels)
					);
				
					
					if(Math.random()>0.5)
					{
						addAnimation("inBoilRL", [0,1,2,3,0,1,2,3,19,18,17,15,12,13,14,15,12,13,14,15,16,17,18,19,0,1,2,3,0,1,2,3,4,5,6,7,8,9,10,11,8,9,10,11,7,6,5,4],20,true);
						play("inBoilRL");
					}
					
					else
					{
						addAnimation("inBoilLR", [0,1,2,3,0,1,2,3,4,5,6,7,8,9,10,11,8,9,10,11,7,6,5,4,0,1,2,3,0,1,2,3,19,18,17,15,12,13,14,15,12,13,14,15,16,17,18,19],20,true);
						play("inBoilLR");
					}
					
				}
			
				y-=6;
			
			}
			
			//y-=6;
		}
		
		public function transferToNormalImage():void
		{
			if(!forcesOut)
			{
		
				loadGraphic(origImage);
			}
			else
			{
				loadGraphic(
						origImage, // image to use
						true, // animated
						false, // don't generate "flipped" images since they're already in the image
						21, // width of each frame (in pixels)
						17 // height of each frame (in pixels)
				);
				
				
				
				addAnimation("boil", [0,1,2,3,1,0,2],(14+(Math.random()*3)),true);
				play("boil");
				
				y+=6;
			}
			//y+=6;
		}
		
		
	
	}
}