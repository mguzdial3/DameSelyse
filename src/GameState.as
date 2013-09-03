package
{
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
	
		/**
		 * Current level
		 * NOTE: "public static" allows us to get info about the level from other classes
		 * if we wanna do that at some point
		 */
		public static var LEVEL:TopDownLevel = null;
		
		/**
		 * Create state
		 */
		 
		override public function create():void 
		{
		
			//Do we need a mouse? I do not think so
			//FlxG.mouse.show();
			// load the first level (this level should then connect to the other levels)
			//LEVEL = new IndoorHouseLevel(new FlxPoint(424, 272),new FlxPoint(16, 16));
			//LEVEL = new showcaseMap1(new FlxPoint(992, 1184),new FlxPoint(16, 16));
			//LEVEL = new firstRoom(new FlxPoint(928, 704),new FlxPoint(16, 16));
			LEVEL = new dungeonLevel(new FlxPoint(4192, 3424),new FlxPoint(16, 16));//new FlxPoint(2592, 2080),new FlxPoint(16, 16));
			//LEVEL = new firstAttempt4(new FlxPoint(4192, 3424),new FlxPoint(16, 16));
			//LEVEL = new testLevel(new FlxPoint(480, 256),new FlxPoint(16, 16));
			//Adding the LEVEL variable adds everything added to the LEVEL variable object 
			this.add(LEVEL);
		
		}
		
		
		//This is called once per frame. Like Update in Unity3D.
		override public function update(): void {
			//See if we should transfer the level
			var LEVEL2: TopDownLevel = LEVEL.transferLevel();
			
			/**
			* If we've got a new level to transfer to, let's get rid of the old one and 
			* add the new one
			*/
			if(LEVEL2!=null)
			{
				this.remove(LEVEL);
				LEVEL=null;
				LEVEL = LEVEL2;
				this.add(LEVEL);
			}
		
			
		
			super.update();
		
		}
		
		
	}
}
