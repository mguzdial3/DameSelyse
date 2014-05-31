package 
{
	import org.flixel.*;

	public class CookEnemy extends Enemy
	{
	
		public function CookEnemy(_waypoints:Vector.<FlxPoint>, player: Player, _lightFOV: Light, X:Number=100, Y:Number=140, _dialogNode:DialogNode=null, _enemyType:uint = 0, _waypointWaitTimeMax:Number=0, _runspeed:Number=60):void {
			super(Assets.COOK_SPRITE, _waypoints, player,_lightFOV, X, Y,_dialogNode, _runspeed,15,18, _enemyType, _waypointWaitTimeMax);
			
			
			if(_dialogNode!=null)
			{
				enemyQuestion = _dialogNode;
			}
			else
			{
				enemyQuestion = new DialogNode(null, DialogHandler.RAT_HEAD, "What are you doing here? Huh? Huh?", Assets.RAT_TALKING);
			}
			
			drag = new FlxPoint(runSpeed * 2, runSpeed * 2);
			
			
			//This one is the chef outfit
			outfitToUse=OutfitHandler.CHEF_OUTFIT;
			
			giveUpTimerMax=5.0;
			
			noMatchFOV();
			
			//Rat Sounds
			sightedSound= Assets.RAT_SIGHTED;
		  	lostSound= Assets.RAT_LOST;
		  	
		  	minimumDist=30;
		}
		
		
		
		
		
		override public function getCaughtPlayerStatement(): DialogNode
		{
			return new DialogNode(null, DialogHandler.RAT_HEAD, "Hey there chef-! Wait a second, you're Dame Celeste!", Assets.RAT_TALKING, DialogNode.RESET_GAME);
		}
		
		override protected function allMatchFOV():void
		{
			lightFOV.setSprite(Assets.LightRatSmall);
		}
		
		override protected function noMatchFOV():void
		{
			lightFOV.setSprite(Assets.LightRatNone);
		}
		
		override protected function oneMatchFOV():void
		{
			lightFOV.setSprite(Assets.LightCatMed);
		}
		
		override protected function twoMatchFOV():void
		{
			lightFOV.setSprite(Assets.LightRatMed);
		}
		
		
		
		
		override public function createAnimations():void {
			
			mySprite.addAnimation("idle_up", [4]);
			
			mySprite.addAnimation("idle_right", [0,0,0,0,0,0,0,0,0,0,0,1], 12, true);
			mySprite.addAnimation("idle_down", [2,2,2,2,2,2,2,2,2,2,2,3], 12, true);
			mySprite.addAnimation("idle_left", [0,0,0,0,0,0,0,0,0,0,0,1], 12, true);
			mySprite.addAnimation("walk_up", [13, 14, 15, 16], 14); // 12 = frames per second for this animation
			mySprite.addAnimation("walk_down", [9, 10, 11, 12], 14);
			mySprite.addAnimation("walk_horz", [5, 6, 7,8], 14);
			
		}
		
		//Get Positive Response
		override protected function getPositiveResponse(): DialogNode
		{
			var node1: DialogNode = 	 new DialogNode(null, DialogHandler.RAT_HEAD, "Oh! Get 'um quick then!",Assets.RAT_ANGRY, DialogNode.RESET_ENEMIES)
		
			return new DialogNode(node1, DialogHandler.PLAYER_HEAD,  "Fetching Ingredients for The Chef!",Assets.CELESTE_DETERMINED );
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
			
			var response3: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Wow, really? Rat jokes? You must be the prisoner.",Assets.RAT_JEER,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer3,getRandomKeyboardKey(), false,  new DialogNode(response3, DialogHandler.PLAYER_HEAD, enemyAnswer3)));
			
			var response4: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "That's hardly any excuse, to the dungeon with you!",Assets.RAT_TALKING,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer4,getRandomKeyboardKey(), false,  new DialogNode(response4, DialogHandler.PLAYER_HEAD, enemyAnswer4)));
			
			var response5: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Yeah you're right, I should take a break- right after I send you back to jail!",Assets.RAT_SURPRISE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer5,getRandomKeyboardKey(), false,  new DialogNode(response5, DialogHandler.PLAYER_HEAD, enemyAnswer5)));
			
			var response6: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "You're right, let's get you back to your nice, cold cell.",Assets.RAT_TALKING,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer6,getRandomKeyboardKey(), false,  new DialogNode(response6, DialogHandler.PLAYER_HEAD, enemyAnswer6)));
			
			var response7: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Oh. Okay then prisoner, let's get you back.",Assets.RAT_TALKING,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer7,getRandomKeyboardKey(), false,  new DialogNode(response7, DialogHandler.PLAYER_HEAD, enemyAnswer7)));
			
			var response8: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "Um. It's okay? Ah. There there? Gonna have to take you back tho.",Assets.RAT_TALKING,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer8,getRandomKeyboardKey(), false,  new DialogNode(response8, DialogHandler.PLAYER_HEAD, enemyAnswer8)));
			
			var response9: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "That was really offensive, you're going to jail.",Assets.RAT_JEER,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer9,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer9)));
			
			var response10: DialogNode = new DialogNode(null, DialogHandler.RAT_HEAD, "AHHH! A Cat! Wait, you're just the prisoner!",Assets.RAT_SURPRISE,DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer10,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer10)));
			
			
		}
		
		
		override protected function updateControls():void {
			super.updateControls();
			
			if(goalPoint!=null)
			{
				var difference:FlxPoint = new FlxPoint(goalPoint.x-this.x, goalPoint.y-this.y);
				var magni:Number = Math.sqrt(difference.x*difference.x+difference.y*difference.y);
			
				difference.x/= magni;
				difference.y/=magni;
			
			
				movement = new FlxPoint();
	
				var bufferZone: int = 0;	
		
				if(this.x<goalPoint.x-bufferZone)
				{
				//Move right
					movement.x += 1;
				}
				if(this.x>goalPoint.x+bufferZone)
				{
					//On left
					movement.x -= 1;
				}
	
				if(this.y<goalPoint.y-bufferZone)
				{
					//Move down
					movement.y += 1;
				}
				if(this.y>goalPoint.y+bufferZone)
				{
					//Move up
					movement.y -= 1;
				}
				
				
			
				if(movement.x>0)
				{
					//Move right
					moveRight(speedModifier);
				
				}
				if(movement.x<0)
				{
					//On left
					moveLeft(speedModifier);
				}
	
				if(movement.y>0)
				{
					//Move down
					moveDown(speedModifier);
				
				}
				if(movement.y<0)
				{
					//Move up
					moveUp(speedModifier);
				}
			
			}
			
			
			
			
			
			/**
			if (movement.x < 0)
				moveLeft(speedModifier);
			else if (movement.x > 0)
				moveRight(speedModifier);
			else
			{
				//Easy way to keep it from meandering forever in the x direction
				hardStopX();
			}
			
			
			
			if (movement.y < 0)
				moveUp(speedModifier);
			else if (movement.y > 0)
				moveDown(speedModifier);
			else
			{
				//Easy way to keep it from meandering forever in the y direction
				hardStopY();
			}
			*/
			
		}
		
		
	
	}//End of class
	
}//End of package declaration