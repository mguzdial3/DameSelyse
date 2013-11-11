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
		
		//Current Outfit Squares
		private var headRepresentation: FlxSprite;
		private var bodyRepresentation: FlxSprite;
		private var legsRepresentation: FlxSprite;
		
		//Various FlxTexts used in display
		private var hoverText: FlxText; //Text to display on hovering over a specific outfit
		private var inventoryText: FlxText; //Text used to display inventory item's name
		
		//Whether or not the use the currently dragging an Outfit
		private var draggingOutfit: Boolean;
		private var draggedObject: PlayerOutfit;
		private var origPos: FlxPoint; //Original position fo dragged object
		
		private var inventoryItem: InventoryItem; //The current item stored in inventory
		
		private var displaying: Boolean;
		
		//Minimap
		private var map: FlxSprite;
		private var wallStamp: FlxSprite;
		private var playerStamp: FlxSprite;
		
		public function Inventory(_outfitHandler: OutfitHandler)
		{
			super();
		
			outfitHandler = _outfitHandler;
			
			//Make the sprites
			
			//Overall Background
			menuBackground = new FlxSprite(10,10, Assets.MENU_BACKGROUND);
			
			inventoryItem=null;
			
			//Inventory Text
			inventoryText = new FlxText(200,210,80);
			inventoryText.alignment = "center";
			inventoryText.text = "Inventory";
			
			//Current Outfit Sprite Representations
			headRepresentation = new FlxSprite(253,70);
			headRepresentation.loadGraphic(
				Assets.MENU_HEADS, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				15, // width of each frame (in pixels)
				18 // height of each frame (in pixels)
			);
			
			headRepresentation.addAnimation("princess", [0]);
			headRepresentation.addAnimation("guard", [1]);
			headRepresentation.addAnimation("chef", [2]);
			headRepresentation.addAnimation("lady", [3]);
			
			headRepresentation.play("princess");
			
			bodyRepresentation = new FlxSprite(253,70);
			bodyRepresentation.loadGraphic(
				Assets.MENU_BODIES, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				15, // width of each frame (in pixels)
				18 // height of each frame (in pixels)
			);
			
			bodyRepresentation.addAnimation("princess", [0]);
			bodyRepresentation.addAnimation("guard", [1]);
			bodyRepresentation.addAnimation("chef", [2]);
			bodyRepresentation.addAnimation("lady", [3]);
			
			bodyRepresentation.play("princess");
			
			legsRepresentation = new FlxSprite(253,70);
			legsRepresentation.loadGraphic(
				Assets.MENU_LEGS, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				15, // width of each frame (in pixels)
				18 // height of each frame (in pixels)
			);
			
			legsRepresentation.addAnimation("princess", [0]);
			legsRepresentation.addAnimation("guard", [1]);
			legsRepresentation.addAnimation("chef", [2]);
			legsRepresentation.addAnimation("lady", [3]);
			
			legsRepresentation.play("princess");
			
			wallStamp = new FlxSprite();
			wallStamp.makeGraphic(2,2,0xffffffff);
			playerStamp = new FlxSprite();
			playerStamp.makeGraphic(2,2,0xffff0000);
			map = new FlxSprite(45,150);
			map.makeGraphic(80,60,0xff0000ff);
			
			
			add(menuBackground);
			
			add(legsRepresentation);
			add(bodyRepresentation);
			add(headRepresentation);
		
			add(map);
			
			add(inventoryText);
			
			
			
			displaying=false;
		}
		
		public function showInventory(currLevel: TopDownLevel, cameraOffset: FlxPoint): void
		{
		
			FlxG.mouse.show();
			
			currLevel.add(this);
			menuBackground.x+=cameraOffset.x;
			menuBackground.y+=cameraOffset.y;
			
			
			inventoryText.x+=cameraOffset.x;
			inventoryText.y+=cameraOffset.y;
			
			headRepresentation.x+=cameraOffset.x;
			headRepresentation.y+=cameraOffset.y;
			
			bodyRepresentation.x+=cameraOffset.x;
			bodyRepresentation.y+=cameraOffset.y;
			
			legsRepresentation.x+=cameraOffset.x;
			legsRepresentation.y+=cameraOffset.y;
			
			
			
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
			
			
			if(inventoryItem!=null)
			{
				inventoryItem.x=cameraOffset.x+240-inventoryItem.width/2;
				inventoryItem.y=cameraOffset.y+170-inventoryItem.height/2;
			}
			
			
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
						
						placed=true;
						
						
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
						
						placed=true;
						
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
						
						placed=true;
						
						
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
			
			
			displaying=true;
		}
		
		public function hideInventory(currLevel: TopDownLevel, cameraOffset:FlxPoint): void
		{
		
		
		 	FlxG.mouse.hide()
			currLevel.remove(this);
			menuBackground.x-=cameraOffset.x;
			menuBackground.y-=cameraOffset.y;
			
			
			inventoryText.x-=cameraOffset.x;
			inventoryText.y-=cameraOffset.y;
			
			headRepresentation.x-=cameraOffset.x;
			headRepresentation.y-=cameraOffset.y;
			
			bodyRepresentation.x-=cameraOffset.x;
			bodyRepresentation.y-=cameraOffset.y;
			
			legsRepresentation.x-=cameraOffset.x;
			legsRepresentation.y-=cameraOffset.y;
			
			
			map.x-=cameraOffset.x;
			map.y-=cameraOffset.y;
			
			
			if(inventoryItem!=null)
			{
				inventoryItem.x-=cameraOffset.x;
				inventoryItem.y-=cameraOffset.y;
			}
			
			//Clothing Outfits
			var outfits: Vector.<PlayerOutfit> = outfitHandler.getAllOutfits();
			
			
			var i: int=0;
			for(i=0; i<outfits.length; i++)
			{
				outfits[i].alpha=0;
				remove(outfits[i]);
			}
			
			
			displaying=false;
		}
		
		
		private function setToCorrectPosition(outfit: PlayerOutfit): void
		{
			var placePnt: FlxPoint = new FlxPoint(FlxG.camera.scroll.x,FlxG.camera.scroll.y);
		
			if(outfit.getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
			{
				placePnt.x+=60-outfit.width/2;
			}
			else if(outfit.getOutfitType()==PlayerOutfit.BODY_OUTFIT)
			{
				placePnt.x+=85-outfit.width/2;
			}
			else if(outfit.getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
			{
				placePnt.x+=110-outfit.width/2;
			}
			
			
			if(outfit.getOutfitSet()==OutfitHandler.PRINCESS_OUTFIT)
			{
				placePnt.y+=40-outfit.height/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
			{
				placePnt.y+=70-outfit.height/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
			{
				placePnt.y+=100-outfit.height/2;
			}
			else if(outfit.getOutfitSet()==OutfitHandler.LADY_OUTFIT)
			{
				placePnt.y+=130-outfit.height/2;
			}
			
			outfit.x=placePnt.x;
			outfit.y=placePnt.y;

			
		}
		
		public function getDisplaying(): Boolean
		{
			return displaying;
		}
		
		//Returns true if just replaced an outfit
		public function updateMenu(playa:Player ): Boolean
		{
			
			if(!draggingOutfit)
			{
				if(FlxG.mouse.justPressed())
				{
					//Check if it was in any of the outfits have been clicked
					
					var i:int=0;
					var outfits: Vector.<PlayerOutfit> = outfitHandler.getAllOutfits();
					
					var boundingBox:int = 5;
					
					while(!draggingOutfit && i<outfits.length)
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
						
							FlxG.play(Assets.GUI_SHORT_NOISE);
							//Start dragging this outfit
							origPos = new FlxPoint(outfits[i].x,outfits[i].y);
							draggedObject=outfits[i];
							draggingOutfit=true;
						}
							
					}
						i++;
					}
					
				}
			}
			else
			{
				draggedObject.x=FlxG.mouse.x;
				draggedObject.y=FlxG.mouse.y;
				
				if(FlxG.mouse.justReleased())
				{
					if(
					(draggedObject.getOutfitType()==PlayerOutfit.BODY_OUTFIT && 
					(withinBox(draggedObject,FlxG.camera.scroll.x+220,FlxG.camera.scroll.y+70,30,20,50) ||withinSprite(bodyRepresentation, draggedObject, 5)))
					||
					(draggedObject.getOutfitType()==PlayerOutfit.LEGS_OUTFIT && 
					(withinBox(draggedObject,FlxG.camera.scroll.x+220,FlxG.camera.scroll.y+100,30,20,50) ||withinSprite(legsRepresentation, draggedObject, 5)))
					||
					(draggedObject.getOutfitType()==PlayerOutfit.HEAD_OUTFIT && 
					(withinBox(draggedObject,FlxG.camera.scroll.x+220,FlxG.camera.scroll.y+40,30,20,50) || withinSprite(headRepresentation, draggedObject, 5)))
					)
					{
						FlxG.play(Assets.GUI_LONG_NOISE);
					
						var currWorn:PlayerOutfit = outfitHandler.getCurrBodyOutfit();
						var outfitIndex: int = outfitHandler.getIndexOf(currWorn);
						if(draggedObject.getOutfitType()==PlayerOutfit.BODY_OUTFIT)
						{
							
							//Put CurrWorn in Correct Position
							setToCorrectPosition(currWorn);
							
							outfitHandler.setCurrOutfit(draggedObject);
							
							draggedObject.x= FlxG.camera.scroll.x+215-draggedObject.width/2;//bodyRepresentation.x+bodyRepresentation.width/2-draggedObject.width/2;
							draggedObject.y= FlxG.camera.scroll.y+80-draggedObject.height/2;//bodyRepresentation.y+bodyRepresentation.height/2-draggedObject.height/2;
							
							playa.setNewOutfit(draggedObject.getOutfitType(), draggedObject.getOutfit());
							draggingOutfit=false;
							
							
							if(draggedObject.getOutfitSet()==0)
							{
								bodyRepresentation.play("princess");
							}
							else if(draggedObject.getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
							{
								bodyRepresentation.play("guard");
							}
							else if(draggedObject.getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
							{
								bodyRepresentation.play("chef");
							}
							else if(draggedObject.getOutfitSet()==OutfitHandler.LADY_OUTFIT)
							{
								bodyRepresentation.play("lady");
							}
							draggedObject=null;

							
							
							return true;
						}
						else if(draggedObject.getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
						{
							currWorn= outfitHandler.getCurrHeadOutfit();
							outfitIndex= outfitHandler.getIndexOf(currWorn);
							
							setToCorrectPosition(currWorn);
							outfitHandler.setCurrOutfit(draggedObject);
							
							draggedObject.x= FlxG.camera.scroll.x+215-draggedObject.width/2;//headRepresentation.x+headRepresentation.width/2-draggedObject.width/2;
							draggedObject.y= FlxG.camera.scroll.y+50-draggedObject.height/2;//headRepresentation.y+headRepresentation.height/2-draggedObject.height/2;
						
							playa.setNewOutfit(draggedObject.getOutfitType(), draggedObject.getOutfit());
							draggingOutfit=false;
							
							
							
							if(outfitHandler.getCurrHeadOutfitSet()==0)
							{
								headRepresentation.play("princess");
							}
							else if(outfitHandler.getCurrHeadOutfitSet()==OutfitHandler.GUARD_OUTFIT)
							{
								headRepresentation.play("guard");
							}
							else if(outfitHandler.getCurrHeadOutfitSet()==OutfitHandler.CHEF_OUTFIT)
							{
								headRepresentation.play("chef");
							}
							else if(outfitHandler.getCurrHeadOutfitSet()==OutfitHandler.LADY_OUTFIT)
							{
								headRepresentation.play("lady");
							}
							draggedObject=null;
	
							return true;
						}
						else if(draggedObject.getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
						{
						
							currWorn = outfitHandler.getCurrLegsOutfit();
							outfitIndex = outfitHandler.getIndexOf(currWorn);
							
							setToCorrectPosition(currWorn);
							outfitHandler.setCurrOutfit(draggedObject);
							
							draggedObject.x= FlxG.camera.scroll.x+215-draggedObject.width/2;//legsRepresentation.x+legsRepresentation.width/2-draggedObject.width/2;
							draggedObject.y= FlxG.camera.scroll.y+110-draggedObject.height/2;//legsRepresentation.y+legsRepresentation.height/2-draggedObject.height/2;
						
							playa.setNewOutfit(draggedObject.getOutfitType(), draggedObject.getOutfit());
							draggingOutfit=false;
							
							
							if(draggedObject.getOutfitSet()==0)
							{
								legsRepresentation.play("princess");
							}
							else if(draggedObject.getOutfitSet()==OutfitHandler.GUARD_OUTFIT)
							{
								legsRepresentation.play("guard");
							}
							else if(draggedObject.getOutfitSet()==OutfitHandler.CHEF_OUTFIT)
							{
								legsRepresentation.play("chef");
							}
							else if(draggedObject.getOutfitSet()==OutfitHandler.LADY_OUTFIT)
							{
								legsRepresentation.play("lady");
							}
							draggedObject=null;
							
							return true;
						}
						
						draggingOutfit=false;
					}
					else
					{
						draggedObject.x=origPos.x;
						draggedObject.y=origPos.y;
						draggingOutfit=false;
					}
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
		public function setInventoryItem(_inventoryItem: InventoryItem):Boolean
		{
			//Can only have one inventory item at a time
			if(inventoryItem==null)
			{
				//Bring up to the size of the inventoryItem Box
				_inventoryItem.scale = new FlxPoint(80.0*0.75/_inventoryItem.width,
				80.0*0.75/_inventoryItem.height);
				
				inventoryItem = _inventoryItem;
				
				
				//remove(inventoryText);
			
				//Put it in middle of the box
				inventoryItem.x = 0;
				inventoryItem.y = 0;
				
				//add(inventoryText);
				add(inventoryItem);
				
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
			remove(inventoryItem);
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
	