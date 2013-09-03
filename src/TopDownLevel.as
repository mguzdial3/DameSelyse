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
		
		/**
		 * Question Stuff
		 */
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
		
		//WaterDrops grounp
		protected var waterDrops: FlxGroup;
		//Text for score
		protected var dropletText: FlxText;
		 
		 
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
		//HideableObjects Loading Bar
		protected var hidingBarBackground: FlxSprite;
		protected var hidingBar:FlxSprite;
		 
		
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
			
			hidingTimer=0;
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
			addHideableObjects();
			createWaterDroplets();
			addEnemies();
			addGroups();
			createGUI();
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
			FlxG.camera.follow(player, 2);
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		protected function createGUI():void 
		{
			dropletText =new FlxText(FlxG.camera.scroll.x+220, FlxG.camera.scroll.y+20, 100, "0/"+player.getMaxDrops());
			dropletText.alignment = "right";
			dropletText.scrollFactor = new FlxPoint(0, 0);
			dropletText.color = 0xff4433ff;
			add(dropletText);
			
			
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
			waterDrops = new FlxGroup();
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
			else if(currState==HIDING_GAMEPLAY)
			{
				hiddenNormalGameplay();
			}
		}
		
		public function hiddenNormalGameplay():void
		{	
			//ENEMY CONTROLLER
			FlxG.collide(enemyController, player);
			FlxG.collide(enemyController, wallGroup);
			
			//THIS MOVES THE ENEMIES
			var enemyMessage: int = enemyController.commandEnemies();


	
			if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("RIGHT")
				|| FlxG.keys.pressed("UP") ||FlxG.keys.pressed("DOWN"))
				{
					
					hidingBar.scale.x = (16.0*(hidingTimer))/32.0;
					
					
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
						
						playerLight.alpha=1;
						hideableObjects[hideableObjectIndex].transferToNormalImage();
						setGameState(NORMAL_GAMEPLAY);					
					}
				}
				
		}
		
		protected function getWaterDrops(Drop:FlxSprite,Player:FlxSprite):void
		{		
			if(player.addDrop())
			{
				Drop.kill();
			}
			
		}
		
		
		public function normalGameplay():void
		{
			FlxG.camera.follow(player, 2);
			FlxG.collide(wallGroup, player);
			
			//Water Droplet Conections
			FlxG.overlap(waterDrops,player,getWaterDrops);
			
			
			//Update collection text
			dropletText.text = ""+player.getDrops()+"/"+player.getMaxDrops();
			
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
						
					//hideableObjects[hideableObjectIndex].transferToHidingImage();
					setGameState(NORMAL_GAMEPLAY);
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
					
					
					hidingBar.scale.x = (16*(hidingTimer)/hideableObjects[hideableObjectIndex].getTimeToEnter())/16.0;
					/**	
					hidingBar.x = hideableObjects[i].x+hideableObjects[i].width/2 -hidingBar.width/2;
					hidingBar.y = hideableObjects[i].y-hidingBar.height;	
						
					hidingBarBackground.x = hideableObjects[i].x+hideableObjects[i].width/2 -hidingBarBackground.width/2;
					hidingBarBackground.y = hideableObjects[i].y-hidingBarBackground.height;
					*/
					
					if(hidingTimer<hideableObjects[hideableObjectIndex].getTimeToEnter())
					{
						hidingTimer+= FlxG.elapsed;
					}
					else
					{
						player.setHiding(true);
						player.setPaused(true);
						
						playerLight.alpha=0;
						hideableObjects[hideableObjectIndex].transferToHidingImage();
						setGameState(HIDING_GAMEPLAY);
						
						enemyController.clearAllSuspicions();
					}
				}
				else
				{
					hidingBar.alpha=0;
					hidingBarBackground.alpha=0;
				
					hideableObjectIndex=-1;
					hidingTimer=0;
				}
			}
			else //Else check each of them
			{
				for(i = 0; i<hideableObjects.length; i++)
				{
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
			
			if(headOutfit!=null && FlxG.collide(headOutfit, player))
			{
				remove(headOutfit);
				
				player.setNewOutfit(headOutfit.getOutfitType(),headOutfit.getOutfit());
				
				player.setNewOutfitPiece(headOutfit);
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
