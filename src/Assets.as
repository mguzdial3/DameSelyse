package
{
	import flash.utils.ByteArray;
	
	
	public class Assets
	{
	
		//Main Menu
		[Embed(source = "/assets/DameCelesteMenuConcept.png")] public static var MAIN_MENU:Class;
	
		// sprites
		//[Embed(source = "/assets/sprites/ranger (opengameart - Antifarea - ccby30).png")] public static var RANGER_SPRITE:Class;
		[Embed(source = "/assets/sprites/catGuardSpritesheet.png")] public static var GUARD_SPRITE:Class;
		[Embed(source = "/assets/sprites/ratCookSpritesheet.png")] public static var COOK_SPRITE:Class;
		[Embed(source = "/assets/sprites/prisonerSpritesheet.png")] public static var PRISONER_SPRITE:Class;
		[Embed(source = "/assets/sprites/hammerheadSpritesheet.png")] public static var SHARK_SPRITE:Class;
		//Split up player sprite
		[Embed(source = "/assets/sprites/princessHeadSpritesheet.png")] public static var RANGERHEAD_SPRITE:Class;
		[Embed(source = "/assets/sprites/princessBodySpritesheet.png")] public static var RANGERBODY_SPRITE:Class;
		[Embed(source = "/assets/sprites/princessLegsSpritesheet.png")] public static var RANGERLEGS_SPRITE:Class;
		
		//Outfit
		[Embed(source = "/assets/sprites/princessHat.png")] public static var RANGER_HAT:Class;
		[Embed(source = "/assets/sprites/princessPants.png")] public static var RANGER_PANTS:Class;
		[Embed(source = "/assets/sprites/princessShirt.png")] public static var RANGER_SHIRT:Class;
		
		//Guard sprites (names are leftovers)
		[Embed(source = "/assets/sprites/guardHat.png")] public static var RANGER2_HAT:Class;
		[Embed(source = "/assets/sprites/guardHeadSpritesheet.png")] public static var RANGER2HEAD_SPRITE:Class;
		
		[Embed(source = "/assets/sprites/guardShirt.png")] public static var RANGER2_SHIRT:Class;
		[Embed(source = "/assets/sprites/guardBodySpritesheet.png")] public static var RANGER2BODY_SPRITE:Class;
		
		[Embed(source = "/assets/sprites/guardPants.png")] public static var RANGER2_PANTS:Class;
		[Embed(source = "/assets/sprites/guardLegsSpritesheet.png")] public static var RANGER2LEGS_SPRITE:Class;
		
		//Chef Outfits
		[Embed(source = "/assets/sprites/chefHat.png")] public static var CHEF_HAT:Class;
		[Embed(source = "/assets/sprites/chefHeadSpritesheet.png")] public static var CHEFHEAD_SPRITE:Class;
		
		[Embed(source = "/assets/sprites/chefShirt.png")] public static var CHEF_SHIRT:Class;
		[Embed(source = "/assets/sprites/chefBodySpritesheet.png")] public static var CHEFBODY_SPRITE:Class;
		
		[Embed(source = "/assets/sprites/chefPants.png")] public static var CHEF_PANTS:Class;
		[Embed(source = "/assets/sprites/chefLegsSpritesheet.png")] public static var CHEFLEGS_SPRITE:Class;
		
		
		//Guard Expressables
		[Embed(source = "/assets/exclamation.png")] public static var EXCLAMATION:Class;
		[Embed(source = "/assets/questionMark.png")] public static var QUESTION_MARK:Class;
		
		
		//Sprites
		[Embed(source = "/assets/sprites/Cauldron.png")] public static var Cauldron:Class;
		[Embed(source = "/assets/sprites/KitchenBoxSide.png")] public static var KitchenBoxSide:Class;
		[Embed(source = "/assets/sprites/kitchenShelves.png")] public static var kitchenShelves:Class;
		[Embed(source = "/assets/sprites/oven.png")] public static var oven:Class;
		[Embed(source = "/assets/sprites/crate2.png")] public static var crate2:Class;
		[Embed(source = "/assets/sprites/Door.png")] public static var Door:Class;
		[Embed(source = "/assets/sprites/MilkBottle.png")] public static var MilkBottle:Class;
		[Embed(source = "/assets/sprites/table.png")] public static var table:Class;
		[Embed(source = "/assets/sprites/chair.png")] public static var chair:Class;
		[Embed(source = "/assets/sprites/Jug.png")] public static var Jug:Class;
		[Embed(source = "/assets/sprites/potatoSack.png")] public static var potatoSack:Class;
		[Embed(source = "/assets/sprites/KitchenBox.png")] public static var KitchenBox:Class;
		[Embed(source = "/assets/sprites/Crate.png")] public static var Crate:Class;
		[Embed(source = "/assets/sprites/WalrusWallStandard.png")] public static var WalrusWallStandard:Class;
		[Embed(source = "/assets/sprites/WalrusArmor.png")] public static var WalrusArmor:Class;
		[Embed(source = "/assets/sprites/rug1 (opengameart - Redshrike - ccby30).png")] public static var RUG1_SPRITE:Class;
		[Embed(source = "/assets/sprites/rug2 (opengameart - Redshrike - ccby30).png")] public static var RUG2_SPRITE:Class;
		[Embed(source = "/assets/sprites/bookcase (opengameart - Redshrike - ccby30).png")] public static var BOOKCASE_SPRITE:Class;
		[Embed(source = "/assets/sprites/chair_down (opengameart - Redshrike - ccby30).png")] public static var CHAIRDOWN_SPRITE:Class;
		[Embed(source = "/assets/sprites/chair_left (opengameart - Redshrike - ccby30).png")] public static var CHAIRLEFT_SPRITE:Class;
		[Embed(source = "/assets/sprites/chair_right (opengameart - Redshrike - ccby30).png")] public static var CHAIRRIGHT_SPRITE:Class;
		[Embed(source = "/assets/sprites/chair_up (opengameart - Redshrike - ccby30).png")] public static var CHAIRUP_SPRITE:Class;
		[Embed(source = "/assets/sprites/table_round (opengameart - Redshrike - ccby30).png")] public static var TABLEROUND_SPRITE:Class;
		[Embed(source = "/assets/sprites/armor (opengameart - Redshrike - ccby30).png")] public static var ARMOR_SPRITE:Class;
		[Embed(source = "/assets/sprites/bed (opengameart - Redshrike - ccby30).png")] public static var BED_SPRITE:Class;

		// tiles
		[Embed(source = "/assets/tiles/celesteTileset.png")] public static var WALLS_TILE:Class;
		[Embed(source = "/assets/tiles/celesteFloorTilesheet.png")] public static var FLOORS_TILE:Class;
		[Embed(source = "/assets/tiles/kitchenFloor.png")] public static var KITCHEN_FLOORS_TILE:Class;
		
		//lights
		[Embed(source="/assets/light.png")] public static var LightImageClass:Class;
		[Embed(source="/assets/SharkLight.png")] public static var SharkLightImage:Class;
		
		//Keys
		[Embed(source="/assets/Key.png")] public static var KEY:Class;
		[Embed(source="/assets/Key2.png")] public static var KEY2:Class;
		
		//LOCKED DOOR
		[Embed(source="/assets/SingleDoor.png")] public static var LOCKED_DOOR:Class;
		
		//Display Heads
		[Embed(source="/assets/CharacterHead.png")] public static var CHARACTER_HEAD:Class;
		[Embed(source="/assets/CatPortrait.png")] public static var CAT_HEAD:Class;
		[Embed(source="/assets/RatPortrait.png")] public static var RAT_HEAD:Class;
		[Embed(source="/assets/PrisonerFace.png")] public static var PRISONER_HEAD:Class;
		
		//Drunk Cat BITS
		[Embed(source="/assets/sprites/DrunkCat.png")] public static var DRUNK_CAT:Class;
		[Embed(source="/assets/sprites/DrunkCatSansHat.png")] public static var DRUNK_CAT_SANS_HAT:Class;
		
		//PRISONER
		//[Embed(source="/assets/Prisoner.png")] public static var PRISONER:Class;
		
		//WATER DROP
		[Embed(source="/assets/WaterDrop.png")] public static var WATER_DROP:Class;
		
		//SAVING POINTS
		[Embed(source = "/assets/sprites/openPipe.png")] public static var OPEN_PIPE:Class;
		[Embed(source = "/assets/sprites/openingPipe.png")] public static var CLOSED_PIPE:Class;
		
		//Music
		
		[Embed(source = "/assets/dungeonSong.mp3")] public static var DUNGEON_SONG:Class;
	}
}
