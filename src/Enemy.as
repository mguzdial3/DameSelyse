package 
{
	import org.flixel.*;

	public class Enemy extends TopDownEntity
	{
	
		private var currWaypoint: int=0;
		public var waypoints: Vector.<FlxPoint>;
		
		private var currentState:int=0;
		private var WAYPOINTING: int=0;
		private var SEEKINGPLAYER: int=1;
		
		//MESSAGES THIS ENEMY CAN RETURN
		public var QUESTION_TIME:int = 1;
		private var PAUSED: int=2;
		private var player:Player;
		
		//Messages that can be passed into this enemy
		public static const NOT_ANY:int = 0;
		public static const PAUSE:int=1;
		public static const CHECK_COSTUME:int=2;
		
		
		//Used to tell the enemy what direction to move next
		private var movement: FlxPoint;
		
		//Used to tell the enemy at what speed to move
		private var speedModifier: Number=1;
		
		//The light of this enemy (has to be added in EnemyController)
		protected var lightFOV: Light;
		
		
		protected var undetectedColor: uint = 0xFFFFFFFF;
		protected var detectedColor: uint =  0xFFFF5555;
		
		//Question asking stuff
		protected var enemyQuestion: DialogNode;
		protected var enemyAnswers: Vector.<EnemyAnswer>;
		
		//For resetting character
		protected var originalPosition: FlxPoint;
		
		//What outfit to use against this enemy (different for each class)
		protected var outfitToUse:uint;
		
		
		protected var numberAnswersSuspicious: int=8; //Number of answers to have when enemy is suspicious
		protected var numberAnswersRelaxed:int = 4; //Number of answers to have when enemy is relaxed
		protected var suspicious: Boolean; //Whether or not this enemy is suspicious
		
		
		//For when paused
		protected var pausedPosition: FlxPoint;
		
		protected var hasSeenPlayer: Boolean;
		
		public function Enemy(_waypoints:Vector.<FlxPoint>, player: Player, _lightFOV: Light, X:Number=100, Y:Number=140, _dialogNode:DialogNode=null ):void {
			super(Assets.RANGER2_SPRITE, new FlxPoint(10,4), new FlxPoint(16,18), X, Y,30);
			
			
			originalPosition = new FlxPoint(X,Y);
			
			waypoints = _waypoints;
			
			this.player = player;
			
			lightFOV = _lightFOV;
			
			//Question set up
			setUpQuestion();	
			
			//This one is just the basic guard outfit
			outfitToUse=OutfitHandler.GUARD_OUTFIT;
					
			suspicious = true;	
						
			//Set up movement FlxPoint (Used as a vector)
			movement = new FlxPoint();
			currWaypoint = 0;
			
			pausedPosition = new FlxPoint(0,0);
			
			if(_dialogNode!=null)
			{
				enemyQuestion = _dialogNode;
			}
			else
			{
				enemyQuestion = new DialogNode(null, DialogHandler.FIRE_HEAD, "What are you doing here?");
			}
			
			hasSeenPlayer=false;
			
		}
		
		public function resetToOriginalPositions():void
		{
			this.x=originalPosition.x;
			this.y=originalPosition.y;
			
			//Reset to undetected state
			lightFOV.setColor(undetectedColor);
			
		}
		
		
		
		
		//To be overriden by later enemies
		protected function setUpQuestion():void
		{	
			var enemyAnswer1: String = "Failure";
			var enemyAnswer2: String = "Just guard stuff";
			var enemyAnswer3: String = 	"Losing";
			var enemyAnswer4: String = "EPIC FAILS";
			var enemyAnswer5: String = "Your Mom";
			var enemyAnswer6: String = "Sucking";
			var enemyAnswer7: String = "Being Terrible";
			var enemyAnswer8: String = "I'm the Prisoner";
			var enemyAnswer9: String = "Escaping!";
			var enemyAnswer10: String = "Not winning";
			
			
			enemyAnswers = 	new Vector.<EnemyAnswer>();
			
			//THE CORRECT ANSWER NEEDS TO BE THE FIRST ONE
			enemyAnswers.push(new EnemyAnswer(enemyAnswer2,getRandomKeyboardKey(),true));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer1, getRandomKeyboardKey()));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer3,getRandomKeyboardKey()));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer4,getRandomKeyboardKey()));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer5, getRandomKeyboardKey()));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer6,getRandomKeyboardKey()));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer7,getRandomKeyboardKey()));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer8, getRandomKeyboardKey()));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer9,getRandomKeyboardKey()));
			enemyAnswers.push(new EnemyAnswer(enemyAnswer10,getRandomKeyboardKey()));
			
		}
		
		//Can just use this in every enemy to come after
		public function getRandomKeyboardKey(): String
		{
			var keys:Array = new Array("Q", "W", "E", "R", "T",
			"Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", 
			"J", "K", "L", "Z", "X", "C", "V", "B", "N", "M");
			
			return keys[((int)(Math.random()*26 ))];
		
		}
		
		public function getQuestion(): DialogNode
		{
			return enemyQuestion;
		}
		
		public function getAnswers(): Vector.<EnemyAnswer>
		{
			var numberOfAnswers:int = numberAnswersSuspicious;
			
			if(!suspicious)
			{
				numberOfAnswers = numberAnswersRelaxed;
			}
			
			var answersToReturn: Vector.<EnemyAnswer> = new Vector.<EnemyAnswer>();
			
			//Always return the correct answer WHICH SHOULD BE THE FIRST ONE
			answersToReturn.push(enemyAnswers[0]);
			
			var i:int;
			
			while(i<numberOfAnswers-1)
			{
				//Grab a random answer that isn't the first one
				answersToReturn.push(enemyAnswers[(int)(Math.random()*(enemyAnswers.length-1))+1]);
				i++;
			}
			
			return answersToReturn;
		}
		
		
		//To be overriden in other enemies for different lights
		protected function moveLightSource(): void{
			
			//Where should the upper left corner of the lightSourceGoal be?
			var lightSourceGoal: FlxPoint = new FlxPoint();
			
			
			if(facing==UP)
			{
				lightSourceGoal.x = this.x+this.width/2;
				lightSourceGoal.y = this.y-this.height*2;//-lightFOV.height/2;
			}
			else if(facing==DOWN)
			{
				lightSourceGoal.x = this.x+this.width/2//-lightFOV.width/2;
				lightSourceGoal.y = this.y+this.height;//+this.height;
			}
			else if(facing==LEFT)
			{
				lightSourceGoal.x = this.x-this.width;//-lightFOV.width;
				lightSourceGoal.y = this.y-this.height/2//-lightFOV.height/2;
			}
			else if(facing==RIGHT)
			{
				lightSourceGoal.x = this.x+this.width*2;//+lightFOV.width;
				lightSourceGoal.y = this.y-this.height/2;//-lightFOV.height/2;
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
		}
		
		
		//To be overriden for different lights
		protected function withinView(point: FlxPoint): Boolean
		{
			var within: Boolean= false;
			
			var distanceFromCenter:Number = manhattanDistance(point, new FlxPoint(lightFOV.x, lightFOV.y));
			
			var radiusOfLight: Number = (lightFOV.scale.x*lightFOV.width)/4;
			
			if(distanceFromCenter<radiusOfLight)
			{
				within=true;
			}
			
			return within;
		
		}	
		
		public function setNotSuspicious():void
		{
			lightFOV.setColor(0xFFFFFFFF);
			
			currentState=WAYPOINTING;
		}
		
		
		private function regularGameplay():int
		{
			//MOVE THE LIGHT SOURCE
			moveLightSource();
		
			var goalPoint: FlxPoint = new FlxPoint(this.x,this.y);
			var minimumDist:Number = 15;
			if(currentState==WAYPOINTING)
			{	
			
				lightFOV.lerpColor(0xFFFFFFFF,80);	
		
				goalPoint =waypoints[currWaypoint];
				//goalPoint = new FlxPoint(player.x,player.y);
		
		
				
		
				if(manhattanDistance(goalPoint,new FlxPoint(this.x,this.y))<minimumDist)
				{
					super.hardStop();
		
					if(currWaypoint<waypoints.length-1)
					{
						currWaypoint++;
					}
					else
					{
						currWaypoint=0;
					}
			
				}
		
		
				//Check how to transfer into seeking player state
				if(withinView(new FlxPoint(player.x,player.y)) && !player.getHiding())
				{
					currentState=SEEKINGPLAYER;
				}
				
		
			}
			else if(currentState==SEEKINGPLAYER)
			{
			
				if(lightFOV.lerpColor(0xFFFF0000,50))
				{
					return QUESTION_TIME;
				}
			
			
				goalPoint = new FlxPoint(player.x,player.y);
				
				
				if(!withinView(new FlxPoint(player.x,player.y)))
				{
				
					
					currentState=WAYPOINTING;
				}
				
				
			}
			
			
			var distanceToGoal: Number = manhattanDistance(goalPoint,new FlxPoint(this.x,this.y));
		
				speedModifier=1;
		
				if(distanceToGoal>(minimumDist+1) && distanceToGoal<minimumDist*2)
				{
					speedModifier = (distanceToGoal-(minimumDist+1))/(minimumDist+1);
				}
		
		
		
				movement = new FlxPoint();
		
				var bufferZone: int = 3;	
			
				if(this.x<goalPoint.x-bufferZone)
				{
				//Move right
					movement.x += 1;
				}
				else if(this.x>goalPoint.x+bufferZone)
				{
					//On left
					movement.x -= 1;
				}
		
				if(this.y<goalPoint.y-bufferZone)
				{
					//Move down
					movement.y += 1;
				}
				else if(this.y>goalPoint.y+bufferZone)
				{
					//Move up
					movement.y -= 1;
				}
			return 0;
		}
		
		//CALLED FROM ENEMYCONTROLLER, MAKES ALL THE THINGS HAPPEN
		public function command(commandMessage: int=0):int {
		
			
		
			if(commandMessage==NOT_ANY)
			{
			
			if(pausedPosition.x!=0)
			{
				pausedPosition = new FlxPoint(0,0);
			}			
				return regularGameplay();
			}		
			else if(commandMessage==PAUSE)
			{
				if(pausedPosition.x==0)
				{
					pausedPosition = new FlxPoint(x,y);
				}
			
				super.hardStop();
				super.setPaused(true);
				
			}
			else if(commandMessage==CHECK_COSTUME)
			{
				checkPlayerOutfit();
			
			}
					
			return 0;
		
		}
		
		
		
		//THIS TECHNICALLY MOVES THE ENEMY, BUT ONLY CAUSE OF STUFF FROM COMMAND
		override protected function updateControls():void {
			super.updateControls();
			
			
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
			
		}
		
		//Checks to see if player is wearing correct outfit to shrink FOV
		//if so, does. if not, sets to normal
		public function checkPlayerOutfit():void
		{
			
			var numCorrect:int=0;
			
			if(player.sameHeadOutfitType(outfitToUse))
			{
				numCorrect++;
			}
			if(player.sameBodyOutfitType(outfitToUse))
			{
				numCorrect++;
			}
			if(player.sameLegsOutfitType(outfitToUse))
			{
				numCorrect++;
			}
			
			if(numCorrect==3)
			{
				suspicious=false;
				shrinkFOV();
			}
			else
			{
				suspicious=true;
				resetFOV();
			}
			
			
		}
		
		//To be overriden for how other lightFOV's shrink
		protected function shrinkFOV():void
		{
			lightFOV.scale= new FlxPoint(0.35,0.35);
		}
		
		protected function resetFOV():void
		{
			lightFOV.scale= new FlxPoint(0.6,0.6);
		}
		
		
		/**
		 *Simple manhattan distance (public so we can use it later)
		 */
		private function manhattanDistance(firstPoint: FlxPoint, secondPoint: FlxPoint): Number
		{
			var distanceBetween: Number = Math.sqrt(Math.pow((secondPoint.x-firstPoint.x),2)
			+ Math.pow((secondPoint.y-firstPoint.y),2));
			
			return distanceBetween;
		}
		
		public function getHasSeenPlayer():Boolean
		{
			return hasSeenPlayer;
		}
		
		public function youSawThePlayer():void
		{
			hasSeenPlayer = true;
		}
		
	
	}//End of class
	
}//End of package declaration