package 
{
	import org.flixel.*;

	public class LadyEnemy extends Enemy
	{
		private var lightFOV2: Light;
		
		private var shrunkenLight:Boolean;
		protected var prevFacingLady: uint;
	
		public function LadyEnemy(_waypoints:Vector.<FlxPoint>, player: Player, _lightFOV1: Light, _lightFOV2: Light,  X:Number=100, Y:Number=140, _dialogNode:DialogNode=null):void {
			super(Assets.SHARK_SPRITE, _waypoints, player,_lightFOV1, X, Y,_dialogNode, 70,16,16);
			
			lightFOV2 = _lightFOV2;
			
			if(_dialogNode!=null)
			{
				enemyQuestion = _dialogNode;
			}
			else
			{
				enemyQuestion = new DialogNode(null, DialogHandler.SHARK_HEAD, "What are You doing here? In THAT dress?", Assets.SHARK_NAG);
			}
			
			
			
			//This one is the chef outfit
			outfitToUse=OutfitHandler.LADY_OUTFIT;
			
			twoMatchFOV();
			
			//Shark Sounds
			sightedSound= Assets.SHARK_SIGHTED;
		  	lostSound= Assets.SHARK_LOST;
		
			minimumDist = 24;
			
			prevFacingLady = facing;
			
			 moveLightSource();
		}
		
		
		
		
		override protected function allMatchFOV():void
		{
		}
		
		override protected function noMatchFOV():void
		{
		}
		
		override protected function oneMatchFOV():void
		{
		}
		
		override protected function twoMatchFOV():void
		{
		}
		
		override protected function setCantFindPlayerLight(): void
		{
			super.setCantFindPlayerLight();
			
			lightFOV2.setColor(cantFindPlayerColor);
		}
		
		override protected function setCantFindPlayerLightTransit(): void
		{
			super.setCantFindPlayerLightTransit();
		
			lightFOV2.lerpBetween(cantFindPlayerColor,undetectedColor,(1-(cantFindPlayerTimerMax/2-cantFindPlayerTimer)/(cantFindPlayerTimerMax/2)));
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


		override public function getCaughtPlayerStatement(): DialogNode
		{
			return new DialogNode(null, DialogHandler.SHARK_HEAD, "Excuse me fellow lady of the court- Wait! You're no courtesan!", Assets.SHARK_ANGRY_CHOMP, DialogNode.RESET_GAME);
		}
		
		//Get Positive Response
		override protected function getPositiveResponse(): DialogNode
		{
		
			var node1: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Oh! Of course! Haha, I didn't recognize you at first!", Assets.SHARK_SOPHISTICATED, DialogNode.RESET_ENEMIES)
		
			return new DialogNode(node1, DialogHandler.PLAYER_HEAD,  "I’m the guest-of-honor, and the dress is Retro.",Assets.CELESTE_DETERMINED );
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
			var response2: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Wow, you're such a rebel, you should be in jail!", Assets.SHARK_NAG, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer1, getRandomKeyboardKey(), false,  new DialogNode(response2, DialogHandler.PLAYER_HEAD, enemyAnswer1)));
			
			var response3: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Fish puns, really? Let's get you otter here.",Assets.SHARK_NAG, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer3,getRandomKeyboardKey(), false,  new DialogNode(response3, DialogHandler.PLAYER_HEAD, enemyAnswer3)));
			
			var response4: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Not on my watch! You must be that Dame Celeste!",Assets.SHARK_ANGRY_AGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer4,getRandomKeyboardKey(), false,  new DialogNode(response4, DialogHandler.PLAYER_HEAD, enemyAnswer4)));
			
			var response5: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "I am NOT confused. You're confused! And the prisoner!",Assets.SHARK_ANGRY_AGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer5,getRandomKeyboardKey(), false,  new DialogNode(response5, DialogHandler.PLAYER_HEAD, enemyAnswer5)));
			
			var response6: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Yeah, I caught you. 'Cause I'm the best.",Assets.SHARK_POWAH, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer6,getRandomKeyboardKey(), false,  new DialogNode(response6, DialogHandler.PLAYER_HEAD, enemyAnswer6)));
			
			var response7: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Well let's get you unlost, straight back to jail.",Assets.SHARK_ANGRY_AGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer7,getRandomKeyboardKey(), false,  new DialogNode(response7, DialogHandler.PLAYER_HEAD, enemyAnswer7)));
			
			var response8: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "I didn't- I... what? You confuse me, to the dungeon with you!",Assets.SHARK_CONVO, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer8,getRandomKeyboardKey(), false,  new DialogNode(response8, DialogHandler.PLAYER_HEAD, enemyAnswer8)));
			
			var response9: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "Not anymore! Back to the dungeon, lady!",Assets.SHARK_ANGRY_AGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer9,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer9)));
			
			var response10: DialogNode = new DialogNode(null, DialogHandler.SHARK_HEAD, "AHHH! A Cat! Wait. I'm a shark, not a rat! To the dungeon!",Assets.SHARK_POUT, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer10,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer10)));
			
			
		}
		
		//FIX LIGHT STUFF
		
		
		//To be overriden in other enemies for different lights
		override protected function moveLightSource(): void{
			
			if(lightFOV2!=null)
			{			
				//Where should the upper left corner of the lightSourceGoal be?
				var lightSourceGoal: FlxPoint = new FlxPoint();
				var lightSourceGoal2: FlxPoint = new FlxPoint();
			
				if(facing==UP)
				{
				
					if(prevFacingLady!=DOWN && prevFacingLady!=UP)
					{
						lightFOV.setSprite(Assets.SharkLightImage);
						lightFOV2.setSprite(Assets.SharkLightImage);
			
						if(suspicious==3)
						{
							lightFOV.setSprite(Assets.SharkLightSmall);
							lightFOV2.setSprite(Assets.SharkLightSmall);
						}
						else if(suspicious==2)
						{
							lightFOV.setSprite(Assets.SharkLightMed);
							lightFOV2.setSprite(Assets.SharkLightMed);
						}
						else if(suspicious==1)
						{
							lightFOV.setSprite(Assets.SharkLightLarge);
							lightFOV2.setSprite(Assets.SharkLightLarge);
						}
					}
			
				
					lightSourceGoal2.x = this.x+this.width+lightFOV.width/4.0;
					lightSourceGoal2.y = this.y-this.height;
				
					lightSourceGoal.x = this.x-lightFOV.width/4.0;
					lightSourceGoal.y = this.y-this.height;
				
				
				
				
				}
				else if(facing==DOWN)
				{
			
					if(prevFacingLady!=DOWN && prevFacingLady!=UP)
					{
						lightFOV.setSprite(Assets.SharkLightImage);
						lightFOV2.setSprite(Assets.SharkLightImage);
			
						if(suspicious==3)
						{
							lightFOV.setSprite(Assets.SharkLightSmall);
							lightFOV2.setSprite(Assets.SharkLightSmall);
						}
						else if(suspicious==2)
						{
							lightFOV.setSprite(Assets.SharkLightMed);
							lightFOV2.setSprite(Assets.SharkLightMed);
						}
						else if(suspicious==1)
						{
							lightFOV.setSprite(Assets.SharkLightLarge);
							lightFOV2.setSprite(Assets.SharkLightLarge);
						}
					}
				
			
					lightSourceGoal2.x = this.x+this.width+lightFOV.width/4.0;
					lightSourceGoal2.y = this.y+this.height;
				
					lightSourceGoal.x = this.x-lightFOV.width/4.0;
					lightSourceGoal.y = this.y+this.height;
				}
				else if(facing==LEFT )
				{
			
					if(prevFacingLady!=LEFT && prevFacingLady!=RIGHT){
						lightFOV.setSprite(Assets.SharkLightImageTurn);
						lightFOV2.setSprite(Assets.SharkLightImageTurn);
			
						if(suspicious==3)
						{
							lightFOV.setSprite(Assets.SharkLightSmallTurn);
							lightFOV2.setSprite(Assets.SharkLightSmallTurn);
						}
						else if(suspicious==2)
						{
							lightFOV.setSprite(Assets.SharkLightMedTurn);
							lightFOV2.setSprite(Assets.SharkLightMedTurn);
						}
						else if(suspicious==1)
						{
							lightFOV.setSprite(Assets.SharkLightLargeTurn);
							lightFOV2.setSprite(Assets.SharkLightLargeTurn);
						}
					}
				
					lightSourceGoal.x = this.x+this.width*0.75;
					lightSourceGoal.y = this.y+this.height/2-(lightFOV.height)*(1.0)*0.2;
				
					lightSourceGoal2.x = this.x+this.width*0.75;
					lightSourceGoal2.y = this.y+this.height/2+(lightFOV.height)*(1.0)*0.2;
			
				}
				else if(facing==RIGHT)
				{
				
					if(prevFacingLady!=LEFT && prevFacingLady!=RIGHT){
						lightFOV.setSprite(Assets.SharkLightImageTurn);
						lightFOV2.setSprite(Assets.SharkLightImageTurn);
			
						if(suspicious==3)
						{
							lightFOV.setSprite(Assets.SharkLightSmallTurn);
							lightFOV2.setSprite(Assets.SharkLightSmallTurn);
						}
						else if(suspicious==2)
						{
							lightFOV.setSprite(Assets.SharkLightMedTurn);
							lightFOV2.setSprite(Assets.SharkLightMedTurn);
						}
						else if(suspicious==1)
						{
							lightFOV.setSprite(Assets.SharkLightLargeTurn);
							lightFOV2.setSprite(Assets.SharkLightLargeTurn);
						}
					}
				
			
					lightSourceGoal.x = this.x+this.width*0.75;
					lightSourceGoal.y = this.y+this.height/2-(lightFOV.height)*(1.0)*0.2;
				
					lightSourceGoal2.x = this.x+this.width*0.75;
					lightSourceGoal2.y = this.y+this.height/2+(lightFOV.height)*(1.0)*0.2;
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
			
			
				if(prevFacingLady!=facing){
					prevFacingLady=facing;
				}
			}
		}
		
		override public function resetToOriginalPositions(currLevel:TopDownLevel):void
		{
			super.resetToOriginalPositions(currLevel);
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
		
		
		override protected function resetLight(): void
		{
			lightFOV.color = 0xFFFFFFFF;	
			lightFOV2.color = 0xFFFFFFFF;	
		}
		
		override protected function lerpLightBetween(distToPlayer:Number, maxDist:Number, minimumDist:Number): void
		{
			super.lerpLightBetween(distToPlayer, maxDist,minimumDist);	
			lightFOV2.lerpBetween(suspiciousColor,detectedColor, (1-distToPlayer/(maxDist-minimumDist)));

		}
	
		override protected function setDetectedLight():void
		{
			super.setDetectedLight();
			lightFOV2.setColor(detectedColor);
		}
		
		override protected function setSuspiciousLight():void
		{
			super.setSuspiciousLight();
			lightFOV2.setColor(suspiciousColor);
		}
		
	
	}//End of class
	
}//End of package declaration