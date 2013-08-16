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
		 * player
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
		protected static const INVENTORY_GAMEPLAY:int=2;
		
		/**
		 * Question Stuff
		 */
		 
		 //FOR BUILDING, WE NEED SOME KIND OF DIALOG HANDLER
		 protected var questionText: FlxText;
		 protected var answers: Vector.<EnemyAnswer>;
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
		protected var displayingDialog: Boolean;
		
		//List of dialogue triggers
		protected var dialogueTriggers: Vector.<DialogueTriggerZone>;
		
		
		
		
		//Just the Menu(M) text in the upper right corner
		protected var menuText:FlxText;
		
		//Inventory
		protected var inventory: Inventory;
		 
		 
		 /**
		 * Outfit stuff
		 */
		 protected var legOutfit: PlayerOutfit;
		 protected var bodyOutfit:PlayerOutfit;
		 protected var headOutfit:PlayerOutfit;
		 
		
		//Debug
		protected var debugText: FlxText;
		
		
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
			
			//Initialization
			answers = new Vector.<EnemyAnswer>();
		 	answerDisplays = new Vector.<FlxText>;
			
			// create the level
			this.create();
			
			//Hooks the inventory up to the player
			inventory = new Inventory(player.getOutfitHandler());
			
			//Dialog Handler has to be above everything else
			dialogHandler = new DialogHandler();
			
			//Set up DialogTriggers
			dialogueTriggers = new Vector.<DialogueTriggerZone>();
			
			
			//Sets up the timer for the question
			questionTimerDisplay = new FlxText(120,100,80,"");
			questionTimerDisplay.alignment = "center";
			questionTimerDisplay.color = 0xFFFF0000;
			questionTimerDisplay.size = 30;
			questionTimerDisplay.scrollFactor.x = questionTimerDisplay.scrollFactor.y = 0;
			
			//Sets up and adds the menu text
			menuText = new FlxText(240,0,80, "Menu(M)");
			menuText.alignment = "right";
			menuText.scrollFactor.x = menuText.scrollFactor.y = 0;
			add(menuText);
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
			addEnemies();
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
			FlxG.camera.follow(player, 2);
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
			
			//For printing stuff out
			debugText.x = FlxG.camera.scroll.x;
			debugText.y =  FlxG.camera.scroll.y;
			
			
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
		}
		
		
		public function normalGameplay():void
		{
			FlxG.camera.follow(player, 2);
			FlxG.collide(wallGroup, player);
			
			if(FlxG.keys.justReleased("M"))
			{
			
				setGameState(INVENTORY_GAMEPLAY);
				player.setPaused(true);
				inventory.showInventory(this, FlxG.camera.scroll);
				
			}
			
			//Check all dialogueTriggers to see if we have entered a dialogue zone
			var i:int=0;
			for(i=0; i<dialogueTriggers.length; i++)
			{
				if(dialogueTriggers[i]!=null && FlxG.collide(dialogueTriggers[i],player))
				{
				
					var currNode: DialogNode = dialogueTriggers[i].triggerDialogueZone(player, inventory);
					
					if(currNode!=null)
					{
						if(dialogueTriggers[i].getPausesPlayer())
						{
							player.setPaused(true);
						}
					
						dialogHandler.setCurrNode(currNode);
						dialogHandler.showDialogHandler(this);
						dialogHandler.displayDialogHandler(FlxG.camera.scroll, inventory,player);
						displayingDialog=true;
						
						if(!dialogueTriggers[i].getRepeatable())
						{
							dialogueTriggers[i]=null;
						}
					}
				}
			}
			
			//Handle Displaying Dialog
			if(displayingDialog)
			{
				//Returns true when it's done
				displayingDialog = !dialogHandler.displayDialogHandler(FlxG.camera.scroll, inventory,player);
				
				if(!displayingDialog)
				{
					dialogHandler.hideDialogHandler(this);
					player.setPaused(false);
					
					
				}
			}
			
			playerLight.x=(player.x+player.width/2);
			playerLight.y = (player.y-player.height/2);
			
			var newOutfit:Boolean=false;
			
			if(legOutfit!=null && FlxG.collide(legOutfit, player))
			{
				remove(legOutfit);
				
				player.setNewOutfit(legOutfit.getOutfitType(),legOutfit.getOutfit());
				
				player.setNewOutfitPiece(legOutfit);
				newOutfit=true;
			}
			
			if(bodyOutfit!=null && FlxG.collide(bodyOutfit, player))
			{
				remove(bodyOutfit);
				
				player.setNewOutfit(bodyOutfit.getOutfitType(),bodyOutfit.getOutfit());
				
				player.setNewOutfitPiece(bodyOutfit);
				
				newOutfit=true;
			}
			
			//ENEMY CONTROLLER
			
			FlxG.collide(enemyController, player);
			FlxG.collide(enemyController, wallGroup);
			if(newOutfit)
			{
				//IT DOES WORK NOW. BOOYAH
				enemyController.commandEnemies(EnemyController.CHECK_COSTUME);
			}
			else
			{
				//THIS MOVES THE ENEMIES
				var enemyMessage: int = enemyController.commandEnemies();
			
			
				if(enemyMessage==EnemyController.ENEMY_SPOTTED_PLAYER)
				{
					setUpQuestionState();
				}
				else if(enemyMessage == EnemyController.RELOAD_LEVEL)
				{
					reloadLevel();
				}
			}
			
		}
		
		public function questionGameplay():void
		{			
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
			
			enemyController.commandEnemies(EnemyController.PAUSE_ALL);
			
			var i:int=0;
			for(i=0; i<answers.length;i++)
			{
				//MAKE SURE THEY STAY ON SCREEN
				answerDisplays[i].alignment = "right";
				if(answerDisplays[i].x>(FlxG.camera.scroll.x+80))
				{
					answerDisplays[i].velocity.x*=-1;
				}
				
				
				answerDisplays[i].alignment = "left";
				if(answerDisplays[i].x<(FlxG.camera.scroll.x-120))
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
					if(answers[i].isCorrectAnswer())
					{
						dialogHandler.hideDialogHandler(this);
						enemyController.resetEnemies();
					}
					else
					{
						dialogHandler.hideDialogHandler(this);
						reloadLevel();
					}
						
					fromQuestionState();
				}
			}
			
		}
		
		public function inventoryGameplay():void
		{
			if(inventory.updateMenu(player)) //checks enemyController
			{
				enemyController.commandEnemies(EnemyController.CHECK_COSTUME);
			}
		
			if(FlxG.keys.justReleased("M"))
			{
				currState = NORMAL_GAMEPLAY;
				player.setPaused(false);
				inventory.hideInventory(this, FlxG.camera.scroll);
				
			}
		
			enemyController.commandEnemies(EnemyController.PAUSE_ALL);
		}
		
		//BEGINNING QUESTiON STATE
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
			
			questionTimer=10;
			add(questionTimerDisplay);
			
			//Deploy answers randomly
			var i: int=0;
			for(i =0; i<answers.length; i++)
			{
				//X has to be within -100 to +100, y within +50 to +150
				
				var xValue:Number =  FlxG.camera.scroll.x + (Math.random()*200 -100);
			
				var yValue:Number =  FlxG.camera.scroll.y + (Math.random()*100 +50);
			
				var answerText:FlxText = new FlxText(xValue, yValue, 400, answers[i].getKey()+"). "+answers[i].getAnswerText());
				answerText.alignment = "center";
				add(answerText);
				
				answerDisplays.push(answerText);
				
				answerDisplays[i].velocity = new FlxPoint(100*(Math.random()-0.5),100*(Math.random()-0.5));
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
	}
}
