package 
{
	import org.flixel.*;

	//Extends FlxObject so we can call trigger on it
	public class DialogueTriggerZone extends FlxObject
	{
		//This version only has the one dialog it can call, 
		private var myDialogNode: DialogNode;
		
		private var repeatable:Boolean;
		private var pausesPlayer:Boolean;
		
		public var activated:Boolean;
		
		public function DialogueTriggerZone(_x:Number, _y:Number, _width:Number, _height:Number, _myDialogNode:DialogNode, _repeatable:Boolean=false, _pausesPlayer:Boolean=false, _activated:Boolean=false)
		{
			super(_x, _y, _width, _height);
			
			myDialogNode=_myDialogNode;
			
			repeatable=_repeatable;
			pausesPlayer= _pausesPlayer;
			
			activated = _activated;
		} 
		
		
		//Pass in player and Inventory for your descendants so you can check both for proper stuff
		public function triggerDialogueZone(player: Player=null, inventory:Inventory=null): DialogNode
		{
			if(myDialogNode.canTransfer(inventory))
			{
				activated = true;
				return myDialogNode;
			}
		
		
			return null;
		}
		
		public function getPausesPlayer(): Boolean
		{
			return pausesPlayer;
		}
		
		//To be overriden by the kids
		public function getRepeatable():Boolean
		{
			return repeatable;
		}
		
		
		
	
	}
}