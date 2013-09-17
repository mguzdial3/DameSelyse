package 
{
	import org.flixel.*;
	
	public class SavePoint extends FlxSprite
	{
		private var opened:Boolean;
		private var timeToOpen: Number;
	
		public function SavePoint(X:Number,  Y:Number, _timeToOpen:Number=2)
		{
			super(X, Y);
	
			opened=false;
			timeToOpen = _timeToOpen;	
		
			loadGraphic(
					Assets.CLOSED_PIPE, // image to use
					true, // animated
					false, // don't generate "flipped" images since they're already in the image
					19, // width of each frame (in pixels)
					16 // height of each frame (in pixels)
			);	
			
			immovable = true;
			
			//Set up animations
			addAnimation("closed", [0]);
			addAnimation("opening", [0,1,2,3],12);
		
			play("closed");
		}
	
		public function getTimeToOpen(): Number
		{
			return timeToOpen;
		}
	
		public function getOpened(): Boolean
		{
			return opened;
		}
		
		public function setOpening(): void
		{
			play("opening");
		}
	
		public function openSavePoint(): void
		{
			opened=true;
			loadGraphic(
					Assets.OPEN_PIPE, // image to use
					false, // animated
					false, // don't generate "flipped" images since they're already in the image
					19, // width of each frame (in pixels)
					16 // height of each frame (in pixels)
			);
		}
	}
	
}