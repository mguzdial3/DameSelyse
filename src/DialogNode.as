package 
{
	import org.flixel.*;
	
	public class DialogNode{
		//The next node (if null, then we're done)
		protected var nextNode: DialogNode;
		protected var alternateNode: DialogNode;
		
		//Whether or not this Node has questions and responses
		protected var hasQuestions: Boolean;
		
		//Face to display (References constant in Dialog Handler)
		protected var faceToDisplay: uint;
		
		//Text to display with this dialog
		protected var displayText:String;
		protected var canPlay:Boolean;
		
		
		//What to do if it does not have a next node
		private var afterEnd:uint;
		public static var BACK_TO_NORMAL:uint = 0;
		public static var RESET_GAME: uint = 1;
		public static var RESET_ENEMIES: uint = 2;
		
		//Responses and answers are if this node is a question, must be equal in size or everything goes to shit
		protected var responses: Vector.<DialogNode>;
		protected var answers: Vector.<EnemyAnswer>;
		
		protected var timeToAnswer: int = 10;
		
		public function DialogNode(_nextNode:DialogNode, _faceToDisplay:uint, _displayText:String, _afterEnd: uint= 0,
		_hasQuestions:Boolean=false, _responses: Vector.<DialogNode>=null, _answers: Vector.<EnemyAnswer>=null, _alternateNode:DialogNode=null)
		{
			nextNode=_nextNode;
			faceToDisplay=_faceToDisplay;
			displayText=_displayText;
			
			hasQuestions=_hasQuestions;
			responses= _responses
			answers = _answers;
			
			afterEnd = _afterEnd;
			alternateNode=_alternateNode;
			
			canPlay=true;
		}
		
		
		
		public function setTimeToAnswer(_timeToAnswer:int): void
		{
			timeToAnswer= _timeToAnswer;
		}
		
		public function getTimeToAnswer(): int
		{
			return timeToAnswer;
		}
		
		//Called before moving to this node
		public function canTransfer(inventory:Inventory):Boolean
		{
			return true;
		}
		
		public function handleDialogEnd(inventory:Inventory, player:Player):void
		{
			//Gives item to character, or takes item from character
		}
		
		public function getNextNode():DialogNode
		{
		
			if(nextNode!=null && nextNode.getCanPlay())
			{
				return nextNode;
			}
			else
			{
				return alternateNode;
			}
		}
		
		public function getAlternateNode():DialogNode
		{
			return alternateNode;
		}
		
		public function getAfterEnd(): uint
		{
			return afterEnd;
		}
		
		public function getFaceToDisplay():uint
		{
			return faceToDisplay;
		}	
		
		public function getCanPlay(): Boolean
		{
			return canPlay;
		}	
		
		public function getHasQuestions(): Boolean
		{
			return hasQuestions;
		}
		
		public function getAnswers(): Vector.<EnemyAnswer>
		{
			return answers;
		}
		
		public function getResponses(): Vector.<DialogNode>
		{
			return responses;
		}
		
		
		
		public function getTextToDisplay():String
		{
			return displayText;
		}
	}
}