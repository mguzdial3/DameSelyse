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
		
		public var QUESTION_TIME:int = 1;
		private var PAUSED: int=2;
		private var player:TopDownEntity;
		
		//Used to tell the enemy direction to move next
		private var movement: FlxPoint;
		
		//Used to tell the enemy at what speed to move
		private var speedModifier: Number=1;
		
		//The light of this enemy (has to be added in EnemyController)
		protected var lightFOV: Light;
		
		
		protected var undetectedColor: uint = 0xFFFFFFFF;
		protected var detectedColor: uint =  0xFFFF2222;
		
		//Question asking stuff
		protected var enemyQuestion: String;
		protected var enemyAnswers: Vector.<String>;
		
		public function Enemy(_waypoints:Vector.<FlxPoint>, player: TopDownEntity, _lightFOV: Light, X:Number=100, Y:Number=140 ):void {
			super(Assets.RANGER_SPRITE, new FlxPoint(10,4), new FlxPoint(16,18), X, Y,30);
			
			
			waypoints = _waypoints;
			
			this.player = player;
			
			lightFOV = _lightFOV;
			
			//Question set up
			setUpQuestion();	
			
					
						
						
			//Set up movement FlxPoint (Used as a vector)
			movement = new FlxPoint();
			currWaypoint = 0;
		}
		
		//To be overriden by later enemies
		protected function setUpQuestion():void
		{
			enemyQuestion = "What do you desire?";
			
			var enemyAnswer1: String = "A.)Failure";
			var enemyAnswer2: String = "B.) Success";	
			
			enemyAnswers = 	new Vector.<String>();
			
			enemyAnswers.push(enemyAnswer1);
			enemyAnswers.push(enemyAnswer2);
			
			
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
			
			var radiusOfLight: Number = lightFOV.width/4;
			
			if(distanceFromCenter<radiusOfLight)
			{
				within=true;
			}
			
			return within;
		
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
		
					//this.x += 0.5*(goalPoint.x-this.x)/Math.abs((goalPoint.x-this.x));
					//this.y += 0.5*(goalPoint.y-this.y)/Math.abs((goalPoint.y-this.y));
		
		
				//Check how to transfer into seeking player state
				if(withinView(new FlxPoint(player.x,player.y)))
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
		
		
		public function command(commandMessage: int=0):int {
		
		
			if(commandMessage==0)
			{
				return regularGameplay();
			}		
			else if(commandMessage==1)
			{
				super.hardStop();
			}
					
			return 0;
		
		}
		
		
		
		
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
		
		
		
		/**
		 *Simple manhattan distance (public so we can use it later)
		 */
		private function manhattanDistance(firstPoint: FlxPoint, secondPoint: FlxPoint): Number
		{
			var distanceBetween: Number = Math.sqrt(Math.pow((secondPoint.x-firstPoint.x),2)
			+ Math.pow((secondPoint.y-firstPoint.y),2));
			
			return distanceBetween;
		}
		
	
	}//End of class
	
}//End of package declaration