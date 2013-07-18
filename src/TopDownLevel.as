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
		public var foreGroundGroup:FlxGroup; // foreground (rendered above the walls - no collisions)
		public var guiGroup:FlxGroup; // gui elements
		
		/**
		 * Player
		 */
		public var player:Player;
		public var playerStart:FlxPoint;
		
		/**
		*Moving Camera Stuff
		*/
		public var currRoom: Room; //Has to be public to be accessible in children, representation of current room 
		private var cameraPoint: FlxPoint; //Current place the camera is focusing on
		private var goalPoint: FlxPoint; //The goal position for the camera point
		protected var movingToGoal: Boolean; //Whether or not we're currently moving towards the goal
		
		/**
		* level stuff
		*/
		
		protected var reloadThisLevel: Boolean;
		
		/**
		* Game State Stuff
		*/
		protected var currState: int;
		protected static const NORMAL_GAMEPLAY:int=0;
		protected static const QUESTION_TIME:int=1;
		
		/**
		 * Question Stuff
		 */
		 
		 protected var questionText: FlxText;
		 protected var answerUp: FlxText; //0
		 protected var answerRight: FlxText; //1
		 protected var answerDown: FlxText; //2
		 protected var answerLeft: FlxText; //3
		 protected var correctAnswer: int;
		 
		 
		 /**
		 * Outfit stuff
		 */
		 protected var legOutfit: PlayerOutfit;
		 protected var bodyOutfit:PlayerOutfit;
		 protected var headOutfit:PlayerOutfit;
		 
		
		
		/**
		 * Constructor
		 * @param	state		State displaying the level
		 * @param	levelSize	Width and height of level (in pixels)
		 * @param	blockSize	Default width and height of each tile (in pixels)
		 */
		public function TopDownLevel( levelSize:FlxPoint, tileSize:FlxPoint, _playerStart: FlxPoint):void 
		{
			super();
			reloadThisLevel=false;
			
			this.levelSize = levelSize;
			this.tileSize = tileSize;
			if (levelSize && tileSize)
				this.numTiles = new FlxPoint(Math.floor(levelSize.x / tileSize.x), Math.floor(levelSize.y / tileSize.y));
			// setup groups
			this.floorGroup = new FlxGroup();
			this.wallGroup = new FlxGroup();
			this.foreGroundGroup = new FlxGroup();
			this.guiGroup = new FlxGroup();
			
			this.playerStart=_playerStart;
			
			
			FlxG.camera.setBounds(0, 0, levelSize.x, levelSize.y); 
			
			
			// create the level
			this.create();
		}
		
		public function focusOnCurrRoom(): void
		{
			cameraPoint = currRoom.getCameraPosition();
			goalPoint = currRoom.getCameraPosition();
			movingToGoal = false;	
			FlxG.camera.focusOn(currRoom.getCameraPosition());
		}

		public function reloadLevel(): void
		{
			reloadThisLevel=true;
		}
		
		/**
		 * Create the whole level, including all sprites, maps, blocks, etc
		 * This method is called automatically, the equivalent of Unity3D's Start
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
		*Room transfer logic
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
		*
		*
		* Also to be made use of in terms of reloading this specific level
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
			player = new Player(playerStart.x, playerStart.y);
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		protected function createGUI():void 
		{
		}
		
		/**
		 * Set the current game State
		 */
		protected function setGameState(gameState:int):void
		{
			currState=gameState;
		}		
		
		protected function movingCamera(): void
		{
			var mDistance: Number = manhattanDistance(cameraPoint,goalPoint);
			
			//WARNING: NO LERP
			if(mDistance<20000)
			{
				cameraPoint = goalPoint;
				movingToGoal=false;
			}
			else
			{
				cameraPoint.x += 2*(goalPoint.x-cameraPoint.x)/Math.abs((goalPoint.x-cameraPoint.x));
				cameraPoint.y += 2*(goalPoint.y-cameraPoint.y)/Math.abs((goalPoint.y-cameraPoint.y));
				
			}
			
			//FlxG.camera.focusOn(cameraPoint);
			FlxG.camera.scroll.x = cameraPoint.x-FlxG.camera.width/2;
			FlxG.camera.scroll.y = cameraPoint.y-FlxG.camera.height/2;
			
			//FlxG.camera.x = cameraPoint.x-FlxG.camera.width/2;
			//FlxG.camera.y= cameraPoint.y-FlxG.camera.height/2;
			//GOT TO BE A BETTER WAY TO DO THIS
			
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
			if(currState==NORMAL_GAMEPLAY)
			{
				normalGameplay();
			}
			else if(currState==QUESTION_TIME)
			{
				questionGameplay();
			}
		}
		
		public function normalGameplay():void
		{
			
			roomTransfer(player.center);
			FlxG.collide(wallGroup, player);
			
			if(movingToGoal)
			{
				movingCamera();
			}
		}
		
		public function questionGameplay():void
		{
			
		}
		
	}
}
