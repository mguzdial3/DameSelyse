package 
{
	import org.flixel.*;

	public class CookEnemy extends Enemy
	{
	
		public function CookEnemy(_waypoints:Vector.<FlxPoint>, player: Player, _lightFOV: Light, X:Number=100, Y:Number=140, _dialogNode:DialogNode=null):void {
			super(Assets.COOK_SPRITE, _waypoints, player,_lightFOV, X, Y,_dialogNode, 60);
			
			
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
			
			giveUpTimerMax=3.0;
			
			noMatchFOV();
		}
		
		
		
		override protected function allMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.35,0.35);
		}
		
		override protected function noMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.5,0.5);
		}
		
		override protected function oneMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.475,0.5475);
		}
		
		override protected function twoMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.45,0.45);
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
			var node1: DialogNode = 	 new DialogNode(null, DialogHandler.RAT_HEAD, "Oh! Get 'um quick then!",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_ENEMIES)
		
			return new DialogNode(node1, DialogHandler.PLAYER_HEAD,  "Fetching Ingredients for The Chef!");
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
			var response2: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Ugh! That's gross. Wait- You're the prisoner!",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer1, getRandomKeyboardKey(), false,  new DialogNode(response2, DialogHandler.PLAYER_HEAD,  "Cutting the cheese")));
			
			var response3: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Wow, really? Rat jokes? You must be the prisoner.",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer3,getRandomKeyboardKey(), false,  new DialogNode(response3, DialogHandler.PLAYER_HEAD, enemyAnswer3)));
			
			var response4: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "That's hardly any excuse, to the dungeon with you!",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer4,getRandomKeyboardKey(), false,  new DialogNode(response4, DialogHandler.PLAYER_HEAD, enemyAnswer4)));
			
			var response5: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Yeah you're right, I should take a break- right after I send you back to jail!",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer5,getRandomKeyboardKey(), false,  new DialogNode(response5, DialogHandler.PLAYER_HEAD, enemyAnswer5)));
			
			var response6: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "You're right, let's get you back to your nice, cold cell.",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer6,getRandomKeyboardKey(), false,  new DialogNode(response6, DialogHandler.PLAYER_HEAD, enemyAnswer6)));
			
			var response7: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Oh. Okay then prisoner, let's get you back.",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer7,getRandomKeyboardKey(), false,  new DialogNode(response7, DialogHandler.PLAYER_HEAD, enemyAnswer7)));
			
			var response8: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Um. It's okay? Ah. There there? Gonna have to take you back tho.",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer8,getRandomKeyboardKey(), false,  new DialogNode(response8, DialogHandler.PLAYER_HEAD, enemyAnswer8)));
			
			var response9: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "That was really offensive, you're going to jail.",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer9,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer9)));
			
			var response10: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "AHHH! A Cat! Wait, you're just the prisoner!",Assets.CAT_GUARD_DISAGREE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer10,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer10)));
			
			
		}
		
		
		
	
	}//End of class
	
}//End of package declaration