package 
{
	import org.flixel.*;

	public class Player extends TopDownEntity
	{
		
		//Sprites for body and head of character
		public var bodySprite:FlxSprite;
		public var headSprite:FlxSprite;
		
		//Handles current outfits and stores the others
		public var outfitHandler: OutfitHandler;
		
		private var hiding: Boolean;
	
		//The number of drops the player is carrying
		private var numDrops: int;
		private var MAX_DROPS: int= 100;
		
		//FOR DEBUGGING
		private var num: Number;
		
		/**
		 * Constructor
		 * @param	X	X location of the entity
		 * @param	Y	Y location of the entity
		 */
		public function Player(X:Number=100, Y:Number=100):void {
			super(Assets.RANGERLEGS_SPRITE, new FlxPoint(12,2), new FlxPoint(16,18), X, Y);
			num=0;
			bodySprite = new FlxSprite(X,Y);
			headSprite = new FlxSprite(X,Y);
			
			//Set up original outfits
			var legOutfit:PlayerOutfit = new PlayerOutfit(50,50,Assets.RANGER_PANTS,PlayerOutfit.LEGS_OUTFIT,Assets.RANGERLEGS_SPRITE, OutfitHandler.NORMAL_OUTFIT);
			var bodyOutfit:PlayerOutfit = new PlayerOutfit(50,50,Assets.RANGER_SHIRT,PlayerOutfit.BODY_OUTFIT,Assets.RANGERBODY_SPRITE, OutfitHandler.NORMAL_OUTFIT);
			var headOutfit:PlayerOutfit = new PlayerOutfit(50,50,Assets.RANGER_HAT,PlayerOutfit.HEAD_OUTFIT,Assets.RANGERHEAD_SPRITE, OutfitHandler.NORMAL_OUTFIT);
			
			outfitHandler = new OutfitHandler(legOutfit,bodyOutfit,headOutfit);
			
			//BODY SPRITE SET UP
			bodySprite.loadGraphic(
				Assets.RANGERBODY_SPRITE, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				16, // width of each frame (in pixels)
				18 // height of each frame (in pixels)
			);
			
			bodySprite.addAnimation("idle_up", [1]);
			
			bodySprite.addAnimation("idle_right", [5]);
			bodySprite.addAnimation("idle_down", [9]);
			bodySprite.addAnimation("idle_left", [13]);
			bodySprite.addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
			bodySprite.addAnimation("walk_right", [4, 5, 6], 12);
			bodySprite.addAnimation("walk_down", [8, 9, 10], 12);
			bodySprite.addAnimation("walk_left", [12, 13, 14], 12);
			
			//HEAD SPRITE SET UP
			headSprite.loadGraphic(
				Assets.RANGERHEAD_SPRITE, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				16, // width of each frame (in pixels)
				18 // height of each frame (in pixels)
			);
			
			headSprite.addAnimation("idle_up", [1]);
			
			headSprite.addAnimation("idle_right", [5]);
			headSprite.addAnimation("idle_down", [9]);
			headSprite.addAnimation("idle_left", [13]);
			headSprite.addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
			headSprite.addAnimation("walk_right", [4, 5, 6], 12);
			headSprite.addAnimation("walk_down", [8, 9, 10], 12);
			headSprite.addAnimation("walk_left", [12, 13, 14], 12);
			
			
		}
		
		
		public function addSprites(groupToAddTo: FlxGroup):void
		{
			//Legs
			groupToAddTo.add(mySprite);
			//Body
			groupToAddTo.add(bodySprite);
			//Head
			groupToAddTo.add(headSprite);
		}
		
		
		override public function updateAnimations():void {
			// use abs() so that we can animate for the dominant motion
			// ex: if we're moving slightly up and largely right, animate right
			var absX:Number = Math.abs(velocity.x);
			var absY:Number = Math.abs(velocity.y);
			// determine facing
			if (velocity.y < 0 && absY >= absX)
				facing = UP;
			else if (velocity.y > 0 && absY >= absX)
				facing = DOWN;
			else if (velocity.x > 0 && absX >= absY)
				facing = RIGHT;
			else if (velocity.x < 0 && absX >= absY)
				facing = LEFT
			// up
			if (facing == UP) {
				if (velocity.y != 0 || velocity.x != 0)
				{
					mySprite.play("walk_up");
					bodySprite.play("walk_up");
					headSprite.play("walk_up");
				}
				else
				{
					mySprite.play("idle_up");
					bodySprite.play("idle_up");
					headSprite.play("idle_up");
				}
			}
			// down
			else if (facing == DOWN) {
				if (velocity.y != 0 || velocity.x != 0)
				{
					mySprite.play("walk_down");
					bodySprite.play("walk_down");
					headSprite.play("walk_down");
				}
				else
				{
					mySprite.play("idle_down");
					bodySprite.play("idle_down");
					headSprite.play("idle_down");
				}
			}
			// right
			else if (facing == RIGHT) {
				if (velocity.x != 0)
				{
					mySprite.play("walk_right");
					bodySprite.play("walk_right");
					headSprite.play("walk_right");
				}
				else
				{
					mySprite.play("idle_right");
					bodySprite.play("idle_right");
					headSprite.play("idle_right");
				}
			}
			// left
			else if (facing == LEFT) {
				if (velocity.x != 0)
				{
					mySprite.play("walk_left");
					bodySprite.play("walk_left");
					headSprite.play("walk_left");
				}
				else
				{
					mySprite.play("idle_left");
					bodySprite.play("idle_left");
					headSprite.play("idle_left");
				}
			}
		}
		
		/**
		 * Check for user input to control this entity
		 */
		override protected function updateControls():void {
			
			super.updateControls();
			
			//MOVE BODY AND HEAD
			bodySprite.update();
			
			//Set your sprite to be at the position you'd expect it to be at
			bodySprite.x = x;
			bodySprite.y = y-(mySprite.height-height);
			
			headSprite.update();
			
			//Set your sprite to be at the position you'd expect it to be at
			headSprite.x = x;
			headSprite.y = y-(mySprite.height-height);
			
			
			
			// check keys
			// NOTE: this accounts for someone pressing multiple arrow keys at the same time (even in opposite directions)
			var movement:FlxPoint = new FlxPoint();
			if (FlxG.keys.pressed("LEFT"))
				movement.x -= 1;
				
			if (FlxG.keys.pressed("RIGHT"))
				movement.x += 1;
				
			if (FlxG.keys.pressed("UP"))
				movement.y -= 1;
				
			if (FlxG.keys.pressed("DOWN"))
				movement.y += 1;
				
			var maxDropNum: Number = MAX_DROPS;
			var dropNum : Number = numDrops;
				
			num = (maxDropNum - (dropNum))/maxDropNum;
			num+=0.1; //So you can always move at least a little
			
			maxVelocity = new FlxPoint(runSpeed*num, runSpeed*num);
			
			// check final movement direction
			if (movement.x < 0)
			{
				moveLeft(2*num);
			}
			else if (movement.x > 0)
			{
				moveRight(2*num);
			}
			if (movement.y < 0)
			{
				moveUp(2*num);
			}
			else if (movement.y > 0)
			{
				moveDown(2*num);
			}
		}
		
		
		//This changes the display to match the new outfit
		public function setNewOutfit(outfitType:uint, outfit:Class):void
		{
			if(outfitType==PlayerOutfit.LEGS_OUTFIT)
			{
				mySprite.loadGraphic(
					outfit, // image to use
					true, // animated
					false, // don't generate "flipped" images since they're already in the image
					16, // width of each frame (in pixels)
					18 // height of each frame (in pixels)
				);
			
			
				mySprite.addAnimation("idle_right", [5]);
				mySprite.addAnimation("idle_down", [9]);
				mySprite.addAnimation("idle_left", [13]);
				mySprite.addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
				mySprite.addAnimation("walk_right", [4, 5, 6], 12);
				mySprite.addAnimation("walk_down", [8, 9, 10], 12);
				mySprite.addAnimation("walk_left", [12, 13, 14], 12);
				
				
				
			}
			else if(outfitType==PlayerOutfit.BODY_OUTFIT)
			{
				bodySprite.loadGraphic(
					outfit, // image to use
					true, // animated
					false, // don't generate "flipped" images since they're already in the image
					16, // width of each frame (in pixels)
					18 // height of each frame (in pixels)
				);
			
				bodySprite.addAnimation("idle_up", [1]);
			
				bodySprite.addAnimation("idle_right", [5]);
				bodySprite.addAnimation("idle_down", [9]);
				bodySprite.addAnimation("idle_left", [13]);
				bodySprite.addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
				bodySprite.addAnimation("walk_right", [4, 5, 6], 12);
				bodySprite.addAnimation("walk_down", [8, 9, 10], 12);
				bodySprite.addAnimation("walk_left", [12, 13, 14], 12);
			}
			else if(outfitType==PlayerOutfit.HEAD_OUTFIT)
			{
				headSprite.loadGraphic(
					outfit, // image to use
					true, // animated
					false, // don't generate "flipped" images since they're already in the image
					16, // width of each frame (in pixels)
					18 // height of each frame (in pixels)
				);
			
				headSprite.addAnimation("idle_up", [1]);
			
				headSprite.addAnimation("idle_right", [5]);
				headSprite.addAnimation("idle_down", [9]);
				headSprite.addAnimation("idle_left", [13]);
				headSprite.addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
				headSprite.addAnimation("walk_right", [4, 5, 6], 12);
				headSprite.addAnimation("walk_down", [8, 9, 10], 12);
				headSprite.addAnimation("walk_left", [12, 13, 14], 12);
				
				
				//This is quite cheating
				facing = DOWN;
				headSprite.play("idle_down");
				
				
			}
			
			
			
		}
	
		//Sets new outfit for Outfit Handler
		public function setNewOutfitPiece(newOutfitPiece: PlayerOutfit):void
		{
			
			outfitHandler.setCurrOutfit(newOutfitPiece);
			
			
			
		}
		
		//Checks to see if the passed in outfit set matches this one
		public function sameHeadOutfitType(outfitSet:uint):Boolean
		{
			if(outfitSet==outfitHandler.getCurrHeadOutfitSet())
			{
				return true;
			}	
			
			return false;
		}
		
		//Checks to see if the passed in outfit set matches this one
		public function sameBodyOutfitType(outfitSet:uint):Boolean
		{
			if(outfitSet==outfitHandler.getCurrBodyOutfitSet())
			{
				return true;
			}	
			
			return false;
		}
		
		//Checks to see if the passed in outfit set matches this one
		public function sameLegsOutfitType(outfitSet:uint):Boolean
		{
			if(outfitSet==outfitHandler.getCurrLegsOutfitSet())
			{
				return true;
			}	
			
			return false;
		}
		
		//Used only once to connect inventory up to it
		public function getOutfitHandler(): OutfitHandler
		{
			return outfitHandler;
		}
		
		//HIDING
		public function getHiding(): Boolean
		{
			return hiding;
		}
		
		public function setHiding (_hiding: Boolean): void
		{
			hiding = _hiding;
			
			if(hiding)
			{
				mySprite.alpha=0;
				headSprite.alpha = 0;
				bodySprite.alpha = 0;
			}
			else
			{
				mySprite.alpha=1;
				headSprite.alpha = 1;
				bodySprite.alpha = 1;
			}
		}
		
		////////////////////////
		//Water Drop Stuff
		
		public function addDrop():Boolean
		{
		
			if(numDrops<MAX_DROPS)
			{
				numDrops++;
				return true;
			}
			
			return false;
		}
		
		public function getDrops(): int
		{
			return numDrops;
		}	
		
		public function clearDrops(): void
		{
			numDrops=0;
		}	
		
		
		
		
		public function getMaxDrops(): int
		{
			return MAX_DROPS;
		}
		
		//FOR DEBUGGING
		public function getNum():Number
		{
			return num;
		}
		
		
	}
	
	
	
	
	
}
