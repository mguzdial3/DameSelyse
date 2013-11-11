package 
{
	import org.flixel.*;
	
	public class OutfitDialogNode extends DialogNode{
		protected var playerOutfit:PlayerOutfit;
		
		public function OutfitDialogNode(_nextNode:DialogNode, _faceToDisplay:uint, _displayText:String,_playerOutfit:PlayerOutfit,
		 _sound: Class=null,
		 _pausesGame:Boolean=false, 
		_alternateNode:DialogNode=null)
		{
			super(_nextNode,_faceToDisplay, _displayText,_sound);
			playerOutfit = _playerOutfit;
		}
		
		
		override public function handleDialogEnd(inventory:Inventory, player:Player):void
		{
			//Give outfit to character
			player.setNewOutfit(playerOutfit.getOutfitType(),playerOutfit.getOutfit());
				
			player.setNewOutfitPiece(playerOutfit);
					
		}
		
	}
}