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
		 
		 private var saveStuff: FlxSave;
		 
		override public function create():void 
		{
			saveStuff = new FlxSave();
		
			var _loaded: Boolean = saveStuff.bind("levelNameData");
			
			if(!_loaded)
			{
				LEVEL = new dungeonLevel1(new FlxPoint(3712, 2784),new FlxPoint(16, 16)); 
			}
			else
			{
				if(saveStuff.data.levelName==null)
				{
					saveStuff.data.levelName="Dungeon";
					LEVEL = new dungeonLevel1(new FlxPoint(3712, 2784),new FlxPoint(16, 16)); 
				}
				else
				{
					//Load level based on levelName
					if(saveStuff.data.levelName=="Dungeon")
					{
						LEVEL = new dungeonLevel1(new FlxPoint(3712, 2784),new FlxPoint(16, 16)); 
					}
					else if(saveStuff.data.levelName=="Kitchen")
					{
						LEVEL = new kitchenLevel(new FlxPoint(3424, 2592),new FlxPoint(16, 16));
					}
				}
			}
			
			//Testing purposes
			//LEVEL = new dungeonLevel1(new FlxPoint(3712, 2784),new FlxPoint(16, 16)); 
			this.add(LEVEL);
			
		}
		
		
		//This is called once per frame. Like Update in Unity3D.
		override public function update(): void {
			//See if we should transfer the level
			var LEVEL2: TopDownLevel = LEVEL.transferLevel();
			
			
			if (FlxG.keys.pressed("X"))
			{
				saveStuff.erase();
			}
			
			/**
			* If we've got a new level to transfer to, let's get rid of the old one and 
			* add the new one
			*/
			if(LEVEL2!=null)
			{
				saveStuff.data.levelName = LEVEL2.getLevelName();
			
				this.remove(LEVEL);
				LEVEL=null;
				LEVEL = LEVEL2;
				this.add(LEVEL);
			}
		
			
		
			super.update();
		
		}
		
		
	}
}
