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
		private var testHead: uint, testBody: uint, testLegs: uint;
		
		//All outfits
		private var allOutfits: Vector.<PlayerOutfit>;
		
		
		public function OutfitHandler(_currLegsOutfit:PlayerOutfit, _currBodyOutfit:PlayerOutfit, _currHeadOutfit:PlayerOutfit)
		{
			allOutfits = new Vector.<PlayerOutfit>();
			
			testHead = _currHeadOutfit.getOutfitType();
			testBody = _currBodyOutfit.getOutfitType();
			testLegs = _currLegsOutfit.getOutfitType();
			
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
		
		//GET What set they belong to
		public function getCurrLegsOutfitSet():uint
		{
			return allOutfits[currLegsOutfit].getOutfitSet();
		}	
		
		public function getCurrBodyOutfitSet():uint
		{
			return allOutfits[currBodyOutfit].getOutfitSet();
		}
		
		public function getCurrHeadOutfitSet():uint
		{
			return allOutfits[currHeadOutfit].getOutfitSet();
		}
		
		
		
		//Get all the outfits, for use in displaying them, for when we have that menu
		public function getAllOutfits(): Vector.<PlayerOutfit>
		{
			return allOutfits;
		}
		
		//Setters
		public function setCurrLegsOutfit(currLeg: PlayerOutfit):void
		{
			testLegs = currLeg.getOutfitType();
			currLegsOutfit = allOutfits.push(currLeg)-1;
		}
		
		public function setCurrBodyOutfit(currBody: PlayerOutfit):void
		{
			testBody = currBody.getOutfitType();
			currBodyOutfit = allOutfits.push(currBody)-1;
		}
		
		public function setCurrHeadOutfit(currHead: PlayerOutfit):void
		{
			testHead = currHead.getOutfitType();
			currHeadOutfit = allOutfits.push(currHead)-1;
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