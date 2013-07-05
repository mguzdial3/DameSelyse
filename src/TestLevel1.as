/**
 * Initialization code: new TestLevel1(new FlxPoint(224, 192),new FlxPoint(16, 16));
 * tilesize: 16
 */
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

		protected var decalGroup:FlxGroup;
		protected var objectGroup:FlxGroup;

		private var darkness:FlxSprite;
		private var playerLight:Light;

		public function TestLevel1(levelSize:FlxPoint, blockSize:FlxPoint):void {
			super(levelSize, blockSize, new FlxPoint(128,88));
		}

		override protected function createMap():void {
			var tiles:FlxTilemap;

			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(FLOORS, 14),
				Assets.FLOORS_TILE, tileSize.x, tileSize.y, 0, 0, 0, uint.MAX_VALUE
			);
			floorGroup.add(tiles);

			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(WALLS, 14),
				Assets.WALLS_TILE, tileSize.x, tileSize.y
			);
			wallGroup.add(tiles);

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

			currRoom = room1; //replace with room of your choice

			createObjects();
		}

		protected function createObjects():void {
			var sprite:FlxSprite;
			decalGroup = new FlxGroup();
			objectGroup = new FlxGroup();
		}

		override protected function createPlayer():void {
			player = new Player(playerStart.x, playerStart.y);
		}

		override protected function createGUI():void {
		}

		override protected function addGroups(): void {
			add(floorGroup);
			add(wallGroup);
			add(decalGroup);
			add(objectGroup);
			add(player);
			add(player.mySprite);
			add(playerLight);
			add(darkness);
			add(guiGroup);
		}

		override public function draw():void {
			darkness.fill(0xff000000);
			super.draw();
		}

		override public function transferLevel(): TopDownLevel{
			return null;
		}

		override public function update():void {
			super.update();
			playerLight.x = (player.x+player.width/2);
			playerLight.y = (player.y-player.height/2);
			FlxG.collide(objectGroup, player);
		}
	}
}