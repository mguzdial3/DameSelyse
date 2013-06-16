package 
{
	import org.flixel.*;
	
	public class TopDownLevel extends FlxGroup
	{
		/**
		 * Map
		 */
		public var levelSize:FlxPoint; // width and height of level (in pixels)
		public var tileSize:FlxPoint; // default width and height of each tile (in pixels)
		public var numTiles:FlxPoint; // how many tiles are in this level (width and height)
		public var floorGroup:FlxGroup; // floor (rendered beneath the walls - no collisions)
		public var wallGroup:FlxGroup; // all the map blocks (with collisions)
		public var guiGroup:FlxGroup; // gui elements
		
		/**
		 * Player
		 */
		public var player:TopDownEntity;
		public var playerStart:FlxPoint;
		
		/**
		*Moving Camera Stuff
		*/
		public var currRoom: Room; //Has to be public to be accessible in children
		private var cameraPoint: FlxPoint;
		private var goalPoint: FlxPoint;
		private var movingToGoal: Boolean;
		
		
		/**
		 * Constructor
		 * @param	state		State displaying the level
		 * @param	levelSize	Width and height of level (in pixels)
		 * @param	blockSize	Default width and height of each tile (in pixels)
		 */
		public function TopDownLevel( levelSize:FlxPoint, tileSize:FlxPoint, _playerStart: FlxPoint):void 
		{
			super();
			this.levelSize = levelSize;
			this.tileSize = tileSize;
			if (levelSize && tileSize)
				this.numTiles = new FlxPoint(Math.floor(levelSize.x / tileSize.x), Math.floor(levelSize.y / tileSize.y));
			// setup groups
			this.floorGroup = new FlxGroup();
			this.wallGroup = new FlxGroup();
			this.guiGroup = new FlxGroup();
			
			this.playerStart=_playerStart;
			
			
			
			cameraPoint = new FlxPoint(playerStart.x,playerStart.y);
			goalPoint = new FlxPoint(playerStart.x,playerStart.y);
			movingToGoal = false;
			
			
			// create the level
			this.create();
		}
		
		/**
		 * Create the whole level, including all sprites, maps, blocks, etc
		 */
		public function create():void 
		{
			createMap();
			createPlayer();
			createGUI();
			addGroups();
			createCamera();
		}
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		protected function createMap():void 
		{
		}
		
		/**
		*Room transfer logical
		* Pass in center of player
		*/
		public function roomTransfer(point: FlxPoint):void
		{
			if(currRoom!=null)
			{
			
				var thisRoom: Room = currRoom.checkRooms(point);
				
				if(thisRoom!=null)
				{
					currRoom=thisRoom;
					goalPoint = currRoom.getCameraPosition();
					movingToGoal = true;
				}
				
			}
		
		}
		
		
		/**
		* Returns the next level to go to if we should transfer the level, null otherwise
		*/
		public function transferLevel(): TopDownLevel
		{
			return null;
		}
		
		
				
		/**
		 * Create the player, bullets, etc
		 */
		protected function createPlayer():void 
		{
			player = new TopDownEntity(Assets.RANGER_SPRITE, new FlxPoint(16,2), new FlxPoint(16,18), playerStart.x, playerStart.y);
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		protected function createGUI():void 
		{
		}
		
		
		private function movingCamera(): void
		{
			var mDistance: Number = manhattanDistance(cameraPoint,goalPoint);
			
			if(mDistance<1)
			{
				cameraPoint = goalPoint;
				movingToGoal=false;
			}
			else
			{
				cameraPoint.x += 2*(goalPoint.x-cameraPoint.x)/Math.abs((goalPoint.x-cameraPoint.x));
				cameraPoint.y += 2*(goalPoint.y-cameraPoint.y)/Math.abs((goalPoint.y-cameraPoint.y));
				
			}
			
			FlxG.camera.focusOn(cameraPoint);
		}
		
		/**
		 * Decide the order of the groups. They are rendered in the order they're added, so last added is always on top.
		 */
		protected function addGroups():void 
		{
			add(floorGroup);
			add(wallGroup);
			add(player);
			//Sprite of player has to be added too
			add(player.mySprite);
			add(guiGroup);
		}
		
		/**
		 *Simple manhattan distance (public so we can use it later)
		 */
		public function manhattanDistance(firstPoint: FlxPoint, secondPoint: FlxPoint): Number
		{
			var distanceBetween: Number = Math.sqrt(Math.pow((secondPoint.x-firstPoint.x),2)
			+ Math.pow((secondPoint.y-firstPoint.y),2));
			
			return distanceBetween;
		}
		
		
		/**
		 * Create the default camera for this level
		 */
		protected function createCamera():void {
			FlxG.worldBounds = new FlxRect(0, 0, levelSize.x, levelSize.y);
			FlxG.camera.setBounds(0, 0, levelSize.x, levelSize.y, true);
		}
		
		/**
		 * Update each timestep
		 */
		override public function update():void {
			super.update();
			roomTransfer(player.center);
			FlxG.collide(wallGroup, player);
			
			if(movingToGoal)
			{
				movingCamera();
			}
		}
	}
}
