package 
{
	import org.flixel.*;
	
	public class ItemDialogNode extends DialogNode{
		protected var itemToReturn:InventoryItem;
		protected var takesItem: InventoryItem;
		
		public function ItemDialogNode(_nextNode:DialogNode, _faceToDisplay:uint, _displayText:String,_itemToReturn:InventoryItem,
		_takesItem:InventoryItem=null,
		 _pausesGame:Boolean=false, 
		_alternateNode:DialogNode=null)
		{
			super(_nextNode,_faceToDisplay, _displayText,_pausesGame,_alternateNode);
			takesItem=_takesItem;
			itemToReturn = _itemToReturn;
		}
		
		//Called before moving to this node
		override public function canTransfer(inventory:Inventory):Boolean
		{
			if(inventory.getInventoryItem()==takesItem)
			{
				inventory.retrieveInventoryItem();
			}
			
			
			
			return true;
		}
		
		
		override public function handleDialogEnd(inventory:Inventory, player:Player):void
		{
			//Gives item to character
			if(inventory.setInventoryItem(itemToReturn))
			{
				//if we managed to give it, can play is false, otherwise it's not
				canPlay=false;
				
			}
					
		}
		
	}
}