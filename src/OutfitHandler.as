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
			
			currLegsOutfit = allOutfits.push(_currLegsOutfit)-1;
			currBodyOutfit = allOutfits.push(_currBodyOutfit)-1;
			currHeadOutfit = allOutfits.push(_currHeadOutfit)-1;
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
		
		public function getIndexOf(outfit:PlayerOutfit):int
		{
			return allOutfits.indexOf(outfit);
		}
		
		
		//Get all the outfits, for use in displaying them, for when we have that menu
		public function getAllOutfits(): Vector.<PlayerOutfit>
		{
			return allOutfits;
		}
		
		//Setters
		public function setCurrOutfit(currOutfit: PlayerOutfit):void
		{
			if(currOutfit.getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
			{
				setCurrLegsOutfit(currOutfit);
			}
			else if(currOutfit.getOutfitType()==PlayerOutfit.BODY_OUTFIT)
			{
				setCurrBodyOutfit(currOutfit);
			}
			else if(currOutfit.getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
			{
				setCurrHeadOutfit(currOutfit);
			}
		}
		
		
		public function setCurrLegsOutfit(currLeg: PlayerOutfit):void
		{
		
			currLeg.velocity.x=0;
			currLeg.velocity.y=0;
			currLeg.acceleration.x=0;
			currLeg.acceleration.y=0;
		
			if(allOutfits.indexOf(currLeg)==-1)
			{
				testLegs = currLeg.getOutfitType();
				currLegsOutfit = allOutfits.push(currLeg)-1;
			}
			else
			{
				testLegs=currLeg.getOutfitType();
				currLegsOutfit = allOutfits.indexOf(currLeg);
			}
		}
		
		public function setCurrBodyOutfit(currBody: PlayerOutfit):void
		{
			currBody.velocity.x=0;
			currBody.velocity.y=0;
			currBody.acceleration.x=0;
			currBody.acceleration.y=0;
		
			if(allOutfits.indexOf(currBody)==-1)
			{
				testBody = currBody.getOutfitType();
				currBodyOutfit = allOutfits.push(currBody)-1;
			}
			else
			{
				testBody=currBody.getOutfitType();
				currBodyOutfit = allOutfits.indexOf(currBody);
			}
		}
		
		public function setCurrHeadOutfit(currHead: PlayerOutfit):void
		{
			
			currHead.velocity.x=0;
			currHead.velocity.y=0;
			currHead.acceleration.x=0;
			currHead.acceleration.y=0;
		
		
			if(allOutfits.indexOf(currHead)==-1)
			{
				testHead = currHead.getOutfitType();
				currHeadOutfit = allOutfits.push(currHead)-1;
			}
			else
			{
				testHead=currHead.getOutfitType();
				currHeadOutfit = allOutfits.indexOf(currHead);
			}
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