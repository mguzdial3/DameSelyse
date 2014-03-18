package 
{
	import org.flixel.*;

	public class Enemy extends TopDownEntity
	{
	
		private var currWaypoint: int=0;
		public var waypoints: Vector.<FlxPoint>;
		
		private var currMomentary:int = 0;
		public var momentaryWaypoints: Vector.<FlxPoint>;
		
		//Random movement off playerpnt
		private var playerPntDiff: FlxPoint;
		
		protected var currentState:int=0;
		protected var WAYPOINTING: int=0;
		protected var SEEKINGPLAYER: int=1;
		
		//MESSAGES THIS ENEMY CAN RETURN
		public var QUESTION_TIME:int = 1;
		public var FOUND_PLAYER: int=2;
		
		private var player:Player;
		
		//Messages that can be passed into this enemy
		public static const NOT_ANY:int = 0;
		public static const PAUSE:int=1;
		public static const CHECK_COSTUME:int=2;
		
		//Type of enemy
		public var enemyType:uint =0;
		public static const NORMAL_BEHAVIOR:uint = 0;
		public static const TURNING:uint = 1;
		
		//amount of time to wait at each waypoint
		private var waypointWaitTime:Number = 0;
		private var waypointWaitTimeMax:Number = 0;
		
		//amount of time to wait tu turn
		private var turningTime:Number = 0;
		
		//Used to tell the enemy what direction to move next
		protected var movement: FlxPoint;
		
		//Used to tell the enemy at what speed to move
		protected var speedModifier: Number=1;
		
		//The light of this enemy (has to be added in EnemyController)
		protected var lightFOV: Light;
		
		
		protected var undetectedColor: uint = 0xFFFFFFFF;
		protected var suspiciousColor: uint =  0xFFFFFF00;
		protected var detectedColor: uint =  0xFFFF0000;
		protected var cantFindPlayerColor:uint = 0xFF2222FF;
		
		//Question asking stuff
		protected var enemyQuestion: DialogNode;
		protected var enemyAnswers: Vector.<EnemyAnswer>;
		
		//For resetting character
		protected var originalPosition: FlxPoint;
		
		//What outfit to use against this enemy (different for each class)
		protected var outfitToUse:uint;
		
		
		protected var numberAnswersSuspicious: int=8; //Number of answers to have when enemy is suspicious
		protected var numberAnswersRelaxed:int = 4; //Number of answers to have when enemy is relaxed
		protected var suspicious: int; //Whether or not this enemy is suspicious
		
		
		//For when paused
		protected var pausedPosition: FlxPoint;
		
		protected var hasSeenPlayer: Boolean;
		
		//Expression Sprite
		protected var expressionSprite: FlxSprite; 
		protected var expressionTimer: Number; 
		protected var expressionTimerMax:Number = 1.0;
		
		//Memory Stuff
		protected var giveUpTimer:Number=0.0; 
		protected var giveUpTimerMax: Number = 5.0; 
		protected var playerPoint: FlxPoint; //Last point we saw the player at
		protected var seesPlayer:Boolean;
		
		//Sound Stuff
		protected var sightedSound: Class;
		protected var lostSound: Class;
		
		//Timer for small bit of freedom escaping the guards gives you
		protected var cantFindPlayerTimer:Number=0;
		protected var cantFindPlayerTimerMax:Number = 6;
		
		//FOR TESTING
		private var hasPrintedOut: Boolean;
		
		//Previous direction this char was facing
		private var prevFacing: uint;
		
		//Certainty that the person running aboot it is the player
		private var certaintyTimer:Number;
		private var certaintyTimerMax:Number = 3.0; //was 6
		private var autoCatchDist:Number = 12;
		
		//For facing when paused while waypointing
		private var hasPreferredFacing:Boolean = false;
		private var preferredFacing: uint;
		
		public var d: uint = 4096;
		public var l: uint = 1;
		public var r: uint = 16;
		public var u: uint = 256;
		
		
		protected var goalPoint: FlxPoint;
		
		
		
		public function Enemy(imgToUse: Class, _waypoints:Vector.<FlxPoint>, player: Player, _lightFOV: Light, X:Number=100, Y:Number=140, _dialogNode:DialogNode=null, _runSpeed:int = 40, xSize:int=15,ySize:int=18, _enemyType:uint=0, _waypointWaitTimeMax:Number=0):void {
			super(imgToUse, new FlxPoint(10,4), new FlxPoint(xSize,ySize), X, Y,_runSpeed);
			hasPrintedOut= true;
			
			originalPosition = new FlxPoint(X,Y);
			
			waypoints = _waypoints;
			
			this.player = player;
			
			lightFOV = _lightFOV;
			
			//Question set up
			setUpQuestion();	
			
			enemyType = _enemyType;
			waypointWaitTimeMax = _waypointWaitTimeMax;
			
			//This one is just the basic guard outfit
			outfitToUse=OutfitHandler.GUARD_OUTFIT;
					
			suspicious = 0;	
						
			//Set up movement FlxPoint (Used as a vector)
			movement = new FlxPoint();
			currWaypoint = 0;
			
			//Tried changing this to 1/2 of a second from 1/6
			drag = new FlxPoint(runSpeed * 2, runSpeed * 2);
			
			pausedPosition = new FlxPoint(0,0);
			
			if(_dialogNode!=null)
			{
				enemyQuestion = _dialogNode;
			}
			else
			{
				enemyQuestion = new DialogNode(null, DialogHandler.CAT_HEAD, "Who are mew? What are you doing here?", Assets.CAT_GUARD_JABBER);
			}
			
			sightedSound=Assets.CAT_GUARD_SIGHTED;
			
			lostSound = ( Assets.CAT_GUARD_LOST);
			
			//Instantiate exclamation thing
			expressionSprite = new FlxSprite(x,y);
			expressionSprite.makeGraphic(4, 8, 0xFFFFFF00); 
			expressionSprite.alpha = 0;
			
			hasSeenPlayer=false;
			
			
			if(waypoints.length==1)
			{
				waypoints[0] = new FlxPoint(originalPosition.x,originalPosition.y);
			}
			else if(waypoints.length<1)
			{
				var waypointList0: Vector.<FlxPoint> = new Vector.<FlxPoint>(); 

				

				waypointList0.push(originalPosition.x, originalPosition.y);
				waypoints = waypointList0; 
			}
			
			lightFOV.x = this.x+this.width/2;
			lightFOV.y = this.y+this.height;
			
			//Set certainty timer to 0
			certaintyTimer=0;
			
		}
		
		public function resetToOriginalPositions(currLevel:TopDownLevel):void
		{
			//this.x=originalPosition.x;
			//this.y=originalPosition.y;
			
			if(currentState!=WAYPOINTING)
			{
				//Reset to undetected state
				lightFOV.setColor(undetectedColor);
			
			
				//Set certainty timer to 0 again
				certaintyTimer = 0;
			
				
				//Hide sprite if showing
				expressionTimer = 0;
				expressionSprite.makeGraphic(4, 8, 0xFFFFFF00); 
				expressionSprite.alpha = 0;
			
				currentState=WAYPOINTING;
				cantFindPlayerTimer = cantFindPlayerTimerMax;
				lightFOV.setColor(cantFindPlayerColor);
				
				
				//Get the path figured out
				if(waypoints.length!=1)
				{
					//Only have one waypoints
				}
				else
				{
					
					var currDist:Number = Math.sqrt(Math.pow(waypoints[currWaypoint].x-this.x,2)
					+Math.pow(waypoints[currWaypoint].y-this.y,2));
					var j:int = 0;
						
					for(j=0; j<waypoints.length; j++)
					{
						if(j!=currWaypoint)
						{
							var dist:Number = Math.sqrt(Math.pow(waypoints[j].x-this.x,2)
							+Math.pow(waypoints[j].y-this.y,2));
								
							if(currDist>dist)
							{
								currWaypoint = j;
							}
								
						}
						
					}
					
					
					
				}
					
					//aStar2(waypoints[currWaypoint],currLevel);
				
			}
		}
		
		override public function createAnimations():void {
			
			mySprite.addAnimation("idle_up", [4]);
			
			mySprite.addAnimation("idle_right", [2,2,2,2,2,2,2,2,2,2,2,3], 12, true);
			mySprite.addAnimation("idle_down", [0,0,0,0,0,0,0,0,0,0,0,1],12, true);
			mySprite.addAnimation("idle_left", [2,2,2,2,2,2,2,2,2,2,2,3], 12, true);
			mySprite.addAnimation("walk_up", [13, 14, 15, 16], 10); // 12 = frames per second for this animation
			mySprite.addAnimation("walk_down", [9, 10, 11, 12], 10);
			mySprite.addAnimation("walk_horz", [5, 6, 7,8], 10);
			
		}
		
		
		//Get Positive Response
		protected function getPositiveResponse(): DialogNode
		{
			var node1: DialogNode = 	 new DialogNode(null, DialogHandler.CAT_HEAD, "Oh, well carry on then.",Assets.CAT_GUARD_AGREE, DialogNode.RESET_ENEMIES)
		
			return new DialogNode(node1, DialogHandler.PLAYER_HEAD,  "You know... Guard stuff",Assets.CELESTE_DETERMINED );
			
		
		}
	
		
		//To be overriden by later enemies
		protected function setUpQuestion():void
		{	
			var enemyAnswer1: String = "Impersonating a guard";
			var enemyAnswer2: String = "You know... Guard stuff";
			var enemyAnswer3: String = 	"Getting caught.";
			var enemyAnswer4: String = "Nothing...";
			var enemyAnswer5: String = "Your Mother";
			var enemyAnswer6: String = "This is not the prisoner you're looking for.";
			var enemyAnswer7: String = "What are YOU doing?";
			var enemyAnswer8: String = "I'm the Prisoner!";
			var enemyAnswer9: String = "Escaping!";
			var enemyAnswer10: String = "MEOW";
			
			
			enemyAnswers = 	new Vector.<EnemyAnswer>();
			
			enemyAnswers.push(new EnemyAnswer(enemyAnswer2,getRandomKeyboardKey(),true));
			var response2: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "Oh, alright- WAIT A MINUTE. You're Dame Celeste! Back to your cell, young lady!", Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer1, getRandomKeyboardKey(), false,  new DialogNode(response2, DialogHandler.PLAYER_HEAD,  enemyAnswer1, Assets.CELESTE_TOUGH)));
			
			var response3: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "Wait. What? Oh! You must be Celeste. Let's get you back to your cell.", Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer3,getRandomKeyboardKey(), false,  new DialogNode(response3, DialogHandler.PLAYER_HEAD, enemyAnswer3,Assets.CELESTE_TOUGH)));
			
			var response4: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "Oh, just chilling? WAIT- You're Dame Celeste! Back to prison with you!",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer4,getRandomKeyboardKey(), false,  new DialogNode(response4, DialogHandler.PLAYER_HEAD, enemyAnswer4,Assets.CELESTE_TOUGH)));
			
			var response5: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "...That's really rude. Back to your cell, Celeste, and think about what you've done.",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer5,getRandomKeyboardKey(), false,  new DialogNode(response5, DialogHandler.PLAYER_HEAD, enemyAnswer5,Assets.CELESTE_TOUGH)));
			
			var response6: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "You aren't the prisoner I'm looking for... Wait, yes you are!", Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer6,getRandomKeyboardKey(), false,  new DialogNode(response6, DialogHandler.PLAYER_HEAD, enemyAnswer6,Assets.CELESTE_TOUGH)));
			
			var response7: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "Um, you know, guard stuff? Wait a second, I don't have to explain myself! Back to your cell!",Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer7,getRandomKeyboardKey(), false,  new DialogNode(response7, DialogHandler.PLAYER_HEAD, enemyAnswer7,Assets.CELESTE_TOUGH)));
			
			var response8: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "Oh! What are you doing out of your cell then? Let's get you back.", Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer8,getRandomKeyboardKey(), false,  new DialogNode(response8, DialogHandler.PLAYER_HEAD, enemyAnswer8,Assets.CELESTE_TOUGH)));
			
			var response9: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "Not anymore! Back to your cell, young lady!", Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer9,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer9,Assets.CELESTE_TOUGH)));
			
			var response10: DialogNode = new DialogNode(null, DialogHandler.CAT_HEAD, "First of all, how dare you. Second, back to your cell!", Assets.CAT_GUARD_DISAGREE, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer10,getRandomKeyboardKey(), false,  new DialogNode(response10, DialogHandler.PLAYER_HEAD, enemyAnswer10,Assets.CELESTE_TOUGH)));
			
			
		}
		
		//Can just use this in every enemy to come after
		public function getRandomKeyboardKey(): String
		{
			var keys:Array = new Array("Q", "W", "E", "R", "T",
			"Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", 
			"J", "K", "L", "Z", "C", "V", "B", "N", "M");
			
			return keys[((int)(Math.random()*25 ))];
		
		}
		
		public function getCaughtPlayerStatement(): DialogNode
		{
			return new DialogNode(null, DialogHandler.CAT_HEAD, "Who are mew-? Oh! You're Dame Celeste! Back to your cell!", Assets.CAT_GUARD_JABBER, DialogNode.RESET_GAME);
		}
		
		public function getQuestion(): DialogNode
		{
			return enemyQuestion;
		}
		
		public function getAnswers(): Vector.<EnemyAnswer>
		{
			var numberOfAnswers:int = numberAnswersSuspicious;
			
			if(suspicious==3)
			{
				numberOfAnswers = numberAnswersRelaxed;
			}
			else if(suspicious==1 || suspicious==2)
			{
				numberOfAnswers = 6;
			}
			
			var answersToReturn: Vector.<EnemyAnswer> = new Vector.<EnemyAnswer>();
			
			//Always return the correct answer WHICH SHOULD BE THE FIRST ONE
			answersToReturn.push(enemyAnswers[0]);
			
			var i:int;
			
			
			
			while(i<numberOfAnswers-1)
			{
				//Grab a random answer that isn't the first one
				var answer: EnemyAnswer = enemyAnswers[(int)(Math.random()*(enemyAnswers.length-1))+1];
				
				
				if(answersToReturn.indexOf(answer)==-1)
				{
					answersToReturn.push(answer);
					i++;
				}
				
			}
			
			return answersToReturn;
		}
		
		public function getResponses(answers: Vector.<EnemyAnswer>): Vector.<DialogNode>
		{
			var responsesToReturn: Vector.<DialogNode> = new Vector.<DialogNode>();
			responsesToReturn.push(getPositiveResponse());
			
			var i: int=1; 
			
			while(i<answers.length)
			{
				responsesToReturn.push(answers[i].getResponse());
				
				i++;
			}
			
			return responsesToReturn;
			
		}
		
		
		public function addEnemy(groupToAddTo: FlxGroup): void
		{
			groupToAddTo.add(this);
			groupToAddTo.add(mySprite);
			
		}
		
		public function addExpressionSprite(groupToAddTo: FlxGroup): void
		{
			groupToAddTo.add(expressionSprite);
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
				lightSourceGoal.x = this.x+this.width/2;//-lightFOV.width/2
				lightSourceGoal.y = this.y+this.height;//+this.height;
			}
			else if(facing==LEFT)
			{
				lightSourceGoal.x = this.x-this.width;//-lightFOV.width;
				lightSourceGoal.y = this.y-this.height/2;//-lightFOV.height/2
			}
			else if(facing==RIGHT)
			{
				lightSourceGoal.x = this.x+this.width*2;
				lightSourceGoal.y = this.y-this.height/2;
			}
			
			var minimumDist: Number = 5;//was 5
			
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
			
			//TEST
			if(distanceFromCenter<radiusOfLight*3)
			{
				//TopDownLevel.printText2.text ="Dist, Rad: "+int(distanceFromCenter)+", "+int(radiusOfLight);
			}
						
			if(distanceFromCenter<radiusOfLight)
			{
				
					within=true;
			}
			
			return within;
		
		/**
			var within: Boolean= false;
			
			var lightSourceGoal: FlxPoint = new FlxPoint();
			
			
			if(facing==UP)
			{
				lightSourceGoal.x = this.x+this.width/2;
				lightSourceGoal.y = this.y-this.height*2;
			}
			else if(facing==DOWN)
			{
				lightSourceGoal.x = this.x+this.width/2;
				lightSourceGoal.y = this.y+this.height;
			}
			else if(facing==LEFT)
			{
				lightSourceGoal.x = this.x-this.width;
				lightSourceGoal.y = this.y-this.height/2;
			}
			else if(facing==RIGHT)
			{
				lightSourceGoal.x = this.x+this.width*2;
				lightSourceGoal.y = this.y-this.height/2;
			}
			
			
			var distanceFromCenter:Number = manhattanDistance(point, new FlxPoint(lightSourceGoal.x+this.width, lightSourceGoal.y+this.width));
			
			//Changing this
			var radiusOfLight: Number = this.width*4;//(lightFOV.scale.x*lightFOV.width)/3;//Making this a bit larger
			
			if(distanceFromCenter<radiusOfLight)
			{
				within=true;
			}
			
			return within;
			
		*/
		
		}	
		
		public function setNotSuspicious():void
		{
			//lightFOV.setColor(0xFFFFFFFF);
			
			
			
			//currentState=WAYPOINTING;
		}
		
		public function setNoLongerSuspicious():void
		{
			lightFOV.setColor(0xFFFFFFFF);
			
			
			
			currentState=WAYPOINTING;
		}
		
		
		
		protected function resetLight(): void
		{
			lightFOV.color = 0xFFFFFFFF;	
		}
		
		protected function suspiciousEnough(): Boolean
		{
			return lightFOV.lerpColor(0xFFFF0000,60);
		}
		
		public function setPreferredFacing(_facing:uint):void
		{
			hasPreferredFacing=true;
			preferredFacing= _facing;
		}
		
		private function regularGameplay(currLevel: TopDownLevel):int
		{
			//MOVE THE LIGHT SOURCE
			moveLightSource();
			
			//Move to above player
			expressionSprite.x = mySprite.x+mySprite.width/2-expressionSprite.width/2;
			expressionSprite.y = this.y-this.height*4-expressionSprite.height;
				
				
			
			//Handle the expressionSprite; 
			if(expressionTimer>0)
			{
				expressionTimer-=FlxG.elapsed; 

				if(expressionTimer<=0)
				{
					//expressionSprite.makeGraphic(4, 8, 0xFFFF0000);
					expressionSprite.alpha = 0;
				}
			}
			
		
			goalPoint = new FlxPoint(this.x,this.y);
			var minimumDist:Number = 20;//TRY: CHANGING FROM 15
			if(currentState==WAYPOINTING)
			{	
				//Reset light used to go here
				
				//Even older than reset light
				//lightFOV.lerpColor(0xFFFFFFFF,80);	
				
				//MOVING THE ENEMY
				if(momentaryWaypoints!=null)
				{
					if(manhattanDistance(momentaryWaypoints[currMomentary],new FlxPoint(this.x,this.y))<minimumDist)
					{
						if(currMomentary>1)
						{
							//hardStop();
						}
					
						if(currMomentary>0)
						{
							currMomentary--;
							goalPoint = momentaryWaypoints[currMomentary];
						}
						else
						{
							momentaryWaypoints=null;	
						}
			
					}
					goalPoint = momentaryWaypoints[currMomentary];
				}
				else
				{
					
					
					if(manhattanDistance(waypoints[currWaypoint],new FlxPoint(this.x,this.y))<minimumDist)
					{
						//Tested added this, NO GOOD CAN'T LAND
						//super.hardStop();
						if(waypointWaitTime>=waypointWaitTimeMax)
						{
							waypointWaitTime=0;
							if(currWaypoint<waypoints.length-1)
							{
								currWaypoint++;
							}
							else
							{
								currWaypoint=0;
							}
					
							if(waypoints.length==1)
							{
								facing = DOWN;
								mySprite.facing = DOWN;
							
							
							}
						}
						else
						{
							hardStop();
							waypointWaitTime+=FlxG.elapsed;
							
						}
			
					}
					
					//Attempt to add 
					if(waypoints.length==1)
					{	
						if(waypoints[currWaypoint].x==this.x)
						{
							hardStop();
						}	
						
						if(waypoints[currWaypoint].y==this.y)
						{
							hardStop();
						}
						
					}
					
					goalPoint = waypoints[currWaypoint];
				
				}
		
				//Check how to transfer into seeking player state
				if(withinView(new FlxPoint(player.x,player.y)) && !player.getHiding() && cantFindPlayerTimer<=0)
				{
					
					if(playerSeeable(currLevel))
					{
						expressionSprite.loadGraphic(Assets.EXCLAMATION); 
						expressionSprite.alpha = 1;
						expressionTimer=expressionTimerMax;
						currentState=SEEKINGPLAYER;
						FlxG.play(sightedSound);
						momentaryWaypoints = new Vector.<FlxPoint>();
					
						giveUpTimer = giveUpTimerMax;
						playerPoint = new FlxPoint(player.x,player.y);
					
						seesPlayer=true;
						
						//Change: Saw player set light to yellow
						lightFOV.setColor(suspiciousColor);
					}
				}
				
				if(cantFindPlayerTimer>0)
				{
				
					if(cantFindPlayerTimer>cantFindPlayerTimerMax/2)
					{
						lightFOV.setColor(cantFindPlayerColor);
					}
					else
					{
						lightFOV.lerpBetween(cantFindPlayerColor,undetectedColor,(1-(cantFindPlayerTimerMax/2-cantFindPlayerTimer)/(cantFindPlayerTimerMax/2)));
					}
					
					cantFindPlayerTimer-=FlxG.elapsed;
					
					if(cantFindPlayerTimer<=0)
					{
						resetLight();
					}
					
				}
				
				
				
		
			}
			else if(currentState==SEEKINGPLAYER)
			{
				var distToPlayer:Number = manhattanDistance(new FlxPoint(player.x,player.y), new FlxPoint(this.x,this.y));
				
				
				//TRY: Try removing the need for the player to be seeable if it's withinView and we're already seeking her
				if(withinView(new FlxPoint(player.x,player.y)) && !player.getHiding() 
					&& closeEnoughToPlayer(new FlxPoint(player.x,player.y))
					)				
				{
					
					//Added the if you get too close thing
					//suspiciousEnough() || 
					if(distToPlayer<autoCatchDist)
					{
						lightFOV.setColor(detectedColor);
					
						expressionSprite.alpha = 0;		
						seesPlayer=true;		
						return FOUND_PLAYER;
					}
					
					
				}
				
				goalPoint = playerPoint;
				
				//TRY: Try removing the need for the player to be seeable if it's withinView and we're already seeking her
				if(withinView(new FlxPoint(player.x,player.y)) && !player.getHiding() 
				)//&& playerSeeable(currLevel))
				{	
				
					//moving it here
					var maxDist:Number = 90;
					
					if(distToPlayer<maxDist && distToPlayer>=minimumDist)
					{
						lightFOV.lerpBetween(suspiciousColor,detectedColor, (1-distToPlayer/(maxDist-minimumDist)));
					}
					else if(distToPlayer<minimumDist)
					{
						lightFOV.setColor(detectedColor);
					}
					else
					{
						lightFOV.setColor(suspiciousColor);
					}
					
					//Certainty improves with time
					if(certaintyTimer<certaintyTimerMax)
					{
						certaintyTimer+=FlxG.elapsed;
					}
					else
					{
						//If certainty is at maximum
						lightFOV.setColor(detectedColor);
						
						expressionSprite.alpha = 0;		
						seesPlayer=true;		
						return QUESTION_TIME;
					}
					
				
				
				
				
				
				
				
					goalPoint = new FlxPoint(playerPoint.x,playerPoint.y);
					if(player.x!=playerPoint.x || player.y!=playerPoint.y)
					{
						playerPoint = new FlxPoint(player.x,player.y);
					}
					giveUpTimer = giveUpTimerMax;
					
					if(!seesPlayer)
					{
						expressionSprite.loadGraphic(Assets.EXCLAMATION); 
						expressionSprite.alpha = 1;
						FlxG.play(sightedSound);
					}					
					seesPlayer=true;
					
					
					//Update Momentary Waypoints (Breadcrumbs back)
					if(prevFacing!=this.facing)
					{
						momentaryWaypoints.push(new FlxPoint(this.x,this.y));
						prevFacing = this.facing;
					}
					
				}
				else if(giveUpTimer<=0 )
				{
					if(seesPlayer)
					{
						FlxG.play(lostSound);
					}
					
					if(player.x!=playerPoint.x || player.y!=playerPoint.y)
					{
						playerPoint = new FlxPoint(player.x,player.y);
					}

					seesPlayer=false;
					expressionSprite.loadGraphic(Assets.QUESTION_MARK); 
					
					expressionSprite.alpha = 1;
					expressionTimer=expressionTimerMax;
					currentState=WAYPOINTING;
					resetLight();
					currMomentary = momentaryWaypoints.length-1;
					
					//figure out waypoint to go to
					
					if(waypoints.length==1)
					{
						//Only have one waypoint
					}
					else
					{
					
						var currDist:Number = Math.sqrt(Math.pow(waypoints[currWaypoint].x-this.x,2)
						+Math.pow(waypoints[currWaypoint].y-this.y,2));
						var j:int = 0;
						
						for(j=0; j<waypoints.length; j++)
						{
							if(j!=currWaypoint)
							{
								var dist:Number = Math.sqrt(Math.pow(waypoints[j].x-this.x,2)
								+Math.pow(waypoints[j].y-this.y,2));
								
								if(currDist>dist)
								{
									currWaypoint = j;
								}
								
							}
						
						}
					}
					
				}
				else
				{
					var currentTime:Date = new Date();
					
					if((currentTime.milliseconds/16)%2==0)
					{
					
						if(playerPntDiff==null)
						{
							playerPntDiff = new FlxPoint(0,0);
						}
						
						var magnitude:Number = manhattanDistance(new FlxPoint(player.x,player.y),
						new FlxPoint(this.x,this.y));
						
						//Wanders aboot
						playerPntDiff.x=  Math.random()*64-32;
						playerPntDiff.y=  Math.random()*64-32;
				
						
						goalPoint.x=playerPoint.x+playerPntDiff.x;
						goalPoint.y=playerPoint.y+playerPntDiff.y;
						
					}
					
					if(seesPlayer)
					{
						FlxG.play(lostSound);
					}
				
				
					seesPlayer=false;
					expressionSprite.loadGraphic(Assets.QUESTION_MARK);
					
					expressionSprite.alpha = 1;
					expressionTimer=expressionTimerMax;
				}
				
				
				
				if(giveUpTimer>0)
				{
					giveUpTimer-=FlxG.elapsed;
				}
				
				
				
			}
			
			
			var distanceToGoal: Number = manhattanDistance(goalPoint,new FlxPoint(this.x,this.y));
		
			speedModifier=1;
	
			if(currentState==WAYPOINTING)
			{
			
				var origDist: Number = manhattanDistance(originalPosition,new FlxPoint(this.x,this.y));
				if(distanceToGoal<minimumDist*2)
				{
					//hardStop();
					speedModifier = 0.2;//(minimumDist*2-distanceToGoal)/(minimumDist*2);//0.03;
				
					var div:Number = 1.1;
					if(momentaryWaypoints!=null)
					{
						//velocity.x/=div;
						//velocity.y/=div;
						//acceleration.x/=div+0.1;
						//acceleration.y/=div+0.1;
					}
				
					//speedModifier*=0.3;
					
					if(speedModifier<0.05)
					{
						speedModifier = 0.05;
					}
					
				}
				
				
				if(distanceToGoal<1.2)
				{
					this.x=goalPoint.x;
					this.y=goalPoint.y;
				}
			}
			else if(currentState==SEEKINGPLAYER)
			{
				
				if(giveUpTimer<giveUpTimerMax/2)
				{
					speedModifier = (giveUpTimerMax/2-giveUpTimer)/(giveUpTimerMax/2)+0.05;
				}
				
				
				
				
			}
			
			
			
			if(distanceToGoal<3)
			{
				this.x = goalPoint.x;
				this.y = goalPoint.y;
			}
	
	
			
	
	
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
			
			return 0;
		}
		
		//CALLED FROM ENEMYCONTROLLER, MAKES ALL THE THINGS HAPPEN
		public function command(currLevel: TopDownLevel, commandMessage: int=0):int 
		{
			if(commandMessage==NOT_ANY)
			{
			
				if(pausedPosition.x!=0)
				{
					pausedPosition = new FlxPoint(0,0);
				}	
				
				if(enemyType==NORMAL_BEHAVIOR)
				{		
					return regularGameplay(currLevel);
				}
				else if(enemyType==TURNING)
				{
					return regularGameplayTurning(currLevel);
				}
			}		
			else if(commandMessage==PAUSE)
			{
				if(pausedPosition.x==0)
				{
					pausedPosition = new FlxPoint(x,y);
				}
				
				//Try adding this to see what happens
				moveLightSource();
			
				super.hardStop();
				super.setPaused(true);
				
			}
			else if(commandMessage==CHECK_COSTUME)
			{
				checkPlayerOutfit();
			}
					
			return 0;
		
		}
		
		private function regularGameplayTurning(currLevel: TopDownLevel):int
		{
			//MOVE THE LIGHT SOURCE
			moveLightSource();
			
			//Move to above player
			expressionSprite.x = mySprite.x+mySprite.width/2-expressionSprite.width/2;
			expressionSprite.y = this.y-this.height*4-expressionSprite.height;
				
				
			
			//Handle the expressionSprite; 
			if(expressionTimer>0)
			{
				expressionTimer-=FlxG.elapsed; 

				if(expressionTimer<=0)
				{
					//expressionSprite.makeGraphic(4, 8, 0xFFFF0000);
					expressionSprite.alpha = 0;
				}
			}
			
		
			goalPoint= new FlxPoint(this.x,this.y);
			var minimumDist:Number = 15;
			if(currentState==WAYPOINTING)
			{	
				//Reset light used to go here
					
				
				//MOVING THE ENEMY
				if(momentaryWaypoints!=null)
				{
					if(manhattanDistance(momentaryWaypoints[currMomentary],new FlxPoint(this.x,this.y))<minimumDist)
					{
						if(currMomentary>1)
						{
							//hardStop();
						}
					
						if(currMomentary>0)
						{
							currMomentary--;
							goalPoint = momentaryWaypoints[currMomentary];
						}
						else
						{
							momentaryWaypoints=null;	
						}
			
					}
					goalPoint = momentaryWaypoints[currMomentary];
				}
				else
				{
					if(waypoints[currWaypoint].y<turningTime)
					{
					
					
						if(currWaypoint<waypoints.length-1)
						{
							currWaypoint++;
						}
						else
						{
							currWaypoint=0;
						}
						turningTime=0;
						
						
						
						facing = uint(waypoints[currWaypoint].x);
						//mySprite.facing = uint(waypoints[currWaypoint].x);
					}
					else
					{
						turningTime+=(FlxG.elapsed*(0.5+(FlxG.random()*0.6)));
					}
					
					//TopDownLevel.printText2.text = "sprite: "+facing;
						
					
					goalPoint = new FlxPoint(this.x,this.y);
				}
		
				//Check how to transfer into seeking player state
				if(withinView(new FlxPoint(player.x,player.y)) && !player.getHiding() && cantFindPlayerTimer<=0)
				{
					
					if(playerSeeable(currLevel))
					{
						expressionSprite.loadGraphic(Assets.EXCLAMATION); 
						expressionSprite.alpha = 1;
						expressionTimer=expressionTimerMax;
						currentState=SEEKINGPLAYER;
						FlxG.play(sightedSound);
						momentaryWaypoints = new Vector.<FlxPoint>();
					
						giveUpTimer = giveUpTimerMax;
						playerPoint = new FlxPoint(player.x,player.y);
					
						seesPlayer=true;
						
						//Change: Saw player set light to yellow
						lightFOV.setColor(suspiciousColor);
					}
				}
				
				if(cantFindPlayerTimer>0)
				{
				
					if(cantFindPlayerTimer>cantFindPlayerTimerMax/2)
					{
						lightFOV.setColor(cantFindPlayerColor);
					}
					else
					{
						lightFOV.lerpBetween(cantFindPlayerColor,undetectedColor,(1-(cantFindPlayerTimerMax/2-cantFindPlayerTimer)/(cantFindPlayerTimerMax/2)));
					}
					
					cantFindPlayerTimer-=FlxG.elapsed;
					
					if(cantFindPlayerTimer<=0)
					{
						resetLight();
					}
					
				}
				
				
				
		
			}
			else if(currentState==SEEKINGPLAYER)
			{
				var distToPlayer:Number = manhattanDistance(new FlxPoint(player.x,player.y), new FlxPoint(this.x,this.y));
					
				//TRY: Try removing the need for the player to be seeable if it's withinView and we're already seeking her
				if(withinView(new FlxPoint(player.x,player.y)) && !player.getHiding() 
					&& closeEnoughToPlayer(new FlxPoint(player.x,player.y))
					)				
				{
					
					//Added the if you get too close thing
					//suspiciousEnough() || 
					if(distToPlayer<minimumDist)
					{
						lightFOV.setColor(detectedColor);
					
						expressionSprite.alpha = 0;		
						seesPlayer=true;		
						return FOUND_PLAYER;
					}
					
					
				}
				
				goalPoint = playerPoint;
				
				//TRY: Try removing the need for the player to be seeable if it's withinView and we're already seeking her
				if(withinView(new FlxPoint(player.x,player.y)) && !player.getHiding() 
				)//&& playerSeeable(currLevel))
				{	
				
					//moving it here
					var maxDist:Number = 90;
					
					if(distToPlayer<maxDist && distToPlayer>=minimumDist)
					{
						lightFOV.lerpBetween(suspiciousColor,detectedColor, (1-distToPlayer/(maxDist-minimumDist)));
					}
					else if(distToPlayer<minimumDist)
					{
						lightFOV.setColor(detectedColor);
					}
					else
					{
						lightFOV.setColor(suspiciousColor);
					}
					
					//Certainty improves with time
					if(certaintyTimer<certaintyTimerMax)
					{
						certaintyTimer+=FlxG.elapsed;
					}
					else
					{
						//If certainty is at maximum
						lightFOV.setColor(detectedColor);
						
						expressionSprite.alpha = 0;		
						seesPlayer=true;		
						return QUESTION_TIME;
					}
					
				
				
				
				
				
				
				
					goalPoint = new FlxPoint(playerPoint.x,playerPoint.y);
					if(player.x!=playerPoint.x || player.y!=playerPoint.y)
					{
						playerPoint = new FlxPoint(player.x,player.y);
					}
					giveUpTimer = giveUpTimerMax;
					
					if(!seesPlayer)
					{
						expressionSprite.loadGraphic(Assets.EXCLAMATION); 
						expressionSprite.alpha = 1;
						FlxG.play(sightedSound);
					}					
					seesPlayer=true;
					
					
					//Update Momentary Waypoints (Breadcrumbs back)
					if(prevFacing!=this.facing)
					{
						momentaryWaypoints.push(new FlxPoint(this.x,this.y));
						prevFacing = this.facing;
					}
					
				}
				else if(giveUpTimer<=0 )
				{
					if(seesPlayer)
					{
						FlxG.play(lostSound);
					}
					
					if(player.x!=playerPoint.x || player.y!=playerPoint.y)
					{
						playerPoint = new FlxPoint(player.x,player.y);
					}

					seesPlayer=false;
					expressionSprite.loadGraphic(Assets.QUESTION_MARK); 
					
					expressionSprite.alpha = 1;
					expressionTimer=expressionTimerMax;
					currentState=WAYPOINTING;
					resetLight();
					currMomentary = momentaryWaypoints.length-1;
					
					//figure out waypoint to go to
					
					if(waypoints.length==1)
					{
						//Only have one waypoint
					}
					else
					{
					
						var currDist:Number = Math.sqrt(Math.pow(waypoints[currWaypoint].x-this.x,2)
						+Math.pow(waypoints[currWaypoint].y-this.y,2));
						var j:int = 0;
						
						for(j=0; j<waypoints.length; j++)
						{
							if(j!=currWaypoint)
							{
								var dist:Number = Math.sqrt(Math.pow(waypoints[j].x-this.x,2)
								+Math.pow(waypoints[j].y-this.y,2));
								
								if(currDist>dist)
								{
									currWaypoint = j;
								}
								
							}
						
						}
					}
					
				}
				else
				{
					var currentTime:Date = new Date();
					
					if((currentTime.milliseconds/16)%2==0)
					{
					
						if(playerPntDiff==null)
						{
							playerPntDiff = new FlxPoint(0,0);
						}
						
						var magnitude:Number = manhattanDistance(new FlxPoint(player.x,player.y),
						new FlxPoint(this.x,this.y));
						
						//Wanders aboot
						playerPntDiff.x=  Math.random()*64-32;
						playerPntDiff.y=  Math.random()*64-32;
				
						
						goalPoint.x=playerPoint.x+playerPntDiff.x;
						goalPoint.y=playerPoint.y+playerPntDiff.y;
						
					}
					
					if(seesPlayer)
					{
						FlxG.play(lostSound);
					}
				
				
					seesPlayer=false;
					expressionSprite.loadGraphic(Assets.QUESTION_MARK);
					
					expressionSprite.alpha = 1;
					expressionTimer=expressionTimerMax;
				}
				
				
				
				if(giveUpTimer>0)
				{
					giveUpTimer-=FlxG.elapsed;
				}
				
				
				
			}
			
			
			var distanceToGoal: Number = manhattanDistance(goalPoint,new FlxPoint(this.x,this.y));
		
			speedModifier=1;
	
			if(currentState==WAYPOINTING)
			{
			
				var origDist: Number = manhattanDistance(originalPosition,new FlxPoint(this.x,this.y));
				if(distanceToGoal<minimumDist*2)
				{
					//hardStop();
					speedModifier = 0.2;//(minimumDist*2-distanceToGoal)/(minimumDist*2);//0.03;
				
					var div:Number = 1.1;
					if(momentaryWaypoints!=null)
					{
						//velocity.x/=div;
						//velocity.y/=div;
						//acceleration.x/=div+0.1;
						//acceleration.y/=div+0.1;
					}
				
					//speedModifier*=0.3;
					
					if(speedModifier<0.05)
					{
						speedModifier = 0.05;
					}
					
				}
				
				
				if(distanceToGoal<1.2)
				{
					this.x=goalPoint.x;
					this.y=goalPoint.y;
				}
			}
			else if(currentState==SEEKINGPLAYER)
			{
				
				if(giveUpTimer<giveUpTimerMax/2)
				{
					speedModifier = (giveUpTimerMax/2-giveUpTimer)/(giveUpTimerMax/2)+0.05;
				}
				
				
				
				
			}
			
			
			
			if(distanceToGoal<3)
			{
				this.x = goalPoint.x;
				this.y = goalPoint.y;
			}
	
	
			
	
	
			movement = new FlxPoint();
	
			var bufferZone: int = 16;	
			
			
			
			
			/**
			if(magni<32)
			{
				speedModifier = 0.1;
			}
			
			
			if(this.x<goalPoint.x-bufferZone)
			{
				//Move right
				moveRight(speedModifier*difference.x*difference.x);
				
			}
			if(this.x>goalPoint.x+bufferZone)
			{
				//On left
				moveLeft(speedModifier*difference.x*difference.x);
			}
	
			if(this.y<goalPoint.y-bufferZone)
			{
				//Move down
				moveDown(speedModifier*difference.y*difference.y);
				
			}
			if(this.y>goalPoint.y+bufferZone)
			{
				//Move up
				movement.y -= 1;
				moveUp(speedModifier*difference.y*difference.y);
			}
			
			
			if(difference.x<1)
			{
				acceleration.x =0;
				velocity.x = 0;
			}
			if(difference.y<1)
			{
				acceleration.y =0;
				velocity.y = 0;
			}
			*/
			
			
			return 0;
		}
		
		protected function closeEnoughToPlayer(pnt: FlxPoint): Boolean
		{
			return (manhattanDistance(new FlxPoint(this.x,this.y), pnt)<16);
			
		}
		
		
		
		//THIS TECHNICALLY MOVES THE ENEMY, BUT ONLY CAUSE OF STUFF FROM COMMAND
		override protected function updateControls():void {
			super.updateControls();
			
			if(goalPoint!=null)
			{
				var difference:FlxPoint = new FlxPoint(goalPoint.x-this.x, goalPoint.y-this.y);
				var magni:Number = Math.sqrt(difference.x*difference.x+difference.y*difference.y);
			
				difference.x/= magni;
				difference.y/=magni;
			
			
				//this.x+=difference.x;
				//this.y+=difference.y;
				
				var bufferZone: int = 5;
				//TRY PUTTING THIS HERE
				if(this.x<goalPoint.x-bufferZone)
				{
					//Move right
					moveRight(speedModifier);
				
				}
				if(this.x>goalPoint.x+bufferZone)
				{
					//On left
					moveLeft(speedModifier);
				}
	
				if(this.y<goalPoint.y-bufferZone)
				{
					//Move down
					moveDown(speedModifier);
				
				}
				if(this.y>goalPoint.y+bufferZone)
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
			
			suspicious = numCorrect;
			
			if(numCorrect==3)
			{
				allMatchFOV();
			}
			else if(numCorrect==2)
			{
				twoMatchFOV()
			}
			else if(numCorrect==1)
			{
				oneMatchFOV();
			}
			else
			{
				noMatchFOV();
			}
			
			
		}
		
		//To be overriden for how other lightFOV's shrink
		protected function allMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.35,0.35);
		}
		
		protected function noMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.6,0.6);
		}
		
		protected function oneMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.55,0.55);
		}
		
		protected function twoMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.45,0.45);
		}
		
		
		/**
		 *Simple manhattan distance (public so we can use it later)
		 */
		protected function manhattanDistance(firstPoint: FlxPoint, secondPoint: FlxPoint): Number
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
		
		
		//Returns the next spot this enemy should go to (PATHING)
		public function getNextPnt(currLevel: TopDownLevel, pnt: FlxPoint): FlxPoint
		{
			var leftVec:FlxPoint = new FlxPoint(-1,0);
			var upVec:FlxPoint = new FlxPoint(0,1);
			var rightVec:FlxPoint = new FlxPoint(1,0);
			var downVec: FlxPoint = new FlxPoint(0,-1);
			var vectors:Array = [leftVec, upVec, rightVec, downVec];
					
			var diffVec: FlxPoint = new FlxPoint(pnt.x-this.x,pnt.y-this.y);
			
			
			var mag: Number =  Math.sqrt(diffVec.x*diffVec.x+diffVec.y*diffVec.y);
			
			diffVec.x/=mag;
			diffVec.y/=mag;
			
			var locToCheck:FlxPoint = new FlxPoint(0,0);
			var scalar: Number = 8.0;
			locToCheck.x=this.x +diffVec.x*scalar;
			locToCheck.y=this.y+diffVec.y*scalar;
			
			if(currLevel.canHavePlayerAt(locToCheck.x,locToCheck.y))
			{
				return locToCheck;
			}
			else
			{
				var distances: Array = new Array(4);
				var doesItWork: Array = new Array(4);
				
				var i: int = 0;
				var currLoc : FlxPoint = new FlxPoint();
				for(i=0; i<4; i++)
				{
					currLoc.x = this.x+vectors[i].x;
					currLoc.y = this.y+vectors[i].y;
					
					if(currLevel.canHavePlayerAt(currLoc.x,currLoc.y))
					{
						doesItWork[i] = true;
						var diff: FlxPoint = new FlxPoint(0,0);
						diff.x = pnt.x-currLoc.x;
						diff.y = pnt.y-currLoc.y;
						distances[i] = Math.sqrt(diff.x*diff.x+diff.y*diff.y);
					}
					else
					{
						doesItWork[i]=false;
					}					
					
				}
				
				
				//Find minimum of the ones that worked
				var minIndex: int = -1;
				var currDist:Number = -1;
				for(i =0; i<4; i++)
				{
					if(doesItWork[i])
					{
						if(distances[i]<currDist || currDist==-1)
						{
							minIndex = i;
							currDist = distances[i];
						}
					}
				}
				
				if(minIndex!=-1)
				{
					return new FlxPoint(this.x+vectors[i],this.y+vectors[i]);
				}
				else
				{
					return pnt;
				}
				
			}
			
		}
		
		//Returns true if the enemy can see the player through not a wall, false otherwise
		protected function playerSeeable(currLevel: TopDownLevel): Boolean
		{
			
			var diff: FlxPoint = new FlxPoint(player.x+2-this.x,(player.y)-(this.y-2));
			
			var magnitude: Number = Math.sqrt(diff.x*diff.x+diff.y*diff.y);
			
			
			
			if(magnitude<20)
			{
				return true;
			}
			else
			{
				var magOfDiff:Number = 4.0;
				var numPntsToCheck :int = magnitude/magOfDiff;
				//numPntsToCheck*=2;
				//TopDownLevel.printText2.text ="My Pos: "+this.x+", "+this.y+"     Diff: "+diff.x+", "+diff.y+"    NumPnts: "+numPntsToCheck;
			
				var stillViewable: Boolean = true;
				
				var ind : int = 2;
				
				diff.x/=magnitude;
				diff.y/=magnitude;
				
				while(stillViewable && 	ind<numPntsToCheck-1)
				{
					var currPnt:FlxPoint = new FlxPoint(0,0);
					
					currPnt.x = this.x+ind*magOfDiff*diff.x;
					//Seems to work!
					currPnt.y = (this.y-2) +(ind*magOfDiff*diff.y);
					
					stillViewable = currLevel.canSeePlayerThrough(int(currPnt.x),int(currPnt.y));
					ind++;		
					
					
					//TopDownLevel.printText2.text += "     Ind: "+ind+" of "+(numPntsToCheck-1)+": "+currPnt.x+", "+currPnt.y;
					
				}	
				
				
				return stillViewable;
			
			}
		}
		
		override public function updateAnimations():void {
			super.updateAnimations();
			
			mySprite.x = x;
			mySprite.y = y-(18-height);
		}
		
		protected function checkIfIn(node: EnemyNode, visitedList: Vector.<EnemyNode>): Boolean
		{
			var i:int = 0;
			
			if(node==null || visitedList==null || visitedList.length==0)
			{
				return false;			
			}
			else
			{
				for(i=0; i<visitedList.length; i++)
				{
					//
				
					if(visitedList[i]!=null && visitedList[i].nodeEquals(node.getX(),node.getY())
					&& 
					(visitedList[i].getParent()!=null && node.getParent()!=null
					&& visitedList[i].getParent().nodeEquals(node.getParent().getX(),node.getParent().getY()))
					||
					(visitedList[i].getParent()==null && node.getParent()==null)
					
					)
					{
					
					
						//FIX THIS
						return true;
					}
				}
				return false;
			}
			
			
		}
		
		protected function toNodeSpace(num:Number):Number
		{
			//For tileSize 8
			return (( (num/16)*16+8 ));
		}
		
	
	}//End of class
	
}//End of package declaration