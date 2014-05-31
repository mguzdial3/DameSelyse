package 
{
	import org.flixel.*;

	public class TrueWalrusEnemy extends Enemy
	{
		
		private var shrunkenLight:Boolean;
		private var fpsToUse:int = 12;
		public function TrueWalrusEnemy(_waypoints:Vector.<FlxPoint>, player: Player, _lightFOV1: Light,  X:Number=100, Y:Number=140, _dialogNode:DialogNode=null):void {
			super(Assets.WALRUS_SPRITE, _waypoints, player,_lightFOV1, X, Y,_dialogNode, 60,28,31);
			
			
			//THIS IS THE WHOLE CONVERSATION
			enemyQuestion = _dialogNode;
			
			
	
			//This one is the chef outfit
			outfitToUse=OutfitHandler.PRINCESS_OUTFIT;
			
			
			//Shark Sounds
			sightedSound= Assets.CELESTE_TOUGH;
		  	lostSound= Assets.CELESTE_HUH;
		
			minimumDist = 40;
			
			allMatchFOV();
		}
		
		override protected function allMatchFOV():void
		{
			lightFOV.alpha = 0;
		}
		
		override protected function noMatchFOV():void
		{
			lightFOV.alpha = 0;
		}
		
		override protected function oneMatchFOV():void
		{
			lightFOV.alpha = 0;
		}
		
		override protected function twoMatchFOV():void
		{
			lightFOV.alpha = 0;
		}
		
		
		
		
		
		override public function createAnimations():void {
			
			
			mySprite.addAnimation("idle_up", [4]);
			
			mySprite.addAnimation("idle_right", [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3], 10, true);
			mySprite.addAnimation("idle_down", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1], 10, true);
			mySprite.addAnimation("idle_left", [0,0,0,0,0,0,0,0,0,0,0,1], 10, true);
			mySprite.addAnimation("walk_up", [9,9,10,10], 12); // 12 = frames per second for this animation
			//bodySprite.addAnimation("walk_right", [5, 6, 7,8], 12);
			mySprite.addAnimation("walk_down", [5,5, 6, 6], 12);
			mySprite.addAnimation("walk_horz", [7, 7, 8,8], 12);
			
			mySprite.facing=LEFT;
		}


		override public function getCaughtPlayerStatement(): DialogNode
		{
			return enemyQuestion;
		}
		
		
		
		
	
	}//End of class
	
}//End of package declaration