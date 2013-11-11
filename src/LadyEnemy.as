package 
{
	import org.flixel.*;

	public class LadyEnemy extends Enemy
	{
		private var lightFOV2: Light;
		
		private var shrunkenLight:Boolean;
	
		public function LadyEnemy(_waypoints:Vector.<FlxPoint>, player: Player, _lightFOV1: Light, _lightFOV2: Light,  X:Number=100, Y:Number=140, _dialogNode:DialogNode=null):void {
			super(Assets.SHARK_SPRITE, _waypoints, player,_lightFOV1, X, Y,_dialogNode, 45,16,16);
			
			lightFOV2 = _lightFOV2;
			
			if(_dialogNode!=null)
			{
				enemyQuestion = _dialogNode;
			}
			else
			{
				enemyQuestion = new DialogNode(null, DialogHandler.SHARK_HEAD, "What are You doing here? In THAT dress?");
			}
			
			
			
			//This one is the chef outfit
			outfitToUse=OutfitHandler.LADY_OUTFIT;
			
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
			
			mySprite.addAnimation("idle_right", [0,0,0,0,0,0,0,0,0,0,0,1], 9, true);
			mySprite.addAnimation("idle_down", [2,2,2,2,2,2,2,2,2,2,2,3], 9, true);
			mySprite.addAnimation("idle_left", [0,0,0,0,0,0,0,0,0,0,0,1], 9, true);
			mySprite.addAnimation("walk_up", [17, 18, 19, 20], 9); // 12 = frames per second for this animation
			mySprite.addAnimation("walk_down", [13, 14, 15, 16], 9);
			mySprite.addAnimation("walk_horz", [5, 6, 7,8,9,10,11,12], 9);
			
			mySprite.facing=LEFT;
		}
		
		//Get Positive Response
		override protected function getPositiveResponse(): DialogNode
		{
		
			var node1: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Oh! Of course! Haha, I didn't recognize you at first!", Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_ENEMIES)
		
			return new DialogNode(node1, DialogHandler.PLAYER_HEAD,  "I’m the guest-of-honor, and the dress is Retro.");
		}
		
		//To be overriden by later enemies
		override protected function setUpQuestion():void
		{	
			var enemyAnswer1: String = "Crashing the party, sweetheart.";
			var enemyAnswer2: String = "I’m the guest-of-honor, and the dress is Retro.";
			var enemyAnswer3: String =  "What, do I seem a bit Fishy?";
			var enemyAnswer4: String = "Just on my way out, thanks.";
			var enemyAnswer5: String = "I'm not anybody, you're confused.";
			var enemyAnswer6: String = "Getting caught.";
			var enemyAnswer7: String = "I’m. Uh. Lost?";
			var enemyAnswer8: String = "Stop trying to make fetch happen!";
			var enemyAnswer9: String = "I’ve nearly escaped!";
			var enemyAnswer10: String = "Meow";
			
			
			enemyAnswers = 	new Vector.<EnemyAnswer>();
			
			
			
			
			//THE CORRECT ANSWER NEEDS TO BE THE FIRST ONE
			enemyAnswers.push(new EnemyAnswer(enemyAnswer2,getRandomKeyboardKey(),true));
			var response2: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Wow, you're such a rebel, you should be in jail!", Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer1, getRandomKeyboardKey(), false,  new DialogNode(response2, DialogHandler.PLAYER_HEAD, enemyAnswer1)));
			
			var response3: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Fish puns, really? Let's get you otter here.",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer3,getRandomKeyboardKey(), false,  new DialogNode(response3, DialogHandler.PLAYER_HEAD, enemyAnswer3)));
			
			var response4: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Not on my watch! You must be that Dame Celeste!",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer4,getRandomKeyboardKey(), false,  new DialogNode(response4, DialogHandler.PLAYER_HEAD, enemyAnswer4)));
			
			var response5: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "I am NOT confused. You're confused! And the prisoner!",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer5,getRandomKeyboardKey(), false,  new DialogNode(response5, DialogHandler.PLAYER_HEAD, enemyAnswer5)));
			
			var response6: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Yeah, I caught you. 'Cause I'm the best.",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer6,getRandomKeyboardKey(), false,  new DialogNode(response6, DialogHandler.PLAYER_HEAD, enemyAnswer6)));
			
			var response7: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Well let's get you unlost, straight back to jail.",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer7,getRandomKeyboardKey(), false,  new DialogNode(response7, DialogHandler.PLAYER_HEAD, enemyAnswer7)));
			
			var response8: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "I didn't- I... what? You confuse me, to the dungeon with you!",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer8,getRandomKeyboardKey(), false,  new DialogNode(response8, DialogHandler.PLAYER_HEAD, enemyAnswer8)));
			
			var response9: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Not anymore! Back to the dungeon, lady!",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer9,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer9)));
			
			var response10: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "AHHH! A Cat! Wait. I'm a shark... Go to jaiL!",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer10,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer10)));
			
			
		}
		
		//FIX LIGHT STUFF
		
		
		//To be overriden in other enemies for different lights
		override protected function moveLightSource(): void{
			
			//Where should the upper left corner of the lightSourceGoal be?
			var lightSourceGoal: FlxPoint = new FlxPoint();
			var lightSourceGoal2: FlxPoint = new FlxPoint();
			
			if(facing==UP)
			{
			
				lightFOV.scale = new FlxPoint(0.6, 0.4);
				lightFOV2.scale = new FlxPoint(0.6, 0.4);
			
				if(suspicious==3)
				{
					lightFOV.scale = new FlxPoint(0.4, 0.3);
					lightFOV2.scale = new FlxPoint(0.4, 0.3);
				}
				else if(suspicious==2)
				{
					lightFOV.scale = new FlxPoint(0.58, 0.38);
					lightFOV2.scale = new FlxPoint(0.58, 0.38);
				}
				else if(suspicious==1)
				{
					lightFOV.scale = new FlxPoint(0.55, 0.35);
					lightFOV2.scale = new FlxPoint(0.55, 0.35);
				}
			
			
				lightSourceGoal.x = this.x-(lightFOV.width)*(lightFOV.scale.x)*0.3;
				lightSourceGoal.y = this.y-this.height*2;
				
				lightSourceGoal2.x = this.x+(lightFOV2.width)*(lightFOV2.scale.x)*0.3;
				lightSourceGoal2.y = this.y-this.height*2;
			}
			else if(facing==DOWN)
			{
			
				lightFOV.scale = new FlxPoint(0.6, 0.4);
				lightFOV2.scale = new FlxPoint(0.6, 0.4);
			
				if(suspicious==3)
				{
					lightFOV.scale = new FlxPoint(0.4, 0.3);
					lightFOV2.scale = new FlxPoint(0.4, 0.3);
				}
				else if(suspicious==2)
				{
					lightFOV.scale = new FlxPoint(0.58, 0.38);
					lightFOV2.scale = new FlxPoint(0.58, 0.38);
				}
				else if(suspicious==1)
				{
					lightFOV.scale = new FlxPoint(0.55, 0.35);
					lightFOV2.scale = new FlxPoint(0.55, 0.35);
				}
				
			
				lightSourceGoal.x = this.x-(lightFOV.width)*(lightFOV.scale.x)*0.3;
				lightSourceGoal.y = this.y+this.height;
				
				lightSourceGoal2.x = this.x+(lightFOV2.width)*(lightFOV2.scale.x)*0.3;
				lightSourceGoal2.y = this.y+this.height;
			}
			else if(facing==LEFT)
			{
			
				lightFOV.scale = new FlxPoint(0.2, 0.6);
				lightFOV2.scale = new FlxPoint(0.2, 0.6);
			
				if(suspicious==3)
				{
					lightFOV.scale = new FlxPoint(0.15, 0.4);
					lightFOV2.scale = new FlxPoint(0.15, 0.4);
				}
				else if(suspicious==2)
				{
					lightFOV.scale = new FlxPoint(0.18, 0.58);
					lightFOV2.scale = new FlxPoint(0.18, 0.58);
				}
				else if(suspicious==1)
				{
					lightFOV.scale = new FlxPoint(0.14, 0.55);
					lightFOV2.scale = new FlxPoint(0.14, 0.55);
				}
				
				lightSourceGoal.x = this.x+this.width*0.25;
				lightSourceGoal.y = this.y-(lightFOV.height)*(lightFOV.scale.y)*0.2;
				
				lightSourceGoal2.x =this.x+this.width*0.25;
				lightSourceGoal2.y = this.y+(lightFOV.height)*(lightFOV.scale.y)*0.2;
			}
			else if(facing==RIGHT)
			{
				
				lightFOV.scale = new FlxPoint(0.3, 0.6);
				lightFOV2.scale = new FlxPoint(0.3, 0.6);
			
				if(suspicious==3)
				{
					lightFOV.scale = new FlxPoint(0.15, 0.4);
					lightFOV2.scale = new FlxPoint(0.15, 0.4);
				}
				else if(suspicious==2)
				{
					lightFOV.scale = new FlxPoint(0.18, 0.58);
					lightFOV2.scale = new FlxPoint(0.18, 0.58);
				}
				else if(suspicious==1)
				{
					lightFOV.scale = new FlxPoint(0.14, 0.55);
					lightFOV2.scale = new FlxPoint(0.14, 0.55);
				}
			
				lightSourceGoal.x = this.x+this.width*0.75;
				lightSourceGoal.y = this.y-(lightFOV.height)*(lightFOV.scale.y)*0.2;
				
				lightSourceGoal2.x = this.x+this.width*0.75;
				lightSourceGoal2.y = this.y+(lightFOV.height)*(lightFOV.scale.y)*0.2;
			}
			
			var minimumDist: Number = 5;
			
			if(manhattanDistance(lightSourceGoal,new FlxPoint(lightFOV.x,lightFOV.y))<minimumDist)
			{
				lightFOV.x=lightSourceGoal.x;
				lightFOV.y= lightSourceGoal.y;
			}
			else
			{
				lightFOV.x += (lightSourceGoal.x-lightFOV.x)/4;
				lightFOV.y += (lightSourceGoal.y-lightFOV.y)/4;
			}
			
			if(manhattanDistance(lightSourceGoal2,new FlxPoint(lightFOV2.x,lightFOV2.y))<minimumDist)
			{
				lightFOV2.x=lightSourceGoal2.x;
				lightFOV2.y= lightSourceGoal2.y;
			}
			else
			{
				lightFOV2.x += (lightSourceGoal2.x-lightFOV2.x)/4;
				lightFOV2.y += (lightSourceGoal2.y-lightFOV2.y)/4;
			}
		}
		
		override public function resetToOriginalPositions():void
		{
			super.resetToOriginalPositions();
			lightFOV2.setColor(undetectedColor);
		}
		
		
		//To be overriden for different lights
		override protected function withinView(point: FlxPoint): Boolean
		{
			if(!shrunkenLight)
			{
				if(facing==DOWN || facing==UP)
				{
					return point.x>this.x-50 && point.x<this.x+this.width+50
				&& point.y>this.y-20 && point.y<this.y+this.height+20;
				}
				else
				{
					return point.x>this.x-20 && point.x<this.x+this.width+20
				&& point.y>this.y-40 && point.y<this.y+this.height+40;
				}
			}
			else
			{
				if(facing==DOWN || facing==UP)
				{
					return point.x>this.x-40 && point.x<this.x+this.width+40
				&& point.y>this.y-15 && point.y<this.y+this.height+15;
				}
				else
				{
					return point.x>this.x-10 && point.x<this.x+this.width+10
				&& point.y>this.y-30 && point.y<this.y+this.height+30;
				}
			}
			
			
			return false;
		
		}	
		
		
		
		
		override public function setNotSuspicious():void
		{
			super.setNotSuspicious();
			
			lightFOV2.setColor(0xFFFFFFFF);
			
			
		}
		
		
		override protected function resetLight(): void
		{
			lightFOV.color = 0xFFFFFFFF;	
			lightFOV2.color = 0xFFFFFFFF;	
		}
		
		override protected function suspiciousEnough(): Boolean
		{
			return lightFOV.lerpColor(0xFFFF0000,30) && lightFOV2.lerpColor(0xFFFF0000,30);
		}
		
		
	
	}//End of class
	
}//End of package declaration