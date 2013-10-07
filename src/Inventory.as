package 
{
	import org.flixel.*;

	//Extends FlxGroup so we can add and remove all it's elements at once
	public class Inventory extends FlxGroup
	{
		//Reference to player's outfitHandler, used to display all of the player's current outfits
		private var outfitHandler: OutfitHandler;
		
		//Various FlxSprites used in display
		private var inventoryBox: FlxSprite; //Box that inventory item is placed in
		private var inventoryBoxBackground: FlxSprite; //Background for Box to divorce it fully from the rest of the menu
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
		private var mapBorder: FlxSprite;
		private var wallStamp: FlxSprite;
		private var playerStamp: FlxSprite;
		
		public function Inventory(_outfitHandler: OutfitHandler)
		{
			super();
		
			outfitHandler = _outfitHandler;
			
			//Make the sprites
			
			//Overall Background
			menuBackground = new FlxSprite(10,10);
			menuBackground.makeGraphic(300,220,0xfa333333);
			
			//Map Background
			mapBorder = new FlxSprite(10, 150);
			mapBorder.makeGraphic(100,80, 0xff111111);
			
			//Inventory Background
			inventoryBoxBackground = new FlxSprite(210,130);
			inventoryBoxBackground.makeGraphic(100,100,0xff995511); //Inventory area means brown, right?
			
			
			
			//Inventory Box which surrounds the inventory item
			inventoryBox = new FlxSprite(220,140);
			inventoryBox.makeGraphic(80,80,0xff000000); //Black as my soul
			
			//Inventory Text
			inventoryText = new FlxText(220,210,80);
			inventoryText.alignment = "center";
			inventoryText.text = "Inventory";
			
			//Current Outfit Sprite Representations
			headRepresentation = new FlxSprite(245,30);
			headRepresentation.makeGraphic(30,20, 0xff000000);
			
			bodyRepresentation = new FlxSprite(245,60);
			bodyRepresentation.makeGraphic(30,20, 0xff000000);
			
			legsRepresentation = new FlxSprite(245,90);
			legsRepresentation.makeGraphic(30,20, 0xff000000);
			
			wallStamp = new FlxSprite();
			wallStamp.makeGraphic(2,2,0xff000000);
			playerStamp = new FlxSprite();
			playerStamp.makeGraphic(2,2,0xffff0000);
			map = new FlxSprite(20,160);
			map.makeGraphic(80,60,0xffffffff);
			
			
			
			add(menuBackground);
			add(inventoryBoxBackground);
			add(inventoryBox);
			
			add(headRepresentation);
			add(bodyRepresentation);
			add(legsRepresentation);
			add(mapBorder);
			add(map);
			
			add(inventoryText);
			
			
			
			displaying=false;
		}
		
		public function showInventory(currLevel: TopDownLevel, cameraOffset: FlxPoint): void
		{
		
			FlxG.mouse.show()
			currLevel.add(this);
			menuBackground.x+=cameraOffset.x;
			menuBackground.y+=cameraOffset.y;
			
			inventoryBoxBackground.x+=cameraOffset.x;
			inventoryBoxBackground.y+=cameraOffset.y;
			
			inventoryBox.x+=cameraOffset.x;
			inventoryBox.y+=cameraOffset.y;
			
			inventoryText.x+=cameraOffset.x;
			inventoryText.y+=cameraOffset.y;
			
			headRepresentation.x+=cameraOffset.x;
			headRepresentation.y+=cameraOffset.y;
			
			bodyRepresentation.x+=cameraOffset.x;
			bodyRepresentation.y+=cameraOffset.y;
			
			legsRepresentation.x+=cameraOffset.x;
			legsRepresentation.y+=cameraOffset.y;
			
			mapBorder.x+=cameraOffset.x;
			mapBorder.y+=cameraOffset.y;
			
			map.fill(0xffffffff);
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
				inventoryItem.x+=cameraOffset.x;
				inventoryItem.y+=cameraOffset.y;
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
						outfits[i].x= legsRepresentation.x+legsRepresentation.width/2-outfits[i].width/2;
						outfits[i].y= legsRepresentation.y+legsRepresentation.height/2-outfits[i].height/2;
						
						placed=true;
					}
				}
				else if(outfits[i].getOutfitType()==PlayerOutfit.BODY_OUTFIT)
				{
					if(outfits[i]==outfitHandler.getCurrBodyOutfit())
					{
						//Put in center of bodyRepresentation
						outfits[i].x= bodyRepresentation.x+bodyRepresentation.width/2-outfits[i].width/2;
						outfits[i].y= bodyRepresentation.y+bodyRepresentation.height/2-outfits[i].height/2;
						
						placed=true;
					}
				}
				else if(outfits[i].getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
				{
					if(outfits[i]==outfitHandler.getCurrHeadOutfit())
					{
						//Put in center of headRepresentation
						outfits[i].x= headRepresentation.x+headRepresentation.width/2-outfits[i].width/2;
						outfits[i].y= headRepresentation.y+headRepresentation.height/2-outfits[i].height/2;
						
						placed=true;
					}
				}
				
				
				if(!placed)
				{
					outfits[i].x = cameraOffset.x+origPos.x-outfits[i].width/2;
					outfits[i].y = cameraOffset.y+origPos.y-outfits[i].height/2;
				}
				
				//Alter position
				origPos.x +=20;
				if((i+1)%3==0)
				{
					//Every third object, set a line below
					origPos.x-=60;
					origPos.y+=20;
				}
				
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
			
			inventoryBoxBackground.x-=cameraOffset.x;
			inventoryBoxBackground.y-=cameraOffset.y;
			
			inventoryBox.x-=cameraOffset.x;
			inventoryBox.y-=cameraOffset.y;
			
			inventoryText.x-=cameraOffset.x;
			inventoryText.y-=cameraOffset.y;
			
			headRepresentation.x-=cameraOffset.x;
			headRepresentation.y-=cameraOffset.y;
			
			bodyRepresentation.x-=cameraOffset.x;
			bodyRepresentation.y-=cameraOffset.y;
			
			legsRepresentation.x-=cameraOffset.x;
			legsRepresentation.y-=cameraOffset.y;
			
			mapBorder.x-=cameraOffset.x;
			mapBorder.y-=cameraOffset.y;
			
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
				
				remove(outfits[i]);
			}
			
			
			displaying=false;
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
					withinSprite(bodyRepresentation, draggedObject, 5))
					||
					(draggedObject.getOutfitType()==PlayerOutfit.LEGS_OUTFIT && 
					withinSprite(legsRepresentation, draggedObject, 5))
					||
					(draggedObject.getOutfitType()==PlayerOutfit.HEAD_OUTFIT && 
					withinSprite(headRepresentation, draggedObject, 5))
					)
					{
						var currWorn:PlayerOutfit = outfitHandler.getCurrBodyOutfit();
						var outfitIndex: int = outfitHandler.getIndexOf(currWorn);
						if(draggedObject.getOutfitType()==PlayerOutfit.BODY_OUTFIT)
						{
							
							currWorn.x = FlxG.camera.scroll.x+30+(((outfitIndex)%3)*20)-currWorn.width/2;
							currWorn.y = FlxG.camera.scroll.y+30+(((int)(outfitIndex/3)))*20-currWorn.height/2;
							
							outfitHandler.setCurrOutfit(draggedObject);
							
							draggedObject.x= bodyRepresentation.x+bodyRepresentation.width/2-draggedObject.width/2;
							draggedObject.y= bodyRepresentation.y+bodyRepresentation.height/2-draggedObject.height/2;
							
							playa.setNewOutfit(draggedObject.getOutfitType(), draggedObject.getOutfit());
							draggingOutfit=false;
							
							return true;
						}
						else if(draggedObject.getOutfitType()==PlayerOutfit.HEAD_OUTFIT)
						{
							currWorn= outfitHandler.getCurrHeadOutfit();
							outfitIndex= outfitHandler.getIndexOf(currWorn);
							
							currWorn.x = FlxG.camera.scroll.x+30+(((outfitIndex)%3)*20)-currWorn.width/2;
							currWorn.y = FlxG.camera.scroll.y+30+(((int)(outfitIndex/3)))*20-currWorn.height/2;
							
							outfitHandler.setCurrOutfit(draggedObject);
							
							draggedObject.x= headRepresentation.x+headRepresentation.width/2-draggedObject.width/2;
							draggedObject.y= headRepresentation.y+headRepresentation.height/2-draggedObject.height/2;
						
							playa.setNewOutfit(draggedObject.getOutfitType(), draggedObject.getOutfit());
							draggingOutfit=false;
							
							return true;
						}
						else if(draggedObject.getOutfitType()==PlayerOutfit.LEGS_OUTFIT)
						{
							currWorn = outfitHandler.getCurrLegsOutfit();
							outfitIndex = outfitHandler.getIndexOf(currWorn);
							
							currWorn.x = FlxG.camera.scroll.x+30+(((outfitIndex)%3)*20)-currWorn.width/2;
							currWorn.y = FlxG.camera.scroll.y+30+(((int)(outfitIndex/3)))*20-currWorn.height/2;
							
							outfitHandler.setCurrOutfit(draggedObject);
							
							draggedObject.x= legsRepresentation.x+legsRepresentation.width/2-draggedObject.width/2;
							draggedObject.y= legsRepresentation.y+legsRepresentation.height/2-draggedObject.height/2;
						
							playa.setNewOutfit(draggedObject.getOutfitType(), draggedObject.getOutfit());
							draggingOutfit=false;
							
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
		
		//Returns true if managed to set inventoryItem, false otherwise
		public function setInventoryItem(_inventoryItem: InventoryItem):Boolean
		{
			//Can only have one inventory item at a time
			if(inventoryItem==null)
			{
				//Bring up to the size of the inventoryItem Box
				_inventoryItem.scale = new FlxPoint(inventoryBox.width*0.75/(_inventoryItem.width),
				inventoryBox.height*0.75/(_inventoryItem.height));
				
				inventoryItem = _inventoryItem;
				
				
				remove(inventoryText);
				//But it in middle of the inventoryBox
				inventoryItem.x = inventoryBox.x+inventoryBox.width/2-inventoryItem.width/2;
				inventoryItem.y = inventoryBox.y+inventoryBox.height/2-inventoryItem.height/2;
				add(inventoryItem);
				add(inventoryText);
				
				
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
	