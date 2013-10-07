package 
{
	import org.flixel.*;

	public class CookEnemy extends Enemy
	{
	
		public function CookEnemy(_waypoints:Vector.<FlxPoint>, player: Player, _lightFOV: Light, X:Number=100, Y:Number=140, _dialogNode:DialogNode=null):void {
			super(Assets.COOK_SPRITE, _waypoints, player,_lightFOV, X, Y,_dialogNode, 55);
			
			
			if(_dialogNode!=null)
			{
				enemyQuestion = _dialogNode;
			}
			else
			{
				enemyQuestion = new DialogNode(null, DialogHandler.RAT_HEAD, "What are you doing here? Huh? Huh?");
			}
			
			//This one is the chef outfit
			outfitToUse=OutfitHandler.CHEF_OUTFIT;
			
			resetFOV();
		}
		
		//To be overriden for how other lightFOV's shrink
		override protected function shrinkFOV():void
		{
			lightFOV.scale= new FlxPoint(0.4,0.4);
		}
		
		override protected function resetFOV():void
		{
			lightFOV.scale= new FlxPoint(0.5,0.5);
		}
		
		
		
		override public function createAnimations():void {
			
			mySprite.addAnimation("idle_up", [4]);
			
			mySprite.addAnimation("idle_right", [0,0,0,0,0,0,0,0,0,0,0,1], 12, true);
			mySprite.addAnimation("idle_down", [2,2,2,2,2,2,2,2,2,2,2,3], 12, true);
			mySprite.addAnimation("idle_left", [0,0,0,0,0,0,0,0,0,0,0,1], 12, true);
			mySprite.addAnimation("walk_up", [13, 14, 15, 16], 12); // 12 = frames per second for this animation
			mySprite.addAnimation("walk_down", [9, 10, 11, 12], 12);
			mySprite.addAnimation("walk_horz", [5, 6, 7,8], 12);
			
			mySprite.facing=LEFT;
		}
		
		//Get Positive Response
		override protected function getPositiveResponse(): DialogNode
		{
			return new DialogNode(null, DialogHandler.RAT_HEAD, "Oh! Get 'um quick then!",DialogNode.RESET_ENEMIES);
		}
		
		//To be overriden by later enemies
		override protected function setUpQuestion():void
		{	
			var enemyAnswer1: String = "Cutting the cheese";
			var enemyAnswer2: String = "Fetching Ingredients for The Chef!";
			var enemyAnswer3: String =  "Shhh, don’t rat me out!.";
			var enemyAnswer4: String = "Being sweet.";
			var enemyAnswer5: String = "I'm not anybody, you're confused.";
			var enemyAnswer6: String = "I should just go back to jail.";
			var enemyAnswer7: String = "I give up.";
			var enemyAnswer8: String = "I'm the Prisoner. Sorry.";
			var enemyAnswer9: String = "SQUEAK!";
			var enemyAnswer10: String = "Meow";
			
			
			enemyAnswers = 	new Vector.<EnemyAnswer>();
			
			//THE CORRECT ANSWER NEEDS TO BE THE FIRST ONE
			enemyAnswers.push(new EnemyAnswer(enemyAnswer2,getRandomKeyboardKey(),true));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer1, getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "Ugh! That's gross. Wait- You're the prisoner!",DialogNode.RESET_GAME)));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer3,getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "Wow, really? Rat jokes? You must be the prisoner.",DialogNode.RESET_GAME)));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer4,getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "That's hardly any excuse, to the dungeon with you!",DialogNode.RESET_GAME)));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer5, getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "Yeah you're right, I should take a break- right after I send you back to jail!",DialogNode.RESET_GAME)));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer6,getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "You're right, let's get you back to your nice, cold cell.",DialogNode.RESET_GAME)));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer7,getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "Oh. Okay then prisoner, let's get you back.",DialogNode.RESET_GAME)));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer8, getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "Um. It's okay? Ah. There there? Gonna have to take you back tho.",DialogNode.RESET_GAME)));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer9,getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "That was really offensive, you're going to jail.",DialogNode.RESET_GAME)));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer10,getRandomKeyboardKey(), false,  new DialogNode(null, DialogHandler.RAT_HEAD, "AH! A Cat! Wait, you're just the prisoner!",DialogNode.RESET_GAME)));
			
		}
		
		
		
	
	}//End of class
	
}//End of package declaration