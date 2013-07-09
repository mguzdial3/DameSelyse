package 
{
	import org.flixel.*;
	
	//Info holder for player outfits (and has an image representation ITSELF)
	//Waits until it has been been grabbed to actually load the outfit
	public class PlayerOutfit extends FlxSprite
	{
		//This is the actual outfit in question and the info on how to load it should always be the same
		private var outfit: Class;
		
		//The set this outfit belongs to
		private var outfitSet:uint;
		
		//What type of Outfit is this outfit	
		private var outfitType:uint;//Legs, Body, or Head
		//CONSTANTS FOR DIFFERENT OUTFIT TYPES
		public static const LEGS_OUTFIT:uint=0;
		public static const BODY_OUTFIT:uint=1;
		public static const HEAD_OUTFIT:uint =2;
		
		//First there are the display options for this playerOutfit
		public function PlayerOutfit(X:Number, Y:Number, SimpleGraphic: Class, _outfitType:uint, OutfitGraphic: Class, _outfitSet:uint)
		{
			super(X,Y,SimpleGraphic);
			outfitType = _outfitType;
			outfit = OutfitGraphic;
			outfitSet=_outfitSet;
			
		}
		
		public function getOutfit(): Class
		{
			return outfit;
		}
		
		public function getOutfitType(): uint
		{
			return outfitType;
		}
		
	
	}
}