package 
{
	import org.flixel.*;

	public class CelesteEnemy extends Enemy
	{
		
		private var shrunkenLight:Boolean;
		private var fpsToUse:int = 12;
	
		public function CelesteEnemy(_waypoints:Vector.<FlxPoint>, player: Player, _lightFOV1: Light,  X:Number=100, Y:Number=140, _dialogNode:DialogNode=null):void {
			super(Assets.DAME_SPRITE, _waypoints, player,_lightFOV1, X, Y,_dialogNode, 60,15,18);
			
			
			if(_dialogNode!=null)
			{
				enemyQuestion = _dialogNode;
			}
			else
			{
				enemyQuestion = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "Oh hey! Isn't the Walrus King great?", Assets.CELESTE_PLEASED_SAD);
			}
			
			
			
			//This one is the chef outfit
			outfitToUse=OutfitHandler.PRINCESS_OUTFIT;
			
			
			//Shark Sounds
			sightedSound= Assets.CELESTE_TOUGH;
		  	lostSound= Assets.CELESTE_HUH;
		
			minimumDist = 24;
			
		}
		
		
		
		
		override protected function allMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.4,0.4);
		}
		
		override protected function noMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.7,0.7);
		}
		
		override protected function oneMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.65,0.65);
		}
		
		override protected function twoMatchFOV():void
		{
			lightFOV.scale= new FlxPoint(0.55,0.55);
		}
		
		
		
		
		
		override public function createAnimations():void {
			
			
			mySprite.addAnimation("idle_up", [4]);
			
			mySprite.addAnimation("idle_right", [0,0,0,0,0,0,0,0,0,0,0,1], 10, true);
			mySprite.addAnimation("idle_down", [2,2,2,2,2,2,2,2,2,2,2,3], 10, true);
			mySprite.addAnimation("idle_left", [0,0,0,0,0,0,0,0,0,0,0,1], 10, true);
			mySprite.addAnimation("walk_up", [13, 14, 15, 16], fpsToUse); // 12 = frames per second for this animation
			//bodySprite.addAnimation("walk_right", [5, 6, 7,8], 12);
			mySprite.addAnimation("walk_down", [9, 10, 11, 12], fpsToUse);
			mySprite.addAnimation("walk_horz", [5, 6, 7,8], fpsToUse);
			
			mySprite.facing=LEFT;
		}


		override public function getCaughtPlayerStatement(): DialogNode
		{
			return new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "DO YOU NOT LIKE THE WALRUS KING?! HE'S A GREAT GUY!!1", Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
		}
		
		//Get Positive Response
		override protected function getPositiveResponse(): DialogNode
		{
		
			var node1: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "Haha! I know! I hope he doesn't give up just because I'm playing hard to get!", Assets.CELESTE_PLEASED_SAD, DialogNode.RESET_ENEMIES)
		
			return new DialogNode(node1, DialogHandler.PLAYER_HEAD,  "Oh yeah, he's great!",Assets.CELESTE_DETERMINED );
		}
		
		//To be overriden by later enemies
		override protected function setUpQuestion():void
		{	
			var enemyAnswer1: String = "Nope.";
			var enemyAnswer2: String =  "Oh yeah, he's great!";
			var enemyAnswer3: String =  "On a scale from 1 to 10? No.";
			var enemyAnswer4: String = "Not really a fan.";
			var enemyAnswer5: String = "I disagree.";
			var enemyAnswer6: String = "Oh god, a clone.";
			var enemyAnswer7: String = "Have you met him?";
			var enemyAnswer8: String = "What even are you?";
			var enemyAnswer9: String = "I'm trying to fix him.";
			var enemyAnswer10: String = "Meow";
			
			
			enemyAnswers = 	new Vector.<EnemyAnswer>();
			
			
			
			
			//THE CORRECT ANSWER NEEDS TO BE THE FIRST ONE
			enemyAnswers.push(new EnemyAnswer(enemyAnswer2,getRandomKeyboardKey(),true));
			var response2: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "HOW DARE YOU?! VACATE THIS MIND.", Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer1, getRandomKeyboardKey(), false,  new DialogNode(response2, DialogHandler.PLAYER_HEAD, enemyAnswer1)));
			
			var response3: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "HE WOULD BE A PERFECT TEN, HARLOT.",Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer3,getRandomKeyboardKey(), false,  new DialogNode(response3, DialogHandler.PLAYER_HEAD, enemyAnswer3)));
			
			var response4: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "WE WILL SHOW YOU THE ERROR OF YOUR WAYS.",Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer4,getRandomKeyboardKey(), false,  new DialogNode(response4, DialogHandler.PLAYER_HEAD, enemyAnswer4)));
			
			var response5: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "AND FOR THAT- DEATH THREATS.",Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer5,getRandomKeyboardKey(), false,  new DialogNode(response5, DialogHandler.PLAYER_HEAD, enemyAnswer5)));
			
			var response6: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "I'm not a clone! Wait, you're Dame Celeste! Get out of here!",Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer6,getRandomKeyboardKey(), false,  new DialogNode(response6, DialogHandler.PLAYER_HEAD, enemyAnswer6)));
			
			var response7: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "I HOPE TO SOMEDAY. NOW LEAVE.",Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer7,getRandomKeyboardKey(), false,  new DialogNode(response7, DialogHandler.PLAYER_HEAD, enemyAnswer7)));
			
			var response8: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "I'M WHAT HE WANTS, NOT YOU. LEAVE.",Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer8,getRandomKeyboardKey(), false,  new DialogNode(response8, DialogHandler.PLAYER_HEAD, enemyAnswer8)));
			
			var response9: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "HE'S PERFECT! BEGONE!",Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer9,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer9)));
			
			var response10: DialogNode = new DialogNode(null, DialogHandler.EVIL_CELESTE_HEAD, "AHHH! A Cat! Wait, I'm an ideal! GET OUT OF HERE.",Assets.CELESTE_TOUGH_UPSET2, DialogNode.RESET_GAME);
			enemyAnswers.push(new EnemyAnswer(enemyAnswer10,getRandomKeyboardKey(), false,  new DialogNode(response9, DialogHandler.PLAYER_HEAD, enemyAnswer10)));
			
			
		}
		
		
	
	}//End of class
	
}//End of package declaration