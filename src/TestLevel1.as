package 
{
	import org.flixel.*;
	
	public class TestLevel1 extends TopDownLevel
	{
		/** 
		 * FLOORS layer 
		 * tilesheet: floor_wood_opengameart 
		 */ 
		protected static var FLOORS:Array = new Array( 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
		); 

		/** 
		 * WALLS layer 
		 * tilesheet: walls_opengameart 
		 */ 
		protected static var WALLS:Array = new Array( 
			0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 8, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 8, 0, 0, 0, 
			0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 8, 0, 0, 0, 
			1, 2, 2, 2, 3, 0, 6, 0, 0, 0, 8, 0, 0, 0, 
			6, 0, 0, 0, 8, 2, 2, 2, 0, 2, 2, 0, 0, 0, 
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 3, 
			6, 0, 0, 0, 8, 2, 2, 2, 2, 3, 0, 0, 0, 8, 
			5, 5, 5, 5, 5, 0, 0, 0, 0, 8, 0, 0, 0, 8, 
			0, 0, 0, 0, 0, 0, 1, 7, 0, 8, 0, 0, 0, 8, 
			0, 0, 0, 0, 0, 0, 6, 0, 0, 8, 0, 0, 0, 8, 
			0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2 
		); 
		
		
		/**
		 * Custom groups
		 */
		protected var decalGroup:FlxGroup; // extra decorative elements (no collisions)
		protected var objectGroup:FlxGroup; // objects and obstacles (with collisions)
		
		/**
		 * Game objects
		 */
		protected var bookcase:FlxSprite;
		protected var armor:FlxSprite;
		protected var table:FlxSprite;
		protected var bed:FlxSprite;
		
		//Darkness
		private var darkness:FlxSprite;
		private var playerLight:Light;
		
		
		/**
		 * Constructor
		 * @param	state		State displaying the level
		 * @param	levelSize	Width and height of level (in pixels)
		 * @param	blockSize	Default width and height of each tile (in pixels)
		 */
		public function TestLevel1(levelSize:FlxPoint, blockSize:FlxPoint):void {
			super(levelSize, blockSize, new FlxPoint(120,88));
		}
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		override protected function createMap():void {
			var tiles:FlxTilemap;
			// floors
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(FLOORS, 14), // convert our array of tile indices to a format flixel understands
				Assets.FLOORS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y, // height of each tile (in pixels)
				0, // don't use auto tiling (needed so we can change the rest of these values)
				0, // starting index for our tileset (0 = include everything in the image)
				0, // starting index for drawing our tileset (0 = every tile is drawn)
				uint.MAX_VALUE // which tiles allow collisions by default (uint.MAX_VALUE = no collisions)
			);
			floorGroup.add(tiles);
			// walls
			// FFV: make left/right walls' use custom collision rects
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(WALLS, 14), // convert our array of tile indices to a format flixel understands
				Assets.WALLS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y // height of each tile (in pixels)
			);
			wallGroup.add(tiles);
			
			
			//light and darkness
			darkness = new FlxSprite(0,0);
			
      		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
      		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
      		darkness.blend = "multiply";
			
			playerLight = new Light(Assets.LightImageClass, FlxG.width / 2, FlxG.height / 2, darkness);
			

			//room data
			var room0:Room = new Room(new FlxPoint(-22,56), new FlxPoint(91,92), new FlxPoint(23,102));
			var room1:Room = new Room(new FlxPoint(52,72), new FlxPoint(112,59), new FlxPoint(108,102));
			var room2:Room = new Room(new FlxPoint(75,-7), new FlxPoint(84,90), new FlxPoint(117,38));
			var room3:Room = new Room(new FlxPoint(136,104), new FlxPoint(75,82), new FlxPoint(174,145));

			//room0's neighbors
			room0.addNeighbor(room1); 

			//room1's neighbors
			room1.addNeighbor(room0); 
			room1.addNeighbor(room2); 
			room1.addNeighbor(room3); 

			//room2's neighbors
			room2.addNeighbor(room1); 

			//room3's neighbors
			room3.addNeighbor(room1); 

			super.currRoom = room1;

			// objects
			createObjects();
		}
		
		/**
		 * Add all the objects, obstacles, etc to the level
		 */
		protected function createObjects():void {
			var sprite:FlxSprite;
			// create custom groups
			decalGroup = new FlxGroup();
			objectGroup = new FlxGroup();

			/*
			// decals (decorative elements that have no functionality)
			sprite = new FlxSprite(
				16, // x location
				16, // y location
				Assets.RUG1_SPRITE // image to use
			);
			decalGroup.add(sprite);
			
			
			
			sprite = new FlxSprite(
				11 * tileSize.x, // x location (using tileSize to align it with a tile)
				1.5 * tileSize.y, // y location (showing that you don't need to line up with a tile)
				Assets.RUG2_SPRITE // image to use
			);
			decalGroup.add(sprite);
			// objects and obstacles
			// NOTE: this group gets tested for collisions
			bookcase = new FlxSprite(
				32, // x location
				0, // y location (showing that you can overlap with the walls if you want)
				Assets.BOOKCASE_SPRITE // image to use
			);
			bookcase.immovable = true; // don't allow the player to move this object
			objectGroup.add(bookcase);
			
			table = new FlxSprite(192, 192, Assets.TABLEROUND_SPRITE);
			table.immovable = true;
			objectGroup.add(table);
			
			sprite = new FlxSprite(176, 192, Assets.CHAIRRIGHT_SPRITE);
			sprite.immovable = true;
			objectGroup.add(sprite);
			
			sprite = new FlxSprite(216, 192, Assets.CHAIRLEFT_SPRITE);
			sprite.immovable = true;
			objectGroup.add(sprite);
			
			armor = new FlxSprite(192, 0, Assets.ARMOR_SPRITE);
			armor.immovable = true;
			objectGroup.add(armor);
			
			bed = new FlxSprite(16, 192, Assets.BED_SPRITE);
			bed.immovable = true;
			objectGroup.add(bed);
			*/
		}
		
		/**
		 * Create the player
		 */
		override protected function createPlayer():void {
			player = new Player(playerStart.x, playerStart.y);
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		override protected function createGUI():void {
			var instructions:FlxText = new FlxText(0, 0, levelSize.x, "Use ARROW keys to walk around");
			instructions.alignment = "center";
			guiGroup.add(instructions);
		}
		
		/**
		 * Decide the order of the groups. They are rendered in the order they're added, so last added is always on top.
		 */
		override protected function addGroups():void {
			add(floorGroup);
			add(wallGroup);
			add(decalGroup);
			add(objectGroup);
			add(player);
			add(player.mySprite);
			
			/*
			 var light:Light = new Light(Assets.LightImageClass, FlxG.width / 2, FlxG.height / 2, darkness, 0xFFFFDDFF);
    		add(light);
    		 var light2:Light = new Light(Assets.LightImageClass, FlxG.width / 4, FlxG.height / 4, darkness, 0xFFFFFFDD);
    		add(light2);
    		 var light3:Light = new Light(Assets.LightImageClass, FlxG.width*3/ 4, FlxG.height*3/ 4, darkness, 0xFFDDFFFF);
    		add(light3);
    		var light4:Light = new Light(Assets.LightImageClass, FlxG.width/ 4, FlxG.height*3/ 4, darkness, 0xFFFFFFCC);
    		add(light4);
    		var light5:Light = new Light(Assets.LightImageClass, FlxG.width*3/ 4, FlxG.height/ 4, darkness, 0xFFFFFFCC);
    		add(light5);
			*/
			
			add(playerLight);
			
			
			
			add(darkness);
			
			
			add(guiGroup);
		}
		override public function draw():void {
 		  darkness.fill(0xff000000);
   			super.draw();
 			}
		
		override public function transferLevel(): TopDownLevel{
			/*
			if(player.x>220)
			{
				return new PlainHouseLevel(levelSize,tileSize);
			}
			else
			{
				return null;
			}
			*/
			return null;
		}
		
		
		/**
		 * Update each timestep
		 */
		override public function update():void {
			super.update(); // NOTE: map -> player collision happens in super.update()
			playerLight.x=(player.x+player.width/2);
			playerLight.y = (player.y-player.height/2);
			FlxG.collide(objectGroup, player);
			
			
		}
	}
}