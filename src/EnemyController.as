package
{
	import org.flixel.*;
	
	//Extends FlxGroup so that we can add stuff to it and then add the group and it all shows up
	public class EnemyController extends FlxGroup
	{
		public var enemies: Vector.<Enemy>;
		public var NOT_ANY:int = 0;
		public var PAUSE_ALL:int=1;
		
		public var numEnemies:int;
		
		private var currState:int=2;
		private var NORMAL_GAMEPLAY:int =2;
		private var QUESTION_TIME:int =3;
		
		
		public function EnemyController(_enemies: Vector.<Enemy>)
		{
			super();
			enemies = _enemies;	
			
			var i:int;
			for(i=0; i<enemies.length; i++)
			{
				add(enemies[i]);
				add(enemies[i].mySprite);	
			}
			
		}
		
		public function enterQuestionMode(enemy: Enemy):void
		{
			currState = QUESTION_TIME;
			
						
		}
		
		
		public function commandEnemies(specialCommand: int=0):int
		{
			var messageToReturn:int=0;
			
			if(specialCommand==NOT_ANY)
			{
				var i:int;
				var myMessage:int;
				if(currState==NORMAL_GAMEPLAY)
				{
					
					for(i=0; i<enemies.length; i++)
					{
						myMessage= enemies[i].command();
					
						//Enter Question Time
						if(myMessage==enemies[i].QUESTION_TIME)
						{
							enterQuestionMode(enemies[i]);
						}
					}
				}
				else if(currState==QUESTION_TIME)
				{
					for(i=0; i<enemies.length; i++)
					{
						myMessage = enemies[i].command(1);
					
						
						
						
					}
				}
			}
		
			return messageToReturn;
		}
		
		
		
		
		
		
	}
}