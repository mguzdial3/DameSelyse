package 
{
	import org.flixel.*;

	//Extends FlxGroup so we can add and remove all it's elements at once
	public class Inventory extends FlxGroup
	{
		//Reference to player's outfitHandler, used to display all of the player's current outfits
		private var outfitHandler: OutfitHandler;
		
		//Various FlxSprites used in display
		private var menuBackground: FlxSprite; //The entire background for the menu
		private var menuBackgroundCover: FlxSprite; //The entire cover for the menu
		
		//Current Outfit Squares
		private var headRepresentation: FlxSprite;
		private var bodyRepresentation: FlxSprite;
		private var legsRepresentation: FlxSprite;
		
		//Various FlxTexts used in display
		private var hoverText: FlxText; //Text to display on hovering over a specific outfit
		
		//Whether or not the use the currently dragging an Outfit
		private var draggingBar: Boolean;
		private var origPos: FlxPoint; //Original position fo dragged object
		
		
		private var displaying: Boolean;
		
		//Minimap
		private var map: FlxSprite;
		private var wallStamp: FlxSprite;
		private var playerStamp: FlxSprite;
		
		private var headHighlight: FlxSprite;
		private var bodyHighlight: FlxSprite;
		private var legsHighlight: FlxSprite;
		
		//180 is min x 242 is max x
		private var volumeRep: FlxSprite; 
		private var normColor: uint = 0xFFBFBDB0;
		private var selectedColor: uint = 0xFFD5D4CD;
		
		//Mute button
		private var mute: FlxSprite;
		
		
		//Text and water stuff
		private var waterDroplet:FlxSprite;
		
		//Level One
		private var dungeonText:FlxText;
		private var dungeonDropletsText:FlxText;
		private var dungeonDropletsBar:FlxSprite;
		
		//Level Two
		private var kitchenText:FlxText;
		private var kitchenDropletsText:FlxText;
		private var kitchenDropletsBar:FlxSprite;
		
		//Level Three
		private var ballroomText:FlxText;
		private var ballroomDropletsText:FlxText;
		private var ballroomDropletsBar:FlxSprite;
		
		//Level Four
		private var sanctumText:FlxText;
		private var sanctumDropletsText:FlxText;
		private var sanctumDropletsBar:FlxSprite;
		
		//98-50
		private var barMaxWidth:Number = 48;
		private var textOnColor:uint = 0xFF303338;
		private var textOffColor:uint = 0xFF4F5257;
		
		private var inventoryItem: InventoryItem; //The current item stored in inventory

		
		public function Inventory(_outfitHandler: OutfitHandler)
		{
			super();
		
			outfitHandler = _outfitHandler;
			
			//Make the sprites
			
			//Overall Background
			menuBackground = new FlxSprite(10,10, Assets.MENU_BACKGROUND2);
			
			
			
			
			//Current Outfit Sprite Representations
			headRepresentation = new FlxSprite(54,38);
			headRepresentation.loadGraphic(
				Assets.MENU_HEADS, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				45, // width of each frame (in pixels)
				54 // height of each frame (in pixels)
			);
			
			headRepresentation.addAnimation("normal", [0]);
			headRepresentation.addAnimation("guard", [1]);
			headRepresentation.addAnimation("chef", [2]);
			headRepresentation.addAnimation("lady", [3]);
			headRepresentation.addAnimation("princess", [4]);
			
			headRepresentation.play("normal");
			
			bodyRepresentation = new FlxSprite(54,38);
			bodyRepresentation.loadGraphic(
				Assets.MENU_BODIES, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				45, // width of each frame (in pixels)
				54 // height of each frame (in pixels)
			);
			
			bodyRepresentation.addAnimation("normal", [0]);
			bodyRepresentation.addAnimation("guard", [1]);
			bodyRepresentation.addAnimation("chef", [2]);
			bodyRepresentation.addAnimation("lady", [3]);
			bodyRepresentation.addAnimation("princess", [4]);
			
			bodyRepresentation.play("normal");
			
			legsRepresentation = new FlxSprite(54,38);
			legsRepresentation.loadGraphic(
				Assets.MENU_LEGS, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				45, // width of each frame (in pixels)
				54 // height of each frame (in pixels)
			);
			
			legsRepresentation.addAnimation("normal", [0]);
			legsRepresentation.addAnimation("guard", [1]);
			legsRepresentation.addAnimation("chef", [2]);
			legsRepresentation.addAnimation("lady", [3]);
			legsRepresentation.addAnimation("princess", [4]);
			
			legsRepresentation.play("normal");
			
			wallStamp = new FlxSprite();
			wallStamp.makeGraphic(2,2,0xffffffff);
			playerStamp = new FlxSprite();
			playerStamp.makeGraphic(2,2,0xffff0000);
			map = new FlxSprite(175,125);
			map.makeGraphic(80,60,0xff0000ff); //was 80, 60
			
			menuBackgroundCover= new FlxSprite(10,10, Assets.MENU_BACKGROUND2_COVER);
			
			
			//Head/body/legs:
			headHighlight = new FlxSprite(10,10,Assets.HIGHLIGHT);
			bodyHighlight = new FlxSprite(10,10,Assets.HIGHLIGHT);
			legsHighlight = new FlxSprite(10,10,Assets.HIGHLIGHT);
			
			
			volumeRep = new FlxSprite();
			volumeRep.makeGraphic(6, 16, normColor);
			
			mute = new FlxSprite(10, 10, Assets.MUTE_BUTTON);
			
			
			waterDroplet = new FlxSprite(42, 121, Assets.WATER_DROPLET);
			
			
			
			//DUNGEON
			dungeonText = new FlxText(58, 112, 200, "Dungeon");
			dungeonDropletsText = new FlxText(110,120,400,"");
			dungeonDropletsBar = new FlxSprite(60,124);
			dungeonDropletsBar.makeGraphic(barMaxWidth,6,0xff0099ff);
			
			//KITCHEN STUFF
			kitchenText = new FlxText(58, 137, 200, "Kitchen");
			kitchenDropletsText = new FlxText(110,145,400,"");
			kitchenDropletsBar = new FlxSprite(60,149);
			kitchenDropletsBar.makeGraphic(barMaxWidth,6,0xff0099ff);
			
			//BALLROOM STUFF
			ballroomText = new FlxText(58, 137, 200, "Ballroom");
			ballroomDropletsText = new FlxText(110,145,400,"");
			ballroomDropletsBar = new FlxSprite(60,149);
			ballroomDropletsBar.makeGraphic(barMaxWidth,6,0xff0099ff);
			
			//SANCTUM STUFF
			sanctumText = new FlxText(58, 137, 200, "Sanctum");
			sanctumDropletsText = new FlxText(110,145,400,"");
			sanctumDropletsBar = new FlxSprite(60,149);
			sanctumDropletsBar.makeGraphic(barMaxWidth,6,0xff0099ff);
			
			
			add(menuBackground);
			
			add(legsRepresentation);
			add(bodyRepresentation);
			add(headRepresentation);
			
			add(map);
			
			add(headHighlight);
			add(bodyHighlight);
			add(legsHighlight);
			
			//Add level stuff
			
			add(waterDroplet);
			add(dungeonDropletsBar);
			add(kitchenDropletsBar);
			add(ballroomDropletsBar);
			add(sanctumDropletsBar);
			
			add(menuBackgroundCover);
			add(dungeonDropletsText);
			add(dungeonText);
			add(kitchenDropletsText);
			add(kitchenText);
			add(ballroomDropletsText);
			add(ballroomText);
			add(sanctumDropletsText);
			add(sanctumText);
			
			add(volumeRep);
			
			
			
			
			
			add(mute);
			
			displaying=false;
		}
		
		//Set its position based on volume
		private function setPosBasedOnVolume():void
		{
			volumeRep.y = FlxG.camera.scroll.y+10+184;
			volumeRep.x = FlxG.camera.scroll.x+10+180+FlxG.volume*62.0;
			
			
			if(FlxG.volume<0.01)
			{
				mute.x = FlxG.camera.scroll.x+10+160;
				mute.y = FlxG.camera.scroll.y+10+184;
			}
			else
			{
				mute.x = -10;
				mute.y = -10;
			}
			
		}
		
		//Set its Volume based on position
		private function setVolumeBasedOnPos(): void
		{
			
			FlxG.volume = (volumeRep.x-FlxG.camera.scroll.x-10-180)/62.0;
			
			
			if(FlxG.volume<0.01)
			{
				mute.x = FlxG.camera.scroll.x+10+160;
				mute.y = FlxG.camera.scroll.y+10+184;
			}
			else
			{
				mute.x = -10;
				mute.y = -10;
			}
		}
		
		
		public function showInventory(currLevel: TopDownLevel, cameraOffset: FlxPoint): void
		{
		
			FlxG.mouse.show();
			
			currLevel.add(this);
			menuBackground.x+=cameraOffset.x;
			menuBackground.y+=cameraOffset.y;
			
			menuBackgroundCover.x+=cameraOffset.x;
			menuBackgroundCover.y+=cameraOffset.y;
			
			headRepresentation.x+=cameraOffset.x;
			headRepresentation.y+=cameraOffset.y;
			
			bodyRepresentation.x+=cameraOffset.x;
			bodyRepresentation.y+=cameraOffset.y;
			
			legsRepresentation.x+=cameraOffset.x;
			legsRepresentation.y+=cameraOffset.y;
			
			//Volume stuff
			setPosBasedOnVolume();
			
			
			
			
			
			//Map Color
			map.fill(0xff4f7fcf);
			var stx: int = int(FlxG.camera.scroll.x / 16) - 10; //start x
			var sty: int = int(FlxG.camera.scroll.y / 16) - 7; //start y
			var tx: int; //tile x
			var ty: int; //tile y
			for (tx = 0; tx < 40; tx++){
				for (ty = 0; ty < 30; ty++){
					if (FlxTilemap(currLevel.wallGroup.getFirstAlive()).getTile(stx+tx,sty+ty) != 0){
						map.stamp(wallStamp,tx*2,ty*2);
					}
				}
			}
			var px: int = int((currLevel.player.x - cameraOffset.x)/16) + 11; //player x
			var py: int = int((currLevel.player.y - cameraOffset.y)/16) + 7; //player y
			map.stamp(playerStamp,(px*2),py*2);
			map.x += cameraOffset.x;
			map.y += cameraOffset.y;
			
			
			
			
			var outfits: Vector.<PlayerOutfit> = outfitHandler.getAllOutfits();
			
			var origPos :FlxPoint = new FlxPoint(30,30);
			
			var i: int=0;
			for(i=0; i<outfits.length; i++)
			{
				var placed: Boolean = false;
				
				//This is here if we want to organize them by type too
				if(outfits[i].getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
				{
					if(outfits[i]==outfitHandler.getCurrLegsOutfit())
					{
						//Put in center of legRepresentation
						outfits[i].x= cameraOffset.x+215-outfits[i].width/2;//legsRepresentation.x+legsRepresentation.width/2-outfits[i].width/2;
						outfits[i].y= cameraOffset.y+110-outfits[i].height/2;//legsRepresentation.y+legsRepresentation.height/2-outfits[i].height/2;
						
						//placed=true;
						setHighlightPosition(legsHighlight, outfits[i]);
						
						
						
						if(outfits[i].getOutfitSet()==OutfitHandler.NORMAL_OUTFIT)
						{
							legsRepresentation.play("normal");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
						{
							legsRepresentation.play("princess");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
						{
							legsRepresentation.play("guard");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
						{
							legsRepresentation.play("chef");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.LADY_OUTFIT)
						{
							legsRepresentation.play("lady");
						}
					}
				}
				else if(outfits[i].getOutfitType()==PlayerOutfit.BODY_OUTFIT)
				{
					if(outfits[i]==outfitHandler.getCurrBodyOutfit())
					{
						//Put in center of bodyRepresentation
						outfits[i].x= cameraOffset.x+216-outfits[i].width/2;//bodyRepresentation.x+bodyRepresentation.width/2-outfits[i].width/2;
						outfits[i].y= cameraOffset.y+80-outfits[i].height/2;//bodyRepresentation.y+bodyRepresentation.height/2-outfits[i].height/2;
						
						//placed=true;
						setHighlightPosition(bodyHighlight, outfits[i]);
						
						if(outfits[i].getOutfitSet()==OutfitHandler.NORMAL_OUTFIT)
						{
							bodyRepresentation.play("normal");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
						{
							bodyRepresentation.play("princess");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
						{
							bodyRepresentation.play("guard");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
						{
							bodyRepresentation.play("chef");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.LADY_OUTFIT)
						{
							bodyRepresentation.play("lady");
						}
					}
				}
				else if(outfits[i].getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
				{
					if(outfits[i]==outfitHandler.getCurrHeadOutfit())
					{
						//Put in center of headRepresentation
						outfits[i].x= cameraOffset.x+215-outfits[i].width/2;//headRepresentation.x+headRepresentation.width/2-outfits[i].width/2;
						outfits[i].y= cameraOffset.y+50-outfits[i].height/2;//headRepresentation.y+headRepresentation.height/2-outfits[i].height/2;
						
						//placed=true;
						setHighlightPosition(headHighlight, outfits[i]);
						
						
						if(outfits[i].getOutfitSet()==OutfitHandler.NORMAL_OUTFIT)
						{
							headRepresentation.play("normal");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
						{
							headRepresentation.play("princess");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
						{
							headRepresentation.play("guard");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
						{
							headRepresentation.play("chef");
						}
						if(outfits[i].getOutfitSet()==OutfitHandler.LADY_OUTFIT)
						{
							headRepresentation.play("lady");
						}
					}
				}
				
				
				if(!placed)
				{
					setToCorrectPosition(outfits[i]);
				}
				
				
				
				
				outfits[i].alpha=1;
				add(outfits[i]);
			}
			
			
			//LEVEL STUFF SHOW
			
			//Water Stuff
			var currentLevel:String = currLevel.getLevelName();
			
			var levelNamesArray:Array = new Array("Dungeon", "Kitchen", "Ballroom", "Sanctum");
			
			
			var levelAt:int = 0;
			for(i=0; i<levelNamesArray.length; i++)
			{
				if(currentLevel==levelNamesArray[i])
				{
					levelAt=i;
				}
			}
			
			dungeonText.x=58+cameraOffset.x;
			dungeonDropletsText.x=110+cameraOffset.x;
			dungeonDropletsBar.x=60+cameraOffset.x;
			
			
			dungeonText.y=112+cameraOffset.y;
			dungeonDropletsText.y=120+cameraOffset.y;
			dungeonDropletsBar.y=124+cameraOffset.y;
			
			waterDroplet.x=42+cameraOffset.x;
			waterDroplet.y=121+cameraOffset.y;
			
			
			//DUNGEON ONLY
			if(levelAt>=0) 
			{
				//Have to check, it's a dungeon
				var dungeonSaver:FlxSave = new FlxSave();
				dungeonSaver.bind("levelData"+"Dungeon");
				
				
				
				
				dungeonDropletsText.text=""+dungeonSaver.data.numDrops.toString()+"/"+dungeonSaver.data.maxDrops.toString();
				
				var waterRatio:Number = Number(dungeonSaver.data.numDrops)/Number(dungeonSaver.data.maxDrops);
				
				dungeonDropletsBar.scale.x = waterRatio;
				dungeonDropletsBar.x-= barMaxWidth/2 - (barMaxWidth*waterRatio)/2;
				
				
				//Coloring
				dungeonText.color = textOnColor;
				dungeonDropletsText.color = textOnColor;
				
				
			} //Kitchen
			if(levelAt>=1)
			{
				
				//Coloring Dungeon
				dungeonText.color = textOffColor;
				dungeonDropletsText.color = textOffColor;
				
				kitchenText.color = textOnColor;
				kitchenDropletsText.color = textOnColor;
				
				waterDroplet.y+=26;
				
				//KITCHEN STUFF
				kitchenText.x=58+cameraOffset.x;
				kitchenDropletsText.x=110+cameraOffset.x;
				kitchenDropletsBar.x=60+cameraOffset.x;
			
				kitchenText.y=138+cameraOffset.y;
				kitchenDropletsText.y=146+cameraOffset.y;
				kitchenDropletsBar.y=150+cameraOffset.y;
				kitchenDropletsText.text = "30/30";
				
				//KITCHEN SAVER STUFF
				var kitchenSaver:FlxSave = new FlxSave();
				kitchenSaver.bind("levelData"+"Kitchen");
				
				
				kitchenDropletsText.text=""+kitchenSaver.data.numDrops.toString()+"/"+kitchenSaver.data.maxDrops.toString();
				
				var waterRatioK:Number = Number(kitchenSaver.data.numDrops)/Number(kitchenSaver.data.maxDrops);
				
				kitchenDropletsBar.scale.x = waterRatioK;
				kitchenDropletsBar.x-= barMaxWidth/2 - (barMaxWidth*waterRatioK)/2;
				
				
			}//Ballroom
			if(levelAt>=2)
			{
				//Coloring Kitchen
				kitchenText.color = textOffColor;
				kitchenDropletsText.color = textOffColor;
				
				ballroomText.color = textOnColor;
				ballroomDropletsText.color = textOnColor;
				
				
				waterDroplet.y+=26;
				
				//Ballroom STUFF
				ballroomText.x=58+cameraOffset.x;
				ballroomDropletsText.x=110+cameraOffset.x;
				ballroomDropletsBar.x=60+cameraOffset.x;
			
				ballroomText.y=164+cameraOffset.y;
				ballroomDropletsText.y=172+cameraOffset.y;
				ballroomDropletsBar.y=176+cameraOffset.y;
				ballroomDropletsText.text = "30/30";
				
				//KITCHEN SAVER STUFF
				var ballroomSaver:FlxSave = new FlxSave();
				ballroomSaver.bind("levelData"+"Ballroom");
				
				
				ballroomDropletsText.text=""+ballroomSaver.data.numDrops.toString()+"/"+ballroomSaver.data.maxDrops.toString();
				
				var waterRatioB:Number = Number(ballroomSaver.data.numDrops)/Number(ballroomSaver.data.maxDrops);
				
				ballroomDropletsBar.scale.x = waterRatioB;
				ballroomDropletsBar.x-= barMaxWidth/2 - (barMaxWidth*waterRatioB)/2;
			}//Sanctum
			if(levelAt>=3)
			{
				//Coloring Ballroom
				ballroomText.color = textOffColor;
				ballroomDropletsText.color = textOffColor;
				
				sanctumText.color = textOnColor;
				sanctumDropletsText.color = textOnColor;
				
				waterDroplet.y+=26;
				
				//SANCTUM STUFF
				sanctumText.x=58+cameraOffset.x;
				sanctumDropletsText.x=110+cameraOffset.x;
				sanctumDropletsBar.x=60+cameraOffset.x;
			
				sanctumText.y=190+cameraOffset.y;
				sanctumDropletsText.y=198+cameraOffset.y;
				sanctumDropletsBar.y=202+cameraOffset.y;
				sanctumDropletsText.text = "30/30";
				
				//KITCHEN SAVER STUFF
				var sanctumSaver:FlxSave = new FlxSave();
				sanctumSaver.bind("levelData"+"Sanctum");
				
				
				sanctumDropletsText.text=""+sanctumSaver.data.numDrops.toString()+"/"+sanctumSaver.data.maxDrops.toString();
				
				var waterRatioS:Number = Number(sanctumSaver.data.numDrops)/Number(sanctumSaver.data.maxDrops);
				
				sanctumDropletsBar.scale.x = waterRatioS;
				sanctumDropletsBar.x-= barMaxWidth/2 - (barMaxWidth*waterRatioS)/2;
			}
			
			
			
			
			
			displaying=true;
		}
		
		public function hideInventory(currLevel: TopDownLevel, cameraOffset:FlxPoint): void
		{
		
		
		 	FlxG.mouse.hide()
			currLevel.remove(this);
			menuBackground.x-=cameraOffset.x;
			menuBackground.y-=cameraOffset.y;
			
			menuBackgroundCover.x-=cameraOffset.x;
			menuBackgroundCover.y-=cameraOffset.y;
			
			
			headRepresentation.x-=cameraOffset.x;
			headRepresentation.y-=cameraOffset.y;
			
			bodyRepresentation.x-=cameraOffset.x;
			bodyRepresentation.y-=cameraOffset.y;
			
			legsRepresentation.x-=cameraOffset.x;
			legsRepresentation.y-=cameraOffset.y;
			
			
			
			map.x-=cameraOffset.x;
			map.y-=cameraOffset.y;
			
			
			mute.x = -10;
			mute.y = -10;
			
			
			
			//Clothing Outfits
			var outfits: Vector.<PlayerOutfit> = outfitHandler.getAllOutfits();
			
			
			var i: int=0;
			for(i=0; i<outfits.length; i++)
			{
				outfits[i].alpha=0;
				remove(outfits[i]);
			}
			
			//HIDE LEVEL STUFF
			dungeonText.x=-cameraOffset.x;
			dungeonDropletsText.x=-cameraOffset.x;
			dungeonDropletsBar.x=-cameraOffset.x;
			waterDroplet.x=-cameraOffset.x;
			
			
			dungeonText.y=-cameraOffset.y;
			dungeonDropletsText.y=-cameraOffset.y;
			dungeonDropletsBar.y=-cameraOffset.y;
			waterDroplet.y=-cameraOffset.y;
			
			//KITCHEN
			kitchenText.x=-cameraOffset.x;
			kitchenDropletsText.x=-cameraOffset.x;
			kitchenDropletsBar.x=-cameraOffset.x;
			
			kitchenText.y=-cameraOffset.y;
			kitchenDropletsText.y=-cameraOffset.y;
			kitchenDropletsBar.y=-cameraOffset.y;
			
			//BALLROOM
			ballroomText.x=-cameraOffset.x;
			ballroomDropletsText.x=-cameraOffset.x;
			ballroomDropletsBar.x=-cameraOffset.x;
			
			ballroomText.y=-cameraOffset.y;
			ballroomDropletsText.y=-cameraOffset.y;
			ballroomDropletsBar.y=-cameraOffset.y;
			
			//SANCTUM
			sanctumText.x=-cameraOffset.x;
			sanctumDropletsText.x=-cameraOffset.x;
			sanctumDropletsBar.x=-cameraOffset.x;
			
			sanctumText.y=-cameraOffset.y;
			sanctumDropletsText.y=-cameraOffset.y;
			sanctumDropletsBar.y=-cameraOffset.y;
			
			displaying=false;
		}
		
		
		private function setToCorrectPosition(outfit: PlayerOutfit): void
		{
			var placePnt: FlxPoint = new FlxPoint(FlxG.camera.scroll.x,FlxG.camera.scroll.y);
		
			if(outfit.getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
			{
				placePnt.y+=40-outfit.height/2;
			}
			else if(outfit.getOutfitType()==PlayerOutfit.BODY_OUTFIT)
			{
				placePnt.y+=70-outfit.height/2;
			}
			else if(outfit.getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
			{
				placePnt.y+=100-outfit.height/2;
			}
			
			
			if(outfit.getOutfitSet()==OutfitHandler.NORMAL_OUTFIT)
			{
				placePnt.x+=164-outfit.width/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
			{
				placePnt.x+=189-outfit.width/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
			{
				placePnt.x+=214-outfit.width/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
			{
				placePnt.x+=239-outfit.width/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.LADY_OUTFIT)
			{
				placePnt.x+=264-outfit.width/2;
			}
			
			outfit.x=placePnt.x;
			outfit.y=placePnt.y;

			
		}
		
		
		private function setHighlightPosition(highlight:FlxSprite, outfit: PlayerOutfit):void
		{
			var placePnt: FlxPoint = new FlxPoint(FlxG.camera.scroll.x,FlxG.camera.scroll.y);
		
			if(outfit.getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
			{
				placePnt.y+=40-highlight.height/2;
			}
			else if(outfit.getOutfitType()==PlayerOutfit.BODY_OUTFIT)
			{
				placePnt.y+=70-highlight.height/2;
			}
			else if(outfit.getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
			{
				placePnt.y+=100-highlight.height/2;
			}
			
			
			if(outfit.getOutfitSet()==OutfitHandler.NORMAL_OUTFIT)
			{
				placePnt.x+=164-highlight.width/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
			{
				placePnt.x+=189-highlight.width/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
			{
				placePnt.x+=214-highlight.width/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
			{
				placePnt.x+=239-highlight.width/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.LADY_OUTFIT)
			{
				placePnt.x+=264-highlight.width/2;
			}
			
			highlight.x=placePnt.x;
			highlight.y=placePnt.y;

		}
		
		public function getDisplaying(): Boolean
		{
			return displaying;
		}
		
		//Returns true if just replaced an outfit
		public function updateMenu(playa:Player ): Boolean
		{
			
			if(!draggingBar)
			{
				if(FlxG.mouse.justPressed())
				{
					//Check if it was in any of the outfits have been clicked
				
					var i:int=0;
					var outfits: Vector.<PlayerOutfit> = outfitHandler.getAllOutfits();
				
					var boundingBox:int = 5;
				
					while(i<outfits.length)
					{
					
						if(
							FlxG.mouse.y+boundingBox>outfits[i].y &&
							FlxG.mouse.y-boundingBox<outfits[i].y+outfits[i].height &&
							FlxG.mouse.x+boundingBox>outfits[i].x&&
							FlxG.mouse.x-boundingBox<outfits[i].x+outfits[i].width	
						)
						{
				
							if(outfits[i]!=outfitHandler.getCurrLegsOutfit() && 
								outfits[i]!=outfitHandler.getCurrBodyOutfit() && 
								outfits[i]!=outfitHandler.getCurrHeadOutfit())
							{
					
								//FlxG.play(Assets.GUI_SHORT_NOISE);
						
							FlxG.play(Assets.CLOTHES_NOISE);
						
								outfitHandler.setCurrOutfit(outfits[i]);
												
								playa.setNewOutfit(outfits[i].getOutfitType(), outfits[i].getOutfit());
						
						
						
								if( outfits[i].getOutfitType()==PlayerOutfit.BODY_OUTFIT)
								{
							
									if( outfits[i].getOutfitSet()==OutfitHandler.NORMAL_OUTFIT)
									{
										bodyRepresentation.play("normal");
									}
									else if( outfits[i].getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
									{
										bodyRepresentation.play("princess");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
									{
										bodyRepresentation.play("guard");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
									{
										bodyRepresentation.play("chef");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.LADY_OUTFIT)
									{
										bodyRepresentation.play("lady");
									}
							
									setHighlightPosition(bodyHighlight,outfits[i]);
							
									return true;
								}
								else if(outfits[i].getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
								{
							
									if( outfits[i].getOutfitSet()==OutfitHandler.NORMAL_OUTFIT)
									{
										headRepresentation.play("normal");
									}
									else if( outfits[i].getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
									{
										headRepresentation.play("princess");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
									{
										headRepresentation.play("guard");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
									{
										headRepresentation.play("chef");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.LADY_OUTFIT)
									{
										headRepresentation.play("lady");
									}
									setHighlightPosition(headHighlight,outfits[i]);
							
									return true;
								}
								else if(outfits[i].getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
								{
							
									if( outfits[i].getOutfitSet()==OutfitHandler.NORMAL_OUTFIT)
									{
										legsRepresentation.play("normal");
									}
									else if( outfits[i].getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
									{
										legsRepresentation.play("princess");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
									{
										legsRepresentation.play("guard");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
									{
										legsRepresentation.play("chef");
									}
									else if(outfits[i].getOutfitSet()==OutfitHandler.LADY_OUTFIT)
									{
										legsRepresentation.play("lady");
									}
							
									setHighlightPosition(legsHighlight,outfits[i]);
							
									return true;
								}
						
							}
						
						}
						i++;
					}
					
					//Check and see if we hit the volume bar
					if(
						FlxG.mouse.y+boundingBox>volumeRep.y &&
						FlxG.mouse.y-boundingBox<volumeRep.y+volumeRep.height &&
						FlxG.mouse.x+boundingBox>volumeRep.x&&
						FlxG.mouse.x-boundingBox<volumeRep.x+volumeRep.width	
					)
					{
						draggingBar = true;
						volumeRep.color = selectedColor;
						FlxG.play(Assets.GUI_SHORT_NOISE);
					}
				}
			}
			else
			{
			
				volumeRep.x=FlxG.mouse.x;
				
				if(volumeRep.x<180+FlxG.camera.scroll.x+10)
				{
					volumeRep.x=180+FlxG.camera.scroll.x+10
				}
				
				if(volumeRep.x>242+FlxG.camera.scroll.x+10)
				{
					volumeRep.x=242+FlxG.camera.scroll.x+10;
				}
				
				if(FlxG.mouse.justReleased())
				{
					draggingBar = false;
					volumeRep.color = normColor;
					FlxG.play(Assets.GUI_SHORT_NOISE);
					
					setVolumeBasedOnPos();
				}
			
			}
			
			
			
			return false;
		}		
		
		private function withinSprite( sprite: FlxSprite, point: FlxSprite, extraBit:int=0): Boolean
		{
			return ((point.x+extraBit>sprite.x && point.x-extraBit<sprite.x+sprite.width)
			&& (point.y+extraBit>sprite.y && point.y-extraBit<sprite.y+sprite.height));
		}
		
		private function withinBox(point: FlxSprite, boxX:Number, boxY: Number, boxWidth: Number, boxHeight: Number, extraBit:int=0): Boolean
		{
			return ((point.x+extraBit>boxX && point.x-extraBit<boxX+boxWidth)
			&& (point.y+extraBit>boxY && point.y-extraBit<boxY+boxHeight));
		}
		
		
		//Returns true if managed to set inventoryItem, false otherwise
		public function setInventoryItem(_inventoryItem: InventoryItem, group:FlxGroup = null):Boolean
		{
			//Can only have one inventory item at a time
			if(inventoryItem==null)
			{
				//Bring up to the size of the inventoryItem Box
				//_inventoryItem.scale = new FlxPoint(80.0*0.75/_inventoryItem.width,
				//80.0*0.75/_inventoryItem.height);
				
				inventoryItem = _inventoryItem;
				
				
			
				//Put it in middle of the box
				//inventoryItem.x = 0;
				//inventoryItem.y = 0;
				
				inventoryItem.velocity.x=inventoryItem.velocity.y=0;
				inventoryItem.acceleration.x=inventoryItem.acceleration.y=0;
					
				inventoryItem.immovable = false;
				
				
					
					
				inventoryItem.x = 320-inventoryItem.width;
				inventoryItem.y = 30-inventoryItem.height/2;	
					
				inventoryItem.scrollFactor = new FlxPoint(0,0);	
					
				if(group!=null)
				{
					group.add(inventoryItem);
				}
				
				return true;
			}
			
			return false;
		
		}
		
		
		
		//Used to get reference to inventory item
		public function getInventoryItem(): InventoryItem
		{
			
			return inventoryItem;
		}
		
		public function retrieveInventoryItem(): InventoryItem
		{
			var tempReference: InventoryItem = inventoryItem;
			inventoryItem.scrollFactor = new FlxPoint(1,1);	
			inventoryItem.x=-50;
			inventoryItem.y=-50;
			
			inventoryItem=null;
			
			
			
			return tempReference;
		}
		
		
		public function getItemName(): String
		{
			var stringToReturn:String = "";
			
			if(inventoryItem!=null)
			{
				stringToReturn = inventoryItem.getItemName();
			}
			
			return stringToReturn;
			
		}
		
		
	}
}
	