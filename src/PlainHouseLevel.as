package 
{
	import org.flixel.*;
	
	public class PlainHouseLevel extends TopDownLevel
	{
		/**
		 * Floor layer
		 */
		protected static var FLOORS:Array = new Array(
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		);
		
		/**
		 * Wall layer
		 */
		protected static var WALLS:Array = new Array(
			1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		);
		
		
		[Embed(source="/assets/light.png")]
   	 	private var LightImageClass:Class;
		
		
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
		public function PlainHouseLevel(levelSize:FlxPoint, blockSize:FlxPoint):void {
			super( levelSize, blockSize, new FlxPoint(120,120));
		}
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		override protected function createMap():void {
			var tiles:FlxTilemap;
			// floors
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(FLOORS, 27), // convert our array of tile indices to a format flixel understands
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
				FlxTilemap.arrayToCSV(WALLS, 27), // convert our array of tile indices to a format flixel understands
				Assets.WALLS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y // height of each tile (in pixels)
			);
			wallGroup.add(tiles);
			
			darkness = new FlxSprite(0,0);
			
			//424, 272
			super.currRoom = new Room(new FlxPoint(0,0),new FlxPoint(240,240),new FlxPoint(120,120));
			var roomRight:Room = new Room(new FlxPoint(245,0), new FlxPoint(184,240), new FlxPoint(330,120));
			var roomLow: Room = new Room(new FlxPoint(240,240), new FlxPoint(184,32), new FlxPoint(330,256));
			
			super.currRoom.addNeighbor(roomRight);
			roomRight.addNeighbor(super.currRoom);
			roomRight.addNeighbor(roomLow);
			roomLow.addNeighbor(super.currRoom);
			
      		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
      		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
      		darkness.blend = "multiply";
			
			playerLight = new Light(LightImageClass, FlxG.width / 2, FlxG.height / 2, darkness);
			
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
			
			/**
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
			//objectGroup.add(armor);
			
			bed = new FlxSprite(16, 192, Assets.BED_SPRITE);
			bed.immovable = true;
			//objectGroup.add(bed);
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
			
			 var light:Light = new Light(LightImageClass, FlxG.width / 2, FlxG.height / 2, darkness, 0xFFFFDDFF);
    		add(light);
    		 var light2:Light = new Light(LightImageClass, FlxG.width / 4, FlxG.height / 4, darkness, 0xFFFFFFDD);
    		add(light2);
    		 var light3:Light = new Light(LightImageClass, FlxG.width*3/ 4, FlxG.height*3/ 4, darkness, 0xFFDDFFFF);
    		add(light3);
    		var light4:Light = new Light(LightImageClass, FlxG.width/ 4, FlxG.height*3/ 4, darkness, 0xFFFFFFCC);
    		add(light4);
    		var light5:Light = new Light(LightImageClass, FlxG.width*3/ 4, FlxG.height/ 4, darkness, 0xFFFFFFCC);
    		add(light5);
			
			
			add(playerLight);
			
			
			
			add(darkness);
			
			
			add(guiGroup);
		}
		override public function draw():void {
 		  darkness.fill(0xff000000);
   			super.draw();
 		}
		
		
		/**
		 * Update each timestep
		 */
		override public function update():void {
			super.update(); // NOTE: map -> player collision happens in super.update()
			playerLight.x=(player.x+player.width/2);
			playerLight.y = (player.y-player.height/2);
			FlxG.collide(objectGroup, player);
			//if(!currRoom.within(new FlxPoint(player.x,player.y)))
			//{
				
			
				//cameraPoint.x=360;
			//}
				
		}
	}
}