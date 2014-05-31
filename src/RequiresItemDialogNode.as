package 
{
	import org.flixel.*;
	
	public class RequiresItemDialogNode extends DialogNode{
		protected var itemRequired: String;
		
		public function RequiresItemDialogNode(_nextNode:DialogNode, _faceToDisplay:uint, _displayText:String,_itemRequired:String, _soundToPlay:Class=null)
		{
			super(_nextNode,_faceToDisplay, _displayText);
			itemRequired=_itemRequired;
			soundToPlay=_soundToPlay;
		}
		
		//Called before moving to this node
		override public function canTransfer(inventory:Inventory):Boolean
		{
			return inventory.getItemName()==itemRequired;
		}
	
		
	}
}