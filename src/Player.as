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
	
		/**
		 * Constructor
		 * @param	X	X location of the entity
		 * @param	Y	Y location of the entity
		 */
		public function Player(X:Number=100, Y:Number=100):void {
			super(Assets.RANGERLEGS_SPRITE, new FlxPoint(12,2), new FlxPoint(16,18), X, Y);
			
			bodySprite = new FlxSprite(X,Y);
			headSprite = new FlxSprite(X,Y);
			
			//Set up original outfits
			var legOutfit:PlayerOutfit = new PlayerOutfit(50,50,null,PlayerOutfit.LEGS_OUTFIT,Assets.RANGERLEGS_SPRITE, OutfitHandler.NORMAL_OUTFIT);
			var bodyOutfit:PlayerOutfit = new PlayerOutfit(50,50,null,PlayerOutfit.BODY_OUTFIT,Assets.RANGERBODY_SPRITE, OutfitHandler.NORMAL_OUTFIT);
			var headOutfit:PlayerOutfit = new PlayerOutfit(50,50,null,PlayerOutfit.HEAD_OUTFIT,Assets.RANGERHEAD_SPRITE, OutfitHandler.NORMAL_OUTFIT);
			
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
				
			// check final movement direction
			if (movement.x < 0)
				moveLeft(2);
			else if (movement.x > 0)
				moveRight(2);
			if (movement.y < 0)
				moveUp(2);
			else if (movement.y > 0)
				moveDown(2);
		}
		
		
		
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
			}
		}
	
		//Outfit Handler Translates
		public function setNewOutfitPiece(newOutfitPiece: PlayerOutfit):void
		{
			if(newOutfitPiece.getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
			{		
				outfitHandler.setCurrLegsOutfit(newOutfitPiece);
			}
			else if(newOutfitPiece.getOutfitType()==PlayerOutfit.BODY_OUTFIT)
			{
				outfitHandler.setCurrBodyOutfit(newOutfitPiece);
			}
			else if(newOutfitPiece.getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
			{
				outfitHandler.setCurrHeadOutfit(newOutfitPiece);
			}
		}
		
		public function sameHeadOutfitType(outfitType:uint):Boolean
		{
			if(outfitType==outfitHandler.getCurrHeadOutfitType())
			{
				return true;
			}	
			
			return false;
		}
		
		public function sameBodyOutfitType(outfitType:uint):Boolean
		{
			if(outfitType==outfitHandler.getCurrBodyOutfitType())
			{
				return true;
			}	
			
			return false;
		}
		
		public function sameLegsOutfitType(outfitType:uint):Boolean
		{
			//if(outfitType==outfitHandler.getCurrLegsOutfitType())
		//	{
				return true;
		//	}	
			
		//	return false;
		}
		
	}
	
	
	
	
	
}
