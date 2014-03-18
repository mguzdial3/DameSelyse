package
{
	import org.flixel.*;
	
	//Extends FlxGroup so that we can add stuff to it and then add the group and it all shows up
	public class EnemyController extends FlxGroup
	{
		public var enemies: Vector.<Enemy>;
		
		//COMMANDS THAT CAN BE PASSED IN
		public static const NOT_ANY:int = 0;
		public static const PAUSE_ALL:int=1;
		public static const CHECK_COSTUME:int=2;
				
		private var currState:int=2;
		
		//STATES
		public static const NORMAL_GAMEPLAY:int =2;
		public static const QUESTION_TIME:int =3;
		
		//RETURN MESSAGES
		public static const ENEMY_SPOTTED_PLAYER:int =4;
		public static const NOTHING_SPECIAL:int = 5;
		public static const RELOAD_LEVEL:int =6;
		
		
		
		
		protected var currQuestion: DialogNode;
		protected var caughtPlayerStatement: DialogNode;
		protected var currResponses: Vector.<DialogNode>;
		protected var currAnswers: Vector.<EnemyAnswer>;
		
		public function EnemyController(_enemies: Vector.<Enemy>)
		{
			super();
			enemies = _enemies;	
			
			var i:int;
			for(i=0; i<enemies.length; i++)
			{
				enemies[i].addEnemy(this);	
			}
			
		}
		
		public function addGUIBits(group:FlxGroup):void
		{
			var i:int;
			for(i=0; i<enemies.length; i++)
			{
				enemies[i].addExpressionSprite(group);	
				
			}
		}
		
		private function enterQuestionMode(enemy: Enemy):void
		{
			currState = QUESTION_TIME;
			
			currQuestion = enemy.getQuestion();
			currAnswers = enemy.getAnswers();
			currResponses = enemy.getResponses(currAnswers);
		}
		
		private function enterFinalStatement(enemy: Enemy):void
		{
			currState = QUESTION_TIME;
			
			caughtPlayerStatement = enemy.getCaughtPlayerStatement();
		}
		
		
		
		//After player answers questions correctly, reset enemies to original position
		public function resetEnemies(currLevel:TopDownLevel): void
		{
			var i:int;
			
			for(i=0; i<enemies.length; i++)
			{
				enemies[i].setPaused(false);
				enemies[i].resetToOriginalPositions(currLevel);
				enemies[i].setNoLongerSuspicious();
			}
			
			currState=NORMAL_GAMEPLAY;
		}
		
		public function setNormalGameplay(): void
		{
			currState = NORMAL_GAMEPLAY;
		}
		
		public function getCaughtPlayerStatement(): DialogNode
		{
			return caughtPlayerStatement;
		}
		
		public function getQuestion(): DialogNode
		{
			return currQuestion;
		}
		
		public function getAnswers(): Vector.<EnemyAnswer>
		{
			return currAnswers;
		}
		
		public function getResponses(): Vector.<DialogNode>
		{
			return currResponses;
		}
		
		/**
		 * Check all enemies and see if the player is now wearing the right outfit
		 */
		public function checkCorrectOutfit(): void
		{
			var i:int;
			
			
			for(i=0; i<enemies.length; i++)
			{
				enemies[i].checkPlayerOutfit();
			}
		}
		
		//Clears all enemies suspicions
		public function clearAllSuspicions():void
		{
			var i:int;
			for(i=0; i<enemies.length; i++)
			{
				enemies[i].setNotSuspicious();
			}
			
		}
		
		public function commandEnemies(currLevel: TopDownLevel, specialCommand: int=NOT_ANY):int
		{
			var messageToReturn:int=NOTHING_SPECIAL;
			
			if(specialCommand==CHECK_COSTUME)
			{
				checkCorrectOutfit();
			}
			
			
			if(specialCommand==NOT_ANY )
			{
				var i:int;
				var myMessage:int;
				if(currState==NORMAL_GAMEPLAY)
				{
					
					for(i=0; i<enemies.length; i++)
					{	
					//improving run speed test
					/**
						if(enemies[i].x>FlxG.camera.scroll.x-100 &&
						enemies[i].x<FlxG.camera.scroll.x+100 +320
						&& enemies[i].y>FlxG.camera.scroll.y-100 
						&& enemies[i].y<FlxG.camera.scroll.y+240+100)
						{ 
					*/
						myMessage= enemies[i].command(currLevel);
					
						//Enter Question Time
						if(myMessage==enemies[i].QUESTION_TIME)
						{
							enterQuestionMode(enemies[i]);
							messageToReturn =ENEMY_SPOTTED_PLAYER;
								
						}
						else if(myMessage==enemies[i].FOUND_PLAYER)
						{
							//Send the reload thing
							enterFinalStatement(enemies[i]);
							messageToReturn =RELOAD_LEVEL;
						}
					}
				}
				else if(currState==QUESTION_TIME)
				{
				
					//TopDownLevel.printText2.text = "Got to here";
					for(i=0; i<enemies.length; i++)
					{
						//Testing this
						myMessage = enemies[i].command(currLevel, Enemy.PAUSE);
						
						
					}
				}
			}
			else if(specialCommand==PAUSE_ALL)
			{
				for(i=0; i<enemies.length; i++)
				{
					enemies[i].hardStop();
					
						
				}
			}
		
			return messageToReturn;
		}
		
		
		
		
		
		
		
		
	}
}