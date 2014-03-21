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
		protected var objectGroup:FlxGroup;
		
		
		public static var debugString:String;
		
		/**
		 * player
		 */
		public var player:Player;
		public var playerStart:FlxPoint;
		
		
		/**
		* level stuff
		*/
		
		protected var reloadThisLevel: Boolean;
		
		/**
		* Game State Stuff
		*/
		protected var currState: int;
		protected var prevState: int;
		protected static const NORMAL_GAMEPLAY:int=0;
		protected static const QUESTION_TIME:int=1;
		protected static const INVENTORY_GAMEPLAY:int=2;
		protected static const HIDING_GAMEPLAY:int=3;
		protected static const SAVING_GAMEPLAY:int=4;
		protected static const DIALOG_GAMEPLAY:int=5;
		
		/**
		 * Question Stuff
		 */
		 protected var answers: Vector.<EnemyAnswer>;
		 protected var responses: Vector.<DialogNode>;
		 protected var answerDisplays: Vector.<FlxText>;
		
		/*
		* Light stuff
		*/
		protected var darkness:FlxSprite;
		protected var playerLight:Light;


		/**
		* Enemy controller and question time stuff
		*/
		protected var enemyController:EnemyController;
		protected var questionTimer: Number; //Timer for the amount of time you have to answer an enemy question
		protected var questionTimerDisplay: FlxText;
		
		//DialogHandler
		protected var dialogHandler: DialogHandler;
		
		//List of dialogue triggers
		protected var dialogueTriggers: Vector.<DialogueTriggerZone>;
		
		
		
		
		//Just the Menu(M) text in the upper right corner
		protected var menuText:FlxText;
		
		//Inventory
		protected var inventory: Inventory;
		
		//WaterDrops grounp
		protected var waterDrops: Vector.<FlxSprite>;
		//Text for score
		protected var dropletText: FlxText;
		 
		protected var allKeysUp: Boolean = false;
		 
		 /**
		 * Outfit stuff
		 */
		 protected var legOutfit: PlayerOutfit;
		 protected var bodyOutfit:PlayerOutfit;
		 protected var headOutfit:PlayerOutfit;
		
		//HideableObjects
		protected var hideableObjects: Vector.<HideableObject>; //List of all hdieableObjects
		protected var hideableObjectIndex: int; //Current index of object we're looking at
		protected var hidingTimer : Number; //The amount of time till we're done hiding/unhiding
		protected var hidingLocation:FlxPoint; 
		//HideableObjects Loading Bar
		protected var hidingBarBackground: FlxSprite;
		protected var hidingBar:FlxSprite;
		 
		
		//Debug
		protected var debugText: FlxText;
		public static var printText:FlxText;
		public static var printText2:FlxText;
		
		//Saving Stuff
		protected var saver: FlxSave;
		protected var savePoints: Vector.<SavePoint>;//List of all save points
		protected var saveTimer: Number;//Amount of time till we're done opening a closed save point
		protected var saveIndex: int; //The index of the save we're currently working with
		//Change this line to reset save stuff
		private var resetSave: Boolean=false;


		private var enemyTimer:int = 12;
		
		//Level Names
		public var levelName: String;
		
		//Clothing Lights
		protected var legsLight: Light;
		protected var bodyLight: Light;
		protected var headLight: Light;
		
		
		//Question Gameplay countdown sound
		protected var questioningSound: FlxSound;
		
		private var cameraScrolling:Boolean=false;
		private var cameraSpeed:int=4;

		//Max Drops
		private var maxDrops:int;
		
		//Seconds
		protected var currSeconds:Number;
		
		/**
		 * Constructor
		 * @param	state		State displaying the level
		 * @param	levelSize	Width and height of level (in pixels)
		 * @param	blockSize	Default width and height of each tile (in pixels)
		 */
		public function TopDownLevel( levelSize:FlxPoint, tileSize:FlxPoint, _playerStart: FlxPoint, _levelName: String="NAN"):void 
		{
			super();
			
			levelName = _levelName;
			
			FlxG.mouse.hide();
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
			
			enemyTimer= 10;
			
			currSeconds=0;
			
			FlxG.camera.setBounds(0, 0, levelSize.x, levelSize.y); 
			
			//Initialization
			answers = new Vector.<EnemyAnswer>();
		 	answerDisplays = new Vector.<FlxText>;
			
			
			//Sound init
			questioningSound = new FlxSound();
			questioningSound.loadEmbedded(Assets.COUNTDOWN_NOISE);
			
			
			// create the level
			this.create();
			
			saver = new FlxSave();
			saveTimer=0;
			
			
			printText2 =new FlxText(20, 40, 300, "Print");
			printText2.alignment = "right";
			printText2.scrollFactor = new FlxPoint(0, 0);
			printText2.text = "Print2";
			//guiGroup.add(printText2);
			
			if(checkSaveSetup())
			{
			
				setUpSaveInformation();
				loadInformation();
				
			}
			else
			{
				loadInformation();
				
				
				
			}
			
			
			//Hooks the inventory up to the player
			inventory = new Inventory(player.getOutfitHandler());
			
			add(dialogHandler);
			
			
			//Sets up the timer for the question
			questionTimerDisplay = new FlxText(120,100,80,"");
			questionTimerDisplay.alignment = "center";
			questionTimerDisplay.color = 0xFFFF0000;
			questionTimerDisplay.size = 30;
			questionTimerDisplay.scrollFactor.x = questionTimerDisplay.scrollFactor.y = 0;
			
			//Sets up and adds the menu text
			menuText = new FlxText(242,-2,80, "Menu(M)");
			menuText.setFormat("TEST", 8, 0xffffffff, "right");
			menuText.scrollFactor.x = menuText.scrollFactor.y = 0;
			add(menuText);
			
			dropletText =new FlxText(262, 8, 60, "0/"+player.getMaxDrops());
			dropletText.setFormat("TEST", 8, 0xff4f7fcf, "right");
			dropletText.scrollFactor = new FlxPoint(0, 0);
			guiGroup.add(dropletText);
			
			printText =new FlxText(280, 60, 40, "");
			printText.alignment = "right";
			printText.scrollFactor = new FlxPoint(0, 0);
			printText.text = "";
			guiGroup.add(printText);
			debugString = "Debug";
			
			//ITEM BOX
			/**
			var textBox:FlxSprite = new FlxSprite(296,21,Assets.ITEM_BOX);
			textBox.scrollFactor = new FlxPoint(0,0);
			guiGroup.add(textBox);
			*/
			//WATER DROPLET -WATER_DROPLET
			var waterDrop:FlxSprite = new FlxSprite(290,10,Assets.WATER_DROPLET);
			waterDrop.scrollFactor = new FlxPoint(0,0);
			guiGroup.add(waterDrop);
			
			//debugText = new FlxText(FlxG.camera.scroll.x,FlxG.camera.scroll.y,100);
			//debugText.alignment = "right";
			//debugText.scrollFactor = new FlxPoint(0, 0);
			//guiGroup.add(debugText);
			
			
			hidingTimer=0;
			
			
			
			//Potentially particle effect to outfits more obvious

			//MiniMap
			/**
			wallStamp = new FlxSprite();
			wallStamp.makeGraphic(2,2,0xff000000);
			playerStamp = new FlxSprite();
			playerStamp.makeGraphic(2,2,0xffff0000);
			map = new FlxSprite();
			map.makeGraphic(80,60,0xffffffff);
			add(map);
			*/
			
			//add(dropletText);
			
			if(cameraScrolling)
			{
				FlxG.camera.scroll.x = player.x-100;
				FlxG.camera.scroll.y = player.y-100;
			}
		}
		
		
		
		

		public function reloadLevel(): void
		{
			if(FlxG.music!=null)
			{
				FlxG.music.stop();
			}
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
			addHideableObjects();
			createWaterDroplets();
			savePointCreation();
			addEnemies();
			addGroups();
			setUpLevelSpecificAssets();
			
			
			
			createGUI();
			createCamera();
			
		}
		
		
		//Sets up all dialogue for this level and the various dialogue peoples
		//And sets up various other level specific stuff
		protected function setUpLevelSpecificAssets(): void
		{
			//Dialog Handler has to be above everything else
			dialogHandler = new DialogHandler();
			
			//Set up DialogTriggers
			dialogueTriggers = new Vector.<DialogueTriggerZone>();
		}
		
		
		
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		protected function createMap():void 
		{
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
		
		protected function addHideableObjects():void
		{
			//HideableObject thing
			hideableObjects = new Vector.<HideableObject>();
			
			hideableObjectIndex = -1;
		}
				
		/**
		 * Create the player, bullets, etc
		 */
		protected function createPlayer():void 
		{
			player = new Player(playerStart.x, playerStart.y);
			
			FlxG.camera.follow(player, 3);
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		protected function createGUI():void 
		{
			//280
			
			
			
			hidingBarBackground = new FlxSprite(0,0);
			hidingBarBackground.makeGraphic(16,5, 0xaaaaaaaa);
			add(hidingBarBackground);
			
			hidingBar = new FlxSprite(0,0);
			hidingBar.makeGraphic(16,5, 0xaaffffff);
			hidingBar.scale.x=0;
			add(hidingBar);
		}
		
		/**
		*Create the water droplets
		*/
		protected function createWaterDroplets():void
		{
			waterDrops = new Vector.<FlxSprite>();
		}
		
		/**
		 * Set the current game State
		 */
		protected function setGameState(gameState:int):void
		{
		
			prevState = currState;
			currState=gameState;
		}		
		
		
		
		/**
		 * Decide the order of the groups. They are rendered in the order they're added, so last added is always on top.
		 */
		protected function addGroups():void 
		{
			add(floorGroup);
			add(wallGroup);
			add(player);
			add(guiGroup);
		}
		
		protected function addEnemies():void
		{
		
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
		
		
		//Called to determine if we have set up a save spot already
		protected function checkSaveSetup(): Boolean
		{
			var _loaded: Boolean = saver.bind("levelData"+levelName);
		
					
			return ((_loaded && (saver.data.playerX==null || 
			 saver.data.headOutfitGot==null 
			|| saver.data.bodyOutfitGot==null
			|| saver.data.legsOutfitGot==null
			||
			saver.data.playerY==null || saver.data.numDrops==null || saver.data.currSavePointIndex==null
			|| saver.data.dropsGrabbed ==null)
			||saver.data.timesCaught==null 
			|| saver.data.conversationsHad==null
			|| saver.data.levelTimeSeconds==null
			|| saver.data.levelMinutes==null)
			|| resetSave);
		}
		
		//Make the save points
		protected function savePointCreation(): void
		{
			savePoints = new Vector.<SavePoint>();
		}
		
		//Overrideable method for setting up save information (all save things are overrideable such that we can change
		//What is saved and how it's saved per level
		protected function setUpSaveInformation(): void
		{
			saver.data.playerX = playerStart.x;
			saver.data.playerY = playerStart.y;
			saver.data.numDrops=0; //Represents number of drops collected over all
			saver.data.timesCaught=0;
			saver.data.conversationsHad=0;
			saver.data.levelTimeSeconds=0.0;
			saver.data.levelMinutes=0;
			
			
			saver.data.currSavePointIndex = -1; //Represents the current open save point index
			saver.data.dropsGrabbed = new Array();
			
			
			
			saver.data.headOutfitGot=false;
			saver.data.bodyOutfitGot=false;
			saver.data.legsOutfitGot=false;
		}
		
		public function gameStateSave(): void
		{
			saveInformation();
		}
		
		//Overrideable save function 
		protected function saveInformation(): void
		{
			saver.data.playerX=player.x; 
			saver.data.playerY=player.y; 
			saver.data.numDrops+= player.getDrops();
			player.clearDrops();
			saver.data.currSavePointIndex = saveIndex;
			
			
			
			var i: int;
			for(i=0; i<waterDrops.length; i++)
			{
				//WARNING: Might be a problem later if the array gets too long
				if( !waterDrops[i].alive )
				{
					saver.data.dropsGrabbed.push(i);
				}
			}
			
			saver.data.headOutfitGot=headOutfit.getGrabbed();
			saver.data.bodyOutfitGot=bodyOutfit.getGrabbed();
			saver.data.legsOutfitGot=legOutfit.getGrabbed();
			
			saver.data.levelTimeSeconds+=currSeconds;
			currSeconds=0.0;
			
			if(saver.data.levelTimeSeconds>60)
			{
				var theseSeconds:Number = saver.data.levelTimeSeconds;
				
				var numMins:int = int(theseSeconds/60);
				
				saver.data.levelMinutes+=numMins;
				saver.data.levelTimeSeconds-=Number(numMins*60.0);
				
			}
			
			
			
			saver.flush();
			
		}
		
		//Overrideable load function
		protected function loadInformation(): void
		{
			if(saver.data.playerX!=null)
			{
				player.x = saver.data.playerX;
				player.y = saver.data.playerY;
			}	
			else
			{
				player.x = playerStart.x;
				player.y= playerStart.y;
			}
			
			
			
			//Change
				
			if(saver.data.currSavePointIndex!=-1)
			{
				savePoints[saver.data.currSavePointIndex].openSavePoint();
			}
			
			var i:int=0;
			var j:int = 0;
			//Water Drops check if it's been grabbed
			
			//Set the max number of water droplets
			maxDrops = waterDrops.length;
			
			for(i = 0; i<waterDrops.length; i++)
			{
				for(j=0; j<saver.data.dropsGrabbed.length; j++)
				{
					if(i==saver.data.dropsGrabbed[j])
					{
						waterDrops[i].kill();
					}
				}
			}
			
			saver.data.maxDrops = maxDrops;
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
			
			//printText2.text = "Sec"+int(currSeconds).toString();
			
			//Increment currSeconds
			currSeconds+=FlxG.elapsed;
			
			
			//printText2.text = "PlayerStart: "+int(player.x)+", "+int(player.y);
			if(cameraScrolling)
			{
			//Camera testing
				if (FlxG.keys.pressed("A"))
					FlxG.camera.scroll.x -= cameraSpeed;
				
				if (FlxG.keys.pressed("D"))
					FlxG.camera.scroll.x += cameraSpeed;
				
				if (FlxG.keys.pressed("W"))
					FlxG.camera.scroll.y -= cameraSpeed;
				
				if (FlxG.keys.pressed("S"))
					FlxG.camera.scroll.y += cameraSpeed;
			}
			var currentTime:Date = new Date();
			
			if(legsLight!=null)
			{
				if(currentTime.seconds%2==0)
				{
					legsLight.alpha = 0.5+0.5*(currentTime.milliseconds/1000);
				}
				else
				{
					legsLight.alpha = 1.0-0.5*(currentTime.milliseconds/1000);
				}
			}
			
			if(bodyLight!=null)
			{
				if(currentTime.seconds%2==0)
				{
					bodyLight.alpha = 0.5+0.5*(currentTime.milliseconds/1000);
				}
				else
				{
					bodyLight.alpha = 1.0-0.5*(currentTime.milliseconds/1000);
				}
				
				
			}
			
			if(headLight!=null)
			{
				if(currentTime.seconds%2==0)
				{
					headLight.alpha = 0.5+0.5*(currentTime.milliseconds/1000);
				}
				else
				{
					headLight.alpha = 1.0-0.5*(currentTime.milliseconds/1000);
				}
			}
			
			
			
			//For printing stuff out
			//debugText.x = FlxG.camera.scroll.x;
			//debugText.y =  FlxG.camera.scroll.y;
			
			//Cheat bit for quick save destroying
			if (FlxG.keys.pressed("X"))
			{
				saver.erase();
			}
			
			
			if(currState==NORMAL_GAMEPLAY)
			{
				normalGameplay();
			}
			else if(currState==QUESTION_TIME)
			{
				questionGameplay();
			}
			else if(currState==INVENTORY_GAMEPLAY)
			{
				inventoryGameplay();
			}
			else if(currState==HIDING_GAMEPLAY)
			{
				hiddenNormalGameplay();
			}
			else if(currState==SAVING_GAMEPLAY)
			{
				savingGameplay();
			}
			else if(currState==DIALOG_GAMEPLAY)
			{
				conversationGameplay();
			}
		}
		
		
		//Handles saving
		protected function savingGameplay():void
		{
			//ENEMY CONTROLLER
			FlxG.collide(enemyController, player);
			FlxG.collide(enemyController, wallGroup);
			FlxG.collide(enemyController, objectGroup);
			
			
			
				
			
			//THIS MOVES THE ENEMIES
			var enemyMessage: int = enemyController.commandEnemies(this);
			
				if(savePoints[saveIndex].getOpened())
				{
					//Need to play a song here
				
					saveInformation();
					//debugText.text = "Drops Collected: "+saver.data.numDrops;
					saveTimer=0;
					setGameState(NORMAL_GAMEPLAY);
					player.setPaused(false);
				}
				else
				{
				
				
					//Open savePoint first
				
					if(saveTimer==0)
					{
						FlxG.play(Assets.SAVE_UNLOCK_NOISE);
						savePoints[saveIndex].setOpening();
					}
					else if(saveTimer> savePoints[saveIndex].getTimeToOpen())
					{
						savePoints[saveIndex].openSavePoint();
					}
				
					saveTimer+= FlxG.elapsed;
				
				}
				
		}
		
		protected function hiddenNormalGameplay():void
		{	
			//ENEMY CONTROLLER
			FlxG.collide(enemyController, wallGroup);
			FlxG.collide(enemyController, objectGroup);
			
			//THIS MOVES THE ENEMIES
			var enemyMessage: int = enemyController.commandEnemies(this);

			var potentialX:int = 0;
			var potentialY:int=0;


			player.x=hidingLocation.x;
			player.y = hidingLocation.y;
			
			if(!allKeysUp)
			{
				if (!FlxG.keys["LEFT"] && !FlxG.keys["RIGHT"]
					&& !FlxG.keys["UP"] && !FlxG.keys["DOWN"])
				{
					allKeysUp = true;
				}
				
				
			}
			else
			{

			if(hideableObjects[hideableObjectIndex].getForcesOut())
			{
				if(hidingTimer>0)
				{
				hidingTimer -=FlxG.elapsed;
				
				
				
				hidingBar.color = 0x00AA0000;
				
				hidingBar.scale.x = ((16*(hidingTimer)/hideableObjects[hideableObjectIndex].getTimeToExit())/16.0);
				//Getting smaller as it forces out
				
				//Player sprite appearing
				if(hidingTimer<hideableObjects[hideableObjectIndex].getTimeToEnter()/2)
				{
					player.setAlpha(0.5+0.5*((16*(hidingTimer)/hideableObjects[hideableObjectIndex].getTimeToEnter())/16.0));
				}		
					
				hidingBar.alpha=1;
				hidingBarBackground.alpha = 1;
			
				hidingBar.x = hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2 -hidingBar.width/2;
				hidingBar.y = hideableObjects[hideableObjectIndex].y-hidingBar.height;	
				
				hidingBarBackground.x = hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2 -hidingBarBackground.width/2;
				hidingBarBackground.y = hideableObjects[hideableObjectIndex].y-hidingBarBackground.height;
					
						
				if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("RIGHT")
				|| FlxG.keys.pressed("UP") ||FlxG.keys.pressed("DOWN"))
				{
					//Reset hidingLocation based on positions
					if(FlxG.keys.pressed("LEFT"))
					{
						//If location was already on left do nothing
						if(hidingLocation.x+player.width/2<hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2)
						{}
						else
						{
							//Check to make sure there isn't a wall there
							potentialX= hideableObjects[hideableObjectIndex].x-player.width-1;
						
							if(canHavePlayerAt(potentialX, hidingLocation.y))
							{
								hidingLocation.x=potentialX;
							}
						
						}
						
						
					}
					else if(FlxG.keys.pressed("RIGHT"))
					{
						//If location was already on left do nothing
						if(hidingLocation.x+player.width/2>hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2)
						{}
						else
						{
							//Check to make sure there isn't a wall there
							potentialX= hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width+1;
						
							if(canHavePlayerAt(potentialX, hidingLocation.y))
							{
								hidingLocation.x=potentialX;
							}
						}
						
						
					}
					if(FlxG.keys.pressed("DOWN"))
					{
						//If location was already on left do nothing
						if(hidingLocation.y+player.height/2>hideableObjects[hideableObjectIndex].y+hideableObjects[hideableObjectIndex].height/2)
						{}
						else
						{
							//Check to make sure there isn't a wall there
							 potentialY= hideableObjects[hideableObjectIndex].y+hideableObjects[hideableObjectIndex].height+1;
						
							if(canHavePlayerAt(hidingLocation.x, potentialY))
							{
								hidingLocation.y=potentialY;
							}
						
						}
						
						
					}
					else if(FlxG.keys.pressed("UP"))
					{
						//If location was already on left do nothing
						if(hidingLocation.y+player.height/2<hideableObjects[hideableObjectIndex].y+hideableObjects[hideableObjectIndex].height/2)
						{}
						else
						{
							//Check to make sure there isn't a wall there
							 potentialY= hideableObjects[hideableObjectIndex].y-player.height-1;
						
							if(canHavePlayerAt(hidingLocation.x, potentialY))
							{
								hidingLocation.y=potentialY;
							}
						
						}
						
						
					}
					
				
					
					
					
					hidingBar.alpha=1;
					hidingBarBackground.alpha = 1;
					
					hidingBar.x = hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2 -hidingBar.width/2;
					hidingBar.y = hideableObjects[hideableObjectIndex].y-hidingBar.height;	
						
					hidingBarBackground.x = hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2 -hidingBarBackground.width/2;
					hidingBarBackground.y = hideableObjects[hideableObjectIndex].y-hidingBarBackground.height;
					
					
					if(hidingTimer>0)
					{
						hidingTimer -=FlxG.elapsed;
					}
					else
					{
						player.setHiding(false);
						player.setPaused(false);
						hidingBar.scale.x=0.5;
						hidingBar.color = 0xFFFFFFFF;
						hidingBar.alpha=0;
						hidingBarBackground.alpha=0;
						hidingTimer=0;
						
						//playerLight.alpha=1;
						hideableObjects[hideableObjectIndex].transferToNormalImage();
						setGameState(NORMAL_GAMEPLAY);					
					}
				}
			}
			else
			{
						player.x = hidingLocation.x;
						player.y = hidingLocation.y;
						player.setHiding(false);
						player.setPaused(false);
						hidingBar.scale.x=0.5;
						hidingBar.alpha=0;
						hidingBar.color = 0xFFFFFFFF;
						hidingBarBackground.alpha=0;
						hidingTimer=0;
						
						//playerLight.alpha=1;
						hideableObjects[hideableObjectIndex].transferToNormalImage();
						setGameState(NORMAL_GAMEPLAY);					
				}
			}
			else
			{

	
			if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("RIGHT")
				|| FlxG.keys.pressed("UP") ||FlxG.keys.pressed("DOWN"))
				{
					
					//Reset hidingLocation based on positions
					if(FlxG.keys.pressed("LEFT"))
					{
						//If location was already on left do nothing
						if(hidingLocation.x+player.width/2<hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2)
						{}
						else
						{
							//Check to make sure there isn't a wall there
							potentialX= hideableObjects[hideableObjectIndex].x-player.width-1;
						
							if(canHavePlayerAt(potentialX, hidingLocation.y))
							{
								hidingLocation.x=potentialX;
								hidingLocation.y=hideableObjects[hideableObjectIndex].y+hideableObjects[hideableObjectIndex].height-player.mySprite.height/4;
							}
						
						}
						
						
					}
					else if(FlxG.keys.pressed("RIGHT"))
					{
						//If location was already on left do nothing
						if(hidingLocation.x+player.width/2>hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2)
						{}
						else
						{
							//Check to make sure there isn't a wall there
							potentialX= hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width+1;
						
							if(canHavePlayerAt(potentialX, hidingLocation.y))
							{
								hidingLocation.x=potentialX;
								hidingLocation.y=hideableObjects[hideableObjectIndex].y+hideableObjects[hideableObjectIndex].height-player.mySprite.height/4;
							}
						}
						
						
					}
					if(FlxG.keys.pressed("DOWN"))
					{						
						//If location was already on down do nothing
						if(hidingLocation.y+player.height/2>hideableObjects[hideableObjectIndex].y+hideableObjects[hideableObjectIndex].height)
						{}
						else
						{
							//Check to make sure there isn't a wall there
							 potentialY= hideableObjects[hideableObjectIndex].y+hideableObjects[hideableObjectIndex].height+1;
							
							if(canHavePlayerAt(hidingLocation.x, potentialY))
							{
								hidingLocation.y=potentialY;
								hidingLocation.x=hideableObjects[hideableObjectIndex].x;
							}
						
						}
						
						
					}
					else if(FlxG.keys.pressed("UP"))
					{
						//If location was already on up do nothing
						if(hidingLocation.y+player.height/2<hideableObjects[hideableObjectIndex].y-hideableObjects[hideableObjectIndex].height/2)
						{}
						else
						{
							//Check to make sure there isn't a wall there
							 potentialY= hideableObjects[hideableObjectIndex].y-player.height-1;
						
							if(canHavePlayerAt(hidingLocation.x, potentialY))
							{
								hidingLocation.y=potentialY;
								hidingLocation.x=hideableObjects[hideableObjectIndex].x;
							}
						
						}
						
						
					}
					
				
					
					//hidingBar.scale.x = ((32.0*(hidingTimer))/32.0);
					hidingBar.scale.x = ((32*(hidingTimer)/hideableObjects[hideableObjectIndex].getTimeToExit())/32.0);
					//Player becoming more visible with time
					if(hidingTimer<hideableObjects[hideableObjectIndex].getTimeToExit()*0.75)
					{
						player.setAlpha(0.2+ 0.5*(1- ((32.0*(hidingTimer))/32.0)));
					}
					
					
					hidingBar.alpha=1;
					hidingBarBackground.alpha = 1;
					
					hidingBar.x = hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2 -hidingBar.width/2;
					hidingBar.y = hideableObjects[hideableObjectIndex].y-hidingBar.height;	
						
					hidingBarBackground.x = hideableObjects[hideableObjectIndex].x+hideableObjects[hideableObjectIndex].width/2 -hidingBarBackground.width/2;
					hidingBarBackground.y = hideableObjects[hideableObjectIndex].y-hidingBarBackground.height;
					
					
					if(hidingTimer>0)
					{
						hidingTimer -=FlxG.elapsed;
					}
					else
					{
						player.setHiding(false);
						player.setPaused(false);
						hidingBar.scale.x=0.5;
						hidingBar.alpha=0;
						hidingBarBackground.alpha=0;
						hidingTimer=0;
						
						//playerLight.alpha=1;
						hideableObjects[hideableObjectIndex].transferToNormalImage();
						setGameState(NORMAL_GAMEPLAY);					
					}
				}
				
				}
				
				
			}	
				
		}
		
		protected function getWaterDrops(Drop:FlxSprite,Player:FlxSprite):void
		{		
			if(player.addDrop())
			{
				FlxG.play(Assets.WATER_PICKUP);
			
				Drop.kill();
			}
			
		}
		
		
		//Returns true if there isn't a wall there, false otherwise
		public function canHavePlayerAt(xPos: int, yPos:int): Boolean
		{
			
			var canBeThere:Boolean = true;
			
			var i:int;
			var j:int; 
			for(i=0; i<16; i++)
			{
				for(j=0; j<16; j++)
				{
					if(FlxTilemap(wallGroup.getFirstAlive()).getTile((xPos+i)/16,(yPos+j)/16) != 0)
					{
						canBeThere=false;
					}
				}
			}
			
			for(i=0; i<objectGroup.length; i++)
			{
				var o : FlxSprite = objectGroup.members[i];
				
				if(o.x<xPos && o.x+o.width>xPos
				&& o.y<yPos && o.y+o.height>yPos)
				{
					canBeThere=false;
				}
			}
			
			
		
			return canBeThere;	
		}
		
		//Returns true if there isn't a wall there, false otherwise
		public function canSeePlayerThrough(xPos: int, yPos:int): Boolean
		{
			
			
			var canBeThere:Boolean = true;
			
			var i:int;
			var j:int; 
			
			var cantBeThereCount:int = 0;
			
			for(i=-4; i<4; i++)
			{
				for(j=-4; j<4; j++)
				{
					
					
					
					if(FlxTilemap(wallGroup.getFirstAlive()).getTile((xPos+i)/16,(yPos+j)/16) != 0
					|| FlxTilemap(foreGroundGroup.getFirstAlive()).getTile((xPos+i)/16,(yPos+j)/16) != 0)
					{
						cantBeThereCount++;
						
					}
				}
			}
			
			if(cantBeThereCount>30)
			{
				canBeThere=false;
			}
			
			if(canBeThere)
			{
			
				for(i=0; i<objectGroup.length; i++)
				{
					var o : FlxSprite = objectGroup.members[i];
				
					if(o.x<xPos && o.x+o.width>xPos
					&& o.y<yPos && o.y+o.height>yPos)
					{
						canBeThere=false;
					}
				}
			}
			
			//printText2.text = "Can be there: "+canBeThere;
		
			return canBeThere;	
		}
		
						
		//Level Name Stuff
		public function setLevelName(_levelName: String): void
		{
			levelName=_levelName;
		}
		
		public function getLevelName(): String
		{
			return levelName;
		}
		
		
		
		//Getters for GameState
		public function getWaterDropletsCollected():int
		{
			return saver.data.numDrops;
		}
		
		public function getMaxDropletsCollected():int
		{
			return maxDrops;
		}
		
		public function timesCaught():int
		{
			return saver.data.timesCaught;
		}
		
		public function conversationsHad():int
		{
			return saver.data.conversationsHad;
		}
		
		public function levelCompleteTime():int
		{
			return saver.data.levelMinutes;
		}
		
		
		
		
		public function normalGameplay():void
		{
			//Camera testing
			
			if(!cameraScrolling)
			{
				FlxG.camera.follow(player, 2);
			}
			FlxG.collide(wallGroup, player);
			FlxG.collide(enemyController, objectGroup);
			
			
			//Water Droplet Conections
			var i:int=0;
			for(i=0; i<waterDrops.length; i++)
			{
				FlxG.overlap(waterDrops[i],player.mySprite,getWaterDrops);
			}

		
			
			//Update collection text
			dropletText.text = ""+player.getDrops()+"/"+player.getMaxDrops();
			
			if(FlxG.keys.justReleased("M"))
			{
				setGameState(INVENTORY_GAMEPLAY);
				player.setPaused(true);
				inventory.showInventory(this, FlxG.camera.scroll);
			}
			
			
			
			//Check all dialogueTriggers to see if we have entered a dialogue zone
			for(i=0; i<dialogueTriggers.length; i++)
			{
				if(dialogueTriggers[i]!=null && FlxG.collide(dialogueTriggers[i],player))
				{
				
					var currNode: DialogNode = dialogueTriggers[i].triggerDialogueZone(player, inventory);
					
					if(currNode!=null)
					{
						//SAVE STUFF conversations update
						
						
						setUpConversation(currNode);
						
						if(!dialogueTriggers[i].getRepeatable())
						{
							dialogueTriggers[i]=null;
						}
					}
				}
			}
			
			//saveIndex set up and figure out to start saving
			for(i=0; i<savePoints.length; i++)
			{
				if(savePoints[i]!=null && FlxG.collide(savePoints[i],player))
				{
					saveIndex = i;
					setGameState(SAVING_GAMEPLAY);
					player.setPaused(true); //Pause player while saving
				}
			}
			
			//HideableObjects Check			
			//Do we have a hideableObject we're checking against presently
			if(hideableObjectIndex!=-1)
			{
			
				if(FlxG.collide(hideableObjects[hideableObjectIndex],player))
				{
					
					hidingBar.alpha=1;
					hidingBarBackground.alpha=1;
					
					//hidingTimer increasing
					hidingBar.scale.x = ((16*(hidingTimer)/hideableObjects[hideableObjectIndex].getTimeToEnter())/16.0);
					//Make player disappear more as bar increases
					player.setAlpha(1- 0.5*((16*(hidingTimer)/hideableObjects[hideableObjectIndex].getTimeToEnter())/16.0));
					
					if(hidingBar.scale.x>1)
					{
						hidingBar.scale.x = 1;
					}
					
					if(hidingTimer<hideableObjects[hideableObjectIndex].getTimeToEnter())
					{
						hidingTimer+= FlxG.elapsed;
					}
					else
					{
						player.setHiding(true);
						player.setPaused(true);
						
						//playerLight.alpha=0;
						hideableObjects[hideableObjectIndex].transferToHidingImage();
												
						hidingTimer = hideableObjects[hideableObjectIndex].getTimeToExit();
						allKeysUp = false;
						
						setGameState(HIDING_GAMEPLAY);
						hidingLocation = new FlxPoint(player.x,player.y);
						enemyController.clearAllSuspicions();
					}
				}
				else
				{
					hidingBar.alpha=0;
					hidingBarBackground.alpha=0;
					player.setAlpha(1);
					hideableObjectIndex=-1;
					hidingTimer=0;
				}
			}
			else //Else check each of them
			{
				for(i = 0; i<hideableObjects.length; i++)
				{
				
					//FlxG.collide(enemyController,hideableObjects[i]);
				
					if( FlxG.collide(hideableObjects[i],player))
					{
						hideableObjectIndex=i;
						hidingBar.alpha=1;
						hidingBarBackground.alpha=1;
						
						hidingBar.x = hideableObjects[i].x+hideableObjects[i].width/2 -hidingBar.width/2;
						hidingBar.y = hideableObjects[i].y-hidingBar.height;	
						
						hidingBarBackground.x = hideableObjects[i].x+hideableObjects[i].width/2 -hidingBarBackground.width/2;
						hidingBarBackground.y = hideableObjects[i].y-hidingBarBackground.height;	
					}
				}
			}
			
			
			var newOutfit:Boolean=false;
			
			if(!legOutfit.getGrabbed() && (FlxG.collide(legOutfit, player)))
			{
				FlxG.play(Assets.CLOTHES_NOISE);
				
				if(legsLight!=null)
				{
					legsLight.alpha=0;
					legsLight=null;
				}
				
				legOutfit.x=-10;
				
				legOutfit.setGrabbed();
				
				player.setNewOutfit(legOutfit.getOutfitType(),legOutfit.getOutfit());
				
				//Save that got legs
				saver.data.legsOutfitGot=true;

				
				
				player.setNewOutfitPiece(legOutfit);
				newOutfit=true;
			}
			
			if(!headOutfit.getGrabbed() && (FlxG.collide(headOutfit, player)))
			{
				
			
				FlxG.play(Assets.CLOTHES_NOISE);
			
				if(headLight!=null)
				{
					headLight.alpha=0;
					headLight=null;
				}
			
				headOutfit.x=-10;
				headOutfit.setGrabbed();
				player.setNewOutfit(headOutfit.getOutfitType(),headOutfit.getOutfit());
				
				//Save that got head
				saver.data.headOutfitGot=true;
			
				
				
				
				player.setNewOutfitPiece(headOutfit);
				newOutfit=true;
			}
			
			if(!bodyOutfit.getGrabbed() && (FlxG.collide(bodyOutfit, player)))
			{
				FlxG.play(Assets.CLOTHES_NOISE);
			
				if(bodyLight!=null)
				{
					bodyLight.alpha=0;
					bodyLight=null;
				}
				bodyOutfit.x=-10;
				
				bodyOutfit.setGrabbed();
				
				player.setNewOutfit(bodyOutfit.getOutfitType(),bodyOutfit.getOutfit());
				
				//Save that got body
				saver.data.bodyOutfitGot=true;
				
				
				player.setNewOutfitPiece(bodyOutfit);
				
				newOutfit=true;
			}
			
			//ENEMY CONTROLLER
			FlxG.collide(enemyController, player);
			FlxG.collide(enemyController, wallGroup);
			if(newOutfit)
			{
				//IT DOES WORK NOW. BOOYAH
				enemyController.commandEnemies(this, EnemyController.CHECK_COSTUME);
			}
			else
			{
				//THIS MOVES THE ENEMIES
				var enemyMessage: int = enemyController.commandEnemies(this);
			
				if(enemyMessage==EnemyController.ENEMY_SPOTTED_PLAYER)
				{
					setUpQuestionState();
				}
				else if(enemyMessage == EnemyController.RELOAD_LEVEL)
				{
					
					//Conversation thing
					setUpConversation(enemyController.getCaughtPlayerStatement());
				}
				
			}
			
		}
		
		protected function setUpConversation( currNode: DialogNode): void
		{
			player.setPaused(true);
			player.setHiding(true,false);
		
			//remove(dialogHandler);
			//add(dialogHandler);
			dialogHandler.setCurrNode(currNode);
			dialogHandler.showDialogHandler(this);
			dialogHandler.displayDialogHandler(FlxG.camera.scroll, inventory,player);
			setGameState(DIALOG_GAMEPLAY);
		}
		
		protected function handleConversationSaving(conversation:uint):void
		{
			saver.data.conversationsHad+=1;
		}
		
		protected function handleConversationEnd(displayingDialog: int):void
		{
			if(displayingDialog== DialogHandler.END)
			{
				setGameState(NORMAL_GAMEPLAY);
				
				dialogHandler.hideDialogHandler(this);
				player.setPaused(false);
				player.setHiding(false);
				
				var afterEnd: uint = dialogHandler.getAfterEnd();
				
				if(afterEnd==DialogNode.BACK_TO_NORMAL)
				{
					setGameState(NORMAL_GAMEPLAY);
				}
				else if(afterEnd== DialogNode.RESET_GAME)
				{
					//YOU'VE BEEN CAUGHT
					//SAVE STUFF: UP THE NUMBER OF TIMES WE'VE BEEN CAUGHT
					saver.data.timesCaught+=1;
					//printText2.text = "Reset Game";
					reloadLevel();
				}
				else if(afterEnd==DialogNode.RESET_ENEMIES)
				{
					
					
					if(enemyTimer-3>0)
					{
						enemyTimer-=3;
					}
					//Takes all enemies and turns the ones chasing the player to not doing that anymore
					enemyController.resetEnemies(this);
					setGameState(NORMAL_GAMEPLAY);
				}
				
				
				if(dialogHandler.getConversationEnd())
				{
					handleConversationSaving(dialogHandler.getConversation());
				}
				
			}
			else if(displayingDialog==DialogHandler.QUESTION_NEXT)
			{
				setUpQuestionStateNode(dialogHandler.getCurrNode());
			}
		}
		
		protected function conversationGameplay(): void
		{
			enemyController.commandEnemies(this, 1); //Pause all
			FlxG.collide(enemyController, player.mySprite);
			FlxG.collide(enemyController, wallGroup);
			
			player.keepBodyTogether();
			
			//Returns true when it's done
			var displayingDialog: int = dialogHandler.displayDialogHandler(FlxG.camera.scroll, inventory,player);
			
			
			handleConversationEnd(displayingDialog);
			
		}
		
		public function questionGameplay():void
		{		
		
			if(!questioningSound.active)
			{
				questioningSound.play();
				if(FlxG.music!=null)
				{
					FlxG.music.pause();
				}
			}
			
			questionTimer-=FlxG.elapsed;
			
			var intTimer:int = 1+questionTimer;
			questionTimerDisplay.text = ""+ intTimer;
			
			//Make sure we're not out of time
			if(intTimer==0)
			{
				reloadLevel();
			}
			
			//Make sure the enemies didn't just become ghosts
			FlxG.collide(enemyController, player);
			FlxG.collide(enemyController, wallGroup);
			
			
			
			var i:int=0;
			for(i=0; i<answers.length;i++)
			{
				//MAKE SURE THEY STAY ON SCREEN
				answerDisplays[i].alignment = "right";
				if(answerDisplays[i].x +answerDisplays[i].size*answerDisplays[i].text.length/4 >(FlxG.camera.scroll.x+80))
				{
					answerDisplays[i].velocity.x*=-1;
				}
				
				
				answerDisplays[i].alignment = "left";
				if(answerDisplays[i].x-answerDisplays[i].size*0.5*answerDisplays[i].text.length/4<(FlxG.camera.scroll.x-120))
				{
					answerDisplays[i].velocity.x*=-1;
				}
				
				answerDisplays[i].alignment = "center";
				
				if(answerDisplays[i].y>(FlxG.camera.scroll.y+150))
				{
					answerDisplays[i].velocity.y*=-1;
				}
				else if(answerDisplays[i].y<(FlxG.camera.scroll.y))
				{
					answerDisplays[i].velocity.y*=-1;
				}
				
				
				//Check if the user hit the right key
				if(FlxG.keys.justReleased(answers[i].getKey()))
				{
					
					questioningSound.stop();
					FlxG.play(Assets.GUI_SHORT_NOISE);
					if(FlxG.music!=null)
					{
						FlxG.music.play();
					}
					fromQuestionState();
					setUpConversation(responses[i]);//new DialogNode(responses[i], DialogHandler.PLAYER_HEAD, answers[i].getAnswerText()));
				}
			}
			
			//Try removing command
			enemyController.commandEnemies(this);
			
		}
		
		public function inventoryGameplay():void
		{
			if(inventory.updateMenu(player)) //checks enemyController
			{
				enemyController.commandEnemies(this, EnemyController.CHECK_COSTUME);
			}
		
			if(FlxG.keys.justReleased("M"))
			{
			
				//Set to prevState, so either Normal or Hidden
				setGameState(prevState);
				
				if(currState == NORMAL_GAMEPLAY)
				{
					player.setPaused(false);
				}
				else
				{
					player.setPaused(true);
				}
				inventory.hideInventory(this, FlxG.camera.scroll);
				
			}
		
			enemyController.commandEnemies(this, EnemyController.PAUSE_ALL);
		}
		
		//BEGINNING QUESTiON STATE FOR ENEMY QUESTION
		protected function setUpQuestionState():void
		{
			
			//Pause player
			player.setPaused(true);
			//400 is width, center allignment put's in mid of that
			
			
			//Display the head of the enemy asking this question
			dialogHandler.setCurrNode(enemyController.getQuestion());
			//Show dialog handler
			dialogHandler.showDialogHandler(this);
			//Show full text all at once, no slow typing
			dialogHandler.displayDialogHandlerTotal(FlxG.camera.scroll);
			
			//Set Question Time State
			setGameState(QUESTION_TIME);
				
			
			answers = enemyController.getAnswers();
			responses = enemyController.getResponses();
			
			questionTimer=enemyTimer;
			add(questionTimerDisplay);
			
			//Deploy answers randomly
			var i: int=0;
			for(i =0; i<answers.length; i++)
			{
				//X has to be within -100 to +100, y within +50 to +150
				
				var xValue:Number =  FlxG.camera.scroll.x + (Math.random()*200 -120);
			
				var yValue:Number =  FlxG.camera.scroll.y + (Math.random()*100 +50);
			
				var answerText:FlxText = new FlxText(xValue, yValue, 400, answers[i].getKey()+"). "+answers[i].getAnswerText());
				answerText.alignment = "center";
				add(answerText);
				
				answerDisplays.push(answerText);
				
				answerDisplays[i].velocity = new FlxPoint(100*(Math.random()-0.5),100*(Math.random()-0.5));
			
				answerDisplays[i].alignment = "right";
				if(answerDisplays[i].x +answerDisplays[i].size*answerDisplays[i].text.length/4 >(FlxG.camera.scroll.x+80))
				{
					answerDisplays[i].x=FlxG.camera.scroll.x;
				}
				
				
				answerDisplays[i].alignment = "left";
				if(answerDisplays[i].x-answerDisplays[i].size*0.5*answerDisplays[i].text.length/4<(FlxG.camera.scroll.x-120))
				{
					answerDisplays[i].x=FlxG.camera.scroll.x;
				}
				
				answerText.alignment = "center";
			}
			
			
			
		}
		
		protected function setUpQuestionStateNode(currNode: DialogNode):void
		{
			
			//Pause player
			player.setPaused(true);
			//400 is width, center allignment put's in mid of that
			
			//Display the head of the enemy asking this question
			dialogHandler.setCurrNode(currNode);
			//Show dialog handler
			dialogHandler.showDialogHandler(this);
			//Show full text all at once, no slow typing
			dialogHandler.displayDialogHandlerTotal(FlxG.camera.scroll);
			
			//Set Question Time State
			setGameState(QUESTION_TIME);
				
			
			answers = currNode.getAnswers();
			responses = currNode.getResponses();
			
			questionTimer=currNode.getTimeToAnswer();
			add(questionTimerDisplay);
			
			//Deploy answers randomly
			var i: int=0;
			for(i =0; i<answers.length; i++)
			{
				//X has to be within -100 to +100, y within +50 to +150
				
				var xValue:Number =  FlxG.camera.scroll.x + (Math.random()*200 -120);
			
				var yValue:Number =  FlxG.camera.scroll.y + (Math.random()*100 +50);
			
				var answerText:FlxText = new FlxText(xValue, yValue, 400, answers[i].getKey()+"). "+answers[i].getAnswerText());
				answerText.alignment = "center";
				add(answerText);
				
				answerDisplays.push(answerText);
				
				answerDisplays[i].velocity = new FlxPoint(100*(Math.random()-0.5),100*(Math.random()-0.5));
			
				answerDisplays[i].alignment = "right";
				if(answerDisplays[i].x +answerDisplays[i].size*answerDisplays[i].text.length/4 >(FlxG.camera.scroll.x+80))
				{
					answerDisplays[i].x=FlxG.camera.scroll.x;
				}
				
				
				answerDisplays[i].alignment = "left";
				if(answerDisplays[i].x-answerDisplays[i].size*0.5*answerDisplays[i].text.length/4<(FlxG.camera.scroll.x-120))
				{
					answerDisplays[i].x=FlxG.camera.scroll.x;
				}
				
				answerText.alignment = "center";
			}
			
			
			
		}
		
		//Remove question state and return to normal gameplay state
		protected function fromQuestionState():void
		{
			//Player can now move
			player.setPaused(false);
			setGameState(NORMAL_GAMEPLAY);
			
			//Remove the timer
			remove(questionTimerDisplay);
			
			//Remove answers
			var i:int =0;
			for(i=0; i<answerDisplays.length; i++)
			{
				remove(answerDisplays[i]);
			}
			
			answerDisplays= new Vector.<FlxText>();
			answers = new Vector.<EnemyAnswer>();
		}	
		
		public function getRandomKeyboardKey(): String
		{
			var keys:Array = new Array("Q", "W", "E", "R", "T",
			"Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", 
			"J", "K", "L", "Z", "C", "V", "B", "N", "M");
			
			return keys[((int)(Math.random()*25 ))];
		
		}
	}
}
