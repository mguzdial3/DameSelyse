package 
{
	import org.flixel.*;
	
	//Handles the player's outfits
	public class OutfitHandler
	{
		public static const NORMAL_OUTFIT:uint=0;
		public static const PRINCESS_OUTFIT:uint =1;
		public static const GUARD_OUTFIT:uint=2;
		
		
		//The current outfit Positions in the Outfit Vector
		private var currLegsOutfit: int;
		private var currBodyOutfit: int;
		private var currHeadOutfit: int;
		
		//All outfits
		private var allOutfits: Vector.<PlayerOutfit>;
		
		
		public function OutfitHandler(_currLegsOutfit:PlayerOutfit, _currBodyOutfit:PlayerOutfit, _currHeadOutfit:PlayerOutfit)
		{
			allOutfits = new Vector.<PlayerOutfit>();
			
			
			currLegsOutfit = allOutfits.push(_currLegsOutfit);
			currBodyOutfit = allOutfits.push(_currBodyOutfit);
			currHeadOutfit = allOutfits.push(_currHeadOutfit);
		}
		
		//Getters
		public function getCurrLegsOutfit():PlayerOutfit
		{
			return allOutfits[currLegsOutfit];
		}	
		
		public function getCurrBodyOutfit():PlayerOutfit
		{
			return allOutfits[currBodyOutfit];
		}
		
		public function getCurrHeadOutfit():PlayerOutfit
		{
			return allOutfits[currHeadOutfit];
		}
		
		//GET TYPE
		public function getCurrLegsOutfitType():uint
		{
			return allOutfits[currLegsOutfit].getOutfitType();
		}	
		
		public function getCurrBodyOutfitType():uint
		{
			return allOutfits[currBodyOutfit].getOutfitType();
		}
		
		public function getCurrHeadOutfitType():uint
		{
			return allOutfits[currHeadOutfit].getOutfitType();
		}
		
		
		
		//Get all the outfits, for use in displaying them, for when we have that menu
		public function getAllOutfits(): Vector.<PlayerOutfit>
		{
			return allOutfits;
		}
		
		//Setters
		public function setCurrLegsOutfit(currLeg: PlayerOutfit):void
		{
			currLegsOutfit = allOutfits.push(currLeg);
		}
		
		public function setCurrBodyOutfit(currBody: PlayerOutfit):void
		{
			currBodyOutfit = allOutfits.push(currBody);
		}
		
		public function setCurrHeadOutfit(currHead: PlayerOutfit):void
		{
			currHeadOutfit = allOutfits.push(currHead);
		}
		
		//Swap two indexes
		public function swapIndexes(indexOne: int, indexTwo: int):void
		{
			var firstOne: PlayerOutfit = allOutfits[indexOne];
			
			allOutfits[indexOne] = allOutfits[indexTwo];
			
			allOutfits[indexTwo] = firstOne;
		}
		
	}
}