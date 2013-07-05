package 
{
	import org.flixel.*;

	public class Player extends TopDownEntity
	{
		/**
		 * Constructor
		 * @param	X	X location of the entity
		 * @param	Y	Y location of the entity
		 */
		 
		 
		
		 
		public function Player(X:Number=100, Y:Number=100):void {
			super(Assets.RANGER_SPRITE, new FlxPoint(16,2), new FlxPoint(16,18), X, Y);
			
		}
		
		/**
		 * Check for user input to control this entity
		 */
		override protected function updateControls():void {
			
			super.updateControls();
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
				moveLeft();
			else if (movement.x > 0)
				moveRight();
			if (movement.y < 0)
				moveUp();
			else if (movement.y > 0)
				moveDown();
		}
	}
}
