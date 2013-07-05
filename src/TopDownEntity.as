package 
{
	import org.flixel.*;
	
	
	public class TopDownEntity extends FlxSprite
	{
		//Whether or not this entity is currently paused
		private var currPaused: Boolean;
	
		public var runSpeed:int; //Max run speed
		
		public var size:FlxPoint;//Size in pixels of this box collider
		
		public var mySprite: FlxSprite;
		
		//Used in camera room transfering
		public var center: FlxPoint;
		
		//public var collisionBox: FlxObject;
		/**
		 * Constructor
		 * @param	X	X location of the entity
		 * @param	Y	Y location of the entity
		 */
		public function TopDownEntity(spriteSheet: Class,_size: FlxPoint, frameSize:FlxPoint, X:Number = 100, Y:Number = 100, _runSpeed:int=60):void {
			super(X, Y);
			
			size = _size;
			makeGraphic(size.x, size.y, 0xFFFF0000); 
			alpha = 0;//Comment off this line to see the tiny white box collider for this entity
			
			runSpeed = _runSpeed;
			
			// movement
			maxVelocity = new FlxPoint(runSpeed, runSpeed);
			drag = new FlxPoint(runSpeed * 4, runSpeed * 4); // decelerate to a stop within 1/4 of a second
			// animations
			
			
			
			mySprite = new FlxSprite(X,Y);
			
			center = new FlxPoint(X,Y);
			
			mySprite.loadGraphic(
				spriteSheet, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				frameSize.x, // width of each frame (in pixels)
				frameSize.y // height of each frame (in pixels)
			);
			
			
			currPaused=false;
			createAnimations();
		}
		
		/**
		 * Create the animations for this entity
		 * to be overriden by other classes using other spritesheets
		 * 
		 */
		public function createAnimations():void {
			
			mySprite.addAnimation("idle_up", [1]);
			
			mySprite.addAnimation("idle_right", [5]);
			mySprite.addAnimation("idle_down", [9]);
			mySprite.addAnimation("idle_left", [13]);
			mySprite.addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
			mySprite.addAnimation("walk_right", [4, 5, 6], 12);
			mySprite.addAnimation("walk_down", [8, 9, 10], 12);
			mySprite.addAnimation("walk_left", [12, 13, 14], 12);
			
		}

		

		

		/**
		 * Update each timestep
		 */
		public override function update():void {
			if(!currPaused)
			{
				updateControls();
			}
			updateAnimations();
			mySprite.update();
			
			//Set your sprite to be at the position you'd expect it to be at
			mySprite.x = x;
			mySprite.y = y-(mySprite.height-height);
			
			
			//Center of object used for various calculations
			center.x = mySprite.x+mySprite.width/2;
			center.y = mySprite.y+mySprite.height/2;
			
			if(!currPaused)
			{
				super.update();
			}
		}
		
		public function hardStop():void
		{
			
			velocity.x=0;
			velocity.y=0;
			acceleration.x=0;
			acceleration.y=0;
		}
		
		public function setPaused(_paused: Boolean):void
		{
			currPaused=_paused;
			hardStop();
		}
		
		
		public function hardStopY(): void
		{
			velocity.y=0;
			acceleration.y=0;
		}
		
		public function hardStopX(): void
		{
			velocity.x=0;
			acceleration.x=0;
		}
		
		
		/**
		 * Based on current state, show the correct animation
		 * to be overriden
		 */
		public function updateAnimations():void {
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
					mySprite.play("walk_up");
				else
					mySprite.play("idle_up");
			}
			// down
			else if (facing == DOWN) {
				if (velocity.y != 0 || velocity.x != 0)
					mySprite.play("walk_down");
				else
					mySprite.play("idle_down");
			}
			// right
			else if (facing == RIGHT) {
				if (velocity.x != 0)
					mySprite.play("walk_right");
				else
					mySprite.play("idle_right");
			}
			// left
			else if (facing == LEFT) {
				if (velocity.x != 0)
					mySprite.play("walk_left");
				else
					mySprite.play("idle_left");
			}
		}
		
		/**
		 * Check keyboard/mouse controls
		 * set to nothing so this class can be used for other npc's
		 */
		protected function updateControls():void {
			acceleration.x = acceleration.y = 0; // no gravity or drag by default
		}
		
		/**
		 * Move entity left
		 */
		public function moveLeft(modifier:Number=1):void {
			currPaused=false;
			facing = LEFT;
			acceleration.x = -runSpeed * 4*modifier; // accelerate to top speed in 1/4 of a second
			
		}
		
		/**
		 * Move entity right
		 */
		public function moveRight(modifier:Number=1):void {
			currPaused=false;
			facing = RIGHT;
			acceleration.x = runSpeed * 4*modifier; // accelerate to top speed in 1/4 of a second
		
		}
		
		/**
		 * Move entity up
		 */
		public function moveUp(modifier:Number=1):void {
			currPaused=false;
			facing = UP;
			acceleration.y = -runSpeed * 4*modifier; // accelerate to top speed in 1/4 of a second
		
		}
		
		/**
		 * Move entity down
		 */
		public function moveDown(modifier:Number=1):void {
			currPaused=false;
			facing = DOWN;
			acceleration.y = runSpeed * 4*modifier; // accelerate to top speed in 1/4 of a second
	
		}
	}
}
