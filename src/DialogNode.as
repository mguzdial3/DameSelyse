package 
{
	import org.flixel.*;
	
	public class DialogNode{
		//The next node (if null, then we're done)
		protected var nextNode: DialogNode;
		protected var alternateNode: DialogNode;
		
		//Whether or not this dialog pauses everybody
		protected var pausesGame: Boolean;
		
		//Face to display (References constant in Dialog Handler)
		protected var faceToDisplay: uint;
		
		//Text to display with this dialog
		protected var displayText:String;
		protected var canPlay:Boolean;
		
		public function DialogNode(_nextNode:DialogNode, _faceToDisplay:uint, _displayText:String, 
		_pausesGame:Boolean=false, _alternateNode:DialogNode=null)
		{
			nextNode=_nextNode;
			faceToDisplay=_faceToDisplay;
			displayText=_displayText;
			
			pausesGame=_pausesGame;
			
			alternateNode=_alternateNode;
			
			canPlay=true;
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
		
		public function getFaceToDisplay():uint
		{
			return faceToDisplay;
		}	
		
		public function getCanPlay(): Boolean
		{
			return canPlay;
		}	
		
		public function getPausesGame(): Boolean
		{
			return pausesGame;
		}
		
		public function getTextToDisplay():String
		{
			return displayText;
		}
	}
}