package 
{
	import org.flixel.*;
	
	
	
	public class IndoorHouseLevel extends TopDownLevel
	{
		/**
		 * Floor layer
		 */
		protected static var FLOORS:Array = new Array(
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0
		);
		
		/**
		 * Wall layer
		 */
		protected static var WALLS:Array = new Array(
			1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
		);
		
		
		protected static var FOREGROUND:Array = new Array(
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
		
		//Controller reference for enemies
		private var enemyController: EnemyController;
		
		
		
		
		
		
		/**
		 * Constructor
		 * @param	state		State displaying the level
		 * @param	levelSize	Width and height of level (in pixels)
		 * @param	blockSize	Default width and height of each tile (in pixels)
		 */
		public function IndoorHouseLevel(levelSize:FlxPoint, blockSize:FlxPoint):void {
			
			
			//You gots to have these bits for the player image to not just be legs
			super(levelSize, blockSize,new FlxPoint(120,120));
			legOutfit = new PlayerOutfit(50,50,Assets.RANGER2_PANTS,PlayerOutfit.LEGS_OUTFIT,Assets.RANGER2LEGS_SPRITE, OutfitHandler.GUARD_OUTFIT);
			add(legOutfit);
			
			bodyOutfit = new PlayerOutfit(90,50,Assets.RANGER2_SHIRT,PlayerOutfit.BODY_OUTFIT,Assets.RANGER2BODY_SPRITE, OutfitHandler.GUARD_OUTFIT);
			add(bodyOutfit);
			
			headOutfit = new PlayerOutfit(50,90,Assets.RANGER2_HAT,PlayerOutfit.HEAD_OUTFIT,Assets.RANGER2HEAD_SPRITE, OutfitHandler.GUARD_OUTFIT);
			add(headOutfit);
			
		}
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		override protected function createMap():void {
			var tiles:FlxTilemap;
			// floors
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(FLOORS, 23), // convert our array of tile indices to a format flixel understands
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
				FlxTilemap.arrayToCSV(WALLS, 15), // convert our array of tile indices to a format flixel understands
				Assets.WALLS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y // height of each tile (in pixels)
			);
			wallGroup.add(tiles);
			
			//FOREGROUND
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(FOREGROUND, 15), // convert our array of tile indices to a format flixel understands
				Assets.WALLS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y // height of each tile (in pixels)
			);
			
			foreGroundGroup.add(tiles);
			
			
			
			
			darkness = new FlxSprite(0,0);
			
			
			
      		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff777777);
      		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
      		darkness.blend = "multiply";
			
			playerLight = new Light(Assets.LightImageClass, FlxG.width / 2, FlxG.height / 2, darkness);
			playerLight.scale = (new FlxPoint(0.5,0.5));
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
		}
		
		/**
		 * Create the player
		 */
		override protected function createPlayer():void {
			player = new Player(playerStart.x, playerStart.y/2);
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		override protected function createGUI():void {
			//var instructions:FlxText = new FlxText(0, 0, levelSize.x, "Use ARROW keys to walk around");
			//instructions.alignment = "center";
			//guiGroup.add(instructions);
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
			player.addSprites(this);
			
		
    		var light5:Light = new Light(Assets.LightImageClass, FlxG.width*3/ 4, FlxG.height/ 4, darkness, 0xFFFFFFFF);
    		add(light5);
			
			 
			var one: FlxPoint = new FlxPoint(140,140);
			var two: FlxPoint = new FlxPoint(80,140);
			var three: FlxPoint = new FlxPoint(80,100);
			
			var waypoints: Vector.<FlxPoint> = new Vector.<FlxPoint>();
			
			//Create enemy waypoints
			waypoints.push(one);
			waypoints.push(two);
			waypoints.push(three);
			
			var enemy1:Enemy = new Enemy(waypoints,player, light5);
			
			//Create enemies vector for enemyController
			var enemies: Vector.<Enemy> = new Vector.<Enemy>();
			
			enemies.push(enemy1);
			
			enemyController = new EnemyController(enemies);
			
			
			add(enemyController);
			add(playerLight);
			
			add(darkness);
			
			
			add(guiGroup);
		}
		override public function draw():void {
 			darkness.fill(0xff777777);
   			super.draw();
 		}
		
		
		
		override public function transferLevel(): TopDownLevel{
			if(player.x>220)
			{
				return new PlainHouseLevel(levelSize,tileSize);
			}
			else if(super.reloadThisLevel)
			{
				return new IndoorHouseLevel(levelSize,tileSize);
			}
			else
			{
				return null;
			}
		}
		
		
		/**
		 * Update each timestep
		 */
		override public function update():void {
			super.update(); // NOTE: map -> player collision happens in super.update()
			
		}
		
		//OVERRIDEN AND CALLED FROM SUPER'S UPDATE METHOD
		override public function normalGameplay():void
		{
			super.normalGameplay();
			
			playerLight.x=(player.x+player.width/2);
			playerLight.y = (player.y-player.height/2);
			FlxG.collide(objectGroup, player);
			
			var newOutfit:Boolean=false;
			
			if(legOutfit!=null && FlxG.collide(legOutfit, player))
			{
				remove(legOutfit);
				
				player.setNewOutfit(legOutfit.getOutfitType(),legOutfit.getOutfit());
				
				player.setNewOutfitPiece(legOutfit);
				newOutfit=true;
				enemyController.checkCorrectOutfit()
			}
			
			if(bodyOutfit!=null && FlxG.collide(bodyOutfit, player))
			{
				remove(bodyOutfit);
				
				player.setNewOutfit(bodyOutfit.getOutfitType(),bodyOutfit.getOutfit());
				
				player.setNewOutfitPiece(bodyOutfit);
				
				newOutfit=true;
				enemyController.checkCorrectOutfit()
			}
			
			if(headOutfit!=null && FlxG.collide(headOutfit, player))
			{
				remove(headOutfit);
				
				player.setNewOutfit(headOutfit.getOutfitType(),headOutfit.getOutfit());
				
				player.setNewOutfitPiece(headOutfit);
				
				newOutfit=true;
				enemyController.checkCorrectOutfit()
			}
			
			
			
			//ENEMY CONTROLLER
			if(newOutfit)
			{
				//THIS PRESENTLY DOESN'T WORK, BUT IT WILL SHRINK THE GUARD'S FOV
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
			}
		}
		
		//BEGINNING QUESTiON STATE
		private function setUpQuestionState():void
		{
			
			//Pause player
			player.setPaused(true);
			questionText = new FlxText(10, levelSize.y-50, levelSize.x/2, enemyController.getQuestion());
			questionText.alignment = "center";
			
			//Set Question Time State
			setGameState(QUESTION_TIME);
				
			add(questionText);
			
			var currAnswers: Vector.<EnemyAnswer> = enemyController.getAnswers();
			
			answerUp = new FlxText(10, levelSize.y/3, levelSize.x/2, currAnswers[0].getAnswerText());//Up Answer
			answerRight = new FlxText(10+levelSize.x/6, levelSize.y/2, levelSize.x/2, currAnswers[1].getAnswerText()); //Right Answer
			answerLeft = new FlxText(10, levelSize.y/2, levelSize.x/2, currAnswers[3].getAnswerText()); //Left Answer
			answerDown = new FlxText(10, 2*levelSize.y/3, levelSize.x/2, currAnswers[2].getAnswerText()); //Down Answer
			
			var i: int;
			
			for(i=0; i<4; i++)
			{
				if(currAnswers[i].isCorrectAnswer())
				{
					correctAnswer=i;
				}
			}
			
			
			answerUp.alignment = "center";
			add(answerUp);
			answerRight.alignment = "center";
			add(answerRight);
			answerDown.alignment = "center";
			add(answerDown);
			answerLeft.alignment = "left";
			add(answerLeft);
			
			
		}
		
		//Remove question state and return to normal gameplay state
		private function fromQuestionState():void
		{
			player.setPaused(false);
			setGameState(NORMAL_GAMEPLAY);
			
			remove(questionText);
			remove(answerUp);
			remove(answerDown);
			remove(answerRight);
			remove(answerLeft);
		}
		
		
		//OVERRIDEN METHOD CALLED IN SUPER'S UPDATE
		override public function questionGameplay():void
		{
			super.questionGameplay();
			
			if (FlxG.keys.justReleased("A"))
			{
				if(correctAnswer==3)
				{
					enemyController.resetEnemies();
				}
				else
				{
					reloadLevel();
				}
				
				fromQuestionState();
				
			}
				
			if (FlxG.keys.justReleased("D"))
			{
				if(correctAnswer==1)
				{
					enemyController.resetEnemies();
				}
				else
				{
					reloadLevel();
				}
				
				fromQuestionState();
			}
				
			if (FlxG.keys.justReleased("W"))
			{
				if(correctAnswer==0)
				{
					enemyController.resetEnemies();
				}
				else
				{
					reloadLevel();
				}
				
				fromQuestionState();
			}
				
			if (FlxG.keys.justReleased("S"))
			{
				if(correctAnswer==2)
				{
					enemyController.resetEnemies();
				}
				else
				{
					reloadLevel();
				}
				
				fromQuestionState();
			}
			
		}
		
	}
}