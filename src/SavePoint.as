package 
{
	import org.flixel.*;
	
	public class SavePoint extends FlxSprite
	{
		private var opened:Boolean;
		private var timeToOpen: Number;
		private var flipped:Boolean;
		private var exiting:Boolean;
	
		public function SavePoint(X:Number,  Y:Number,  _flipped:Boolean=false,  _timeToOpen:Number=1 )
		{
			super(X, Y);
	
			opened=false;
			flipped=_flipped;
			timeToOpen = _timeToOpen;	
		
		
			if(!flipped)
			{
				if(opened)
				{
					opened= true;
					loadGraphic(
						Assets.OPEN_PIPE, // image to use
						false, // animated
						false, // don't generate "flipped" images since they're already in the image
						22, // width of each frame (in pixels)
						28 // height of each frame (in pixels)
					);
					
					this.y+=5;
				}
				else
				{
					loadGraphic(
							Assets.CLOSED_PIPE, // image to use
							true, // animated
							false, // don't generate "flipped" images since they're already in the image
							22, // width of each frame (in pixels)
							33 // height of each frame (in pixels)
					);
					//Set up animations
					addAnimation("closed", [0]);
					addAnimation("opening", [0,1,2,0,1,2,0,1,2,3,4,5],12);
		
					play("closed");
				}	
			}
			else
			{
				if(opened)
				{
					opened= true;
					loadGraphic(
						Assets.OPEN_PIPE_FLIP, // image to use
						false, // animated
						false, // don't generate "flipped" images since they're already in the image
						22, // width of each frame (in pixels)
						28 // height of each frame (in pixels)
					);
					
					this.y+=5;
				}
				else
				{
					loadGraphic(
							Assets.CLOSED_PIPE_FLIP, // image to use
							true, // animated
							false, // don't generate "flipped" images since they're already in the image
							22, // width of each frame (in pixels)
							33 // height of each frame (in pixels)
					);
					//Set up animations
					addAnimation("closed", [0]);
					addAnimation("opening", [0,1,2,0,1,2,0,1,2,3,4,5],12);
		
					play("closed");
				}
			}
			
			immovable = true;
			
			
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
		
		
		public function loadExit(): void
		{
			opened=true;
			
			loadGraphic(
					Assets.PIPE_EXIT, // image to use
					true, // animated
					false, // don't generate "flipped" images since they're already in the image
					22, // width of each frame (in pixels)
					33 // height of each frame (in pixels)
			);
			//Set up animations
			//addAnimation("exiting", [0,0,1,1,2,2,3,3,4,5,6,7,7,8],15);
			addAnimation("exiting", [0,1,1,2,3,4,5,6,7,8],13);
			
			play("exiting");
			exiting=true;
		}
	
		public function openSavePoint(): void
		{
			opened=true;
			
			if(!flipped)
			{
				loadGraphic(
						Assets.OPEN_PIPE, // image to use
						false, // animated
						false, // don't generate "flipped" images since they're already in the image
						22, // width of each frame (in pixels)
						28 // height of each frame (in pixels)
				);
			
				//Since we go from 19 to 24
				this.y+=5;
			}
			else
			{
				loadGraphic(
						Assets.OPEN_PIPE_FLIP, // image to use
						false, // animated
						false, // don't generate "flipped" images since they're already in the image
						22, // width of each frame (in pixels)
						33 // height of each frame (in pixels)
				);
				
				//this.x+=1;
			
			}
		}
		
		public function exitThing():Boolean 
		{
		
			if(exiting)
			{
				if(this.finished)
				{
					loadGraphic(
						Assets.OPEN_PIPE, // image to use
						false, // animated
						false, // don't generate "flipped" images since they're already in the image
						22, // width of each frame (in pixels)
						28 // height of each frame (in pixels)
					);
			
					this.y+=5; //4 instead of 5
					
					exiting = false;
					
					return true;
				}
			}
			
			return false;
		}
	}
	
}