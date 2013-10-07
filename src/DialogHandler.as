package 
{
	import org.flixel.*;

	
	public class DialogHandler extends FlxGroup
	{
		private var currNode: DialogNode;
		private var head:FlxSprite;//Sprite display for the current head of the current speaking person
		private var headBackground:FlxSprite;
		private var textBackground:FlxSprite;
		private var dialogText:FlxText;
		
		//The index we're at presently in copying the string over to our dialogText
		private var stringIndex:int;
		
		//Constants for various different heads
		public static const PLAYER_HEAD:uint=0;
		//For example purposes
		public static const CAT_HEAD:uint=1;
		
		public static const RAT_HEAD:uint=2;
		public static const PRISONER_HEAD:uint=3;
		
		
		//Potential Responses From Handling Dialog
		public static const KEEP_GOING: int = 0;
		public static const END: int = 1;
		public static const QUESTION_NEXT:int = 2;
		
		
		public function DialogHandler()
		{
			super();
			//Set up display for a 320 by 240 screen
			head = new FlxSprite(10,170);
			head.makeGraphic(60,60,0xff000000);//Black Background for heads
			
			headBackground = new FlxSprite(0,160);
			headBackground.makeGraphic(80,80,0xff404050);//Gray head back
			
			textBackground = new FlxSprite(80,160);
			textBackground.makeGraphic(240,80, 0xff444454);//Slightly lighter than head background
			
			dialogText = new FlxText(90,170,220);
						
			
			add(headBackground);
			
			add(textBackground);
			add(dialogText);
			add(head);
			
		}
		
		
		//Sets up display
		public function setCurrNode(_currNode: DialogNode):void
		{
			currNode = _currNode;
			
			//Clear previous text
			dialogText.text="";
			stringIndex=0;
			
			remove(head);
			//Set up head
			if(currNode.getFaceToDisplay()==PLAYER_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.CHARACTER_HEAD);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay() ==CAT_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.CAT_HEAD);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay() ==RAT_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.RAT_HEAD);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay() ==PRISONER_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.PRISONER_HEAD);
				
				add(head);
			}
			
		}
		
		public function getCurrNode() :DialogNode
		{
			return currNode;
		}
		
		public function showDialogHandler(currLevel: FlxGroup):void
		{
			currLevel.add(this);
		}
		
		public function hideDialogHandler(currLevel: FlxGroup):void
		{
			currLevel.remove(this);
		}
		
		
		//Return true if we're done
		public function displayDialogHandler(cameraScroll: FlxPoint, inventory:Inventory, player:Player):int
		{
		
			var toReturn:int = KEEP_GOING;
			
			head.x = 10+cameraScroll.x;
			head.y= 170+cameraScroll.y;
			
			headBackground.x = cameraScroll.x;
			headBackground.y = cameraScroll.y+160;
			
			textBackground.x = cameraScroll.x+80;
			textBackground.y= cameraScroll.y+160;
			
			
			//Copy over the string char by char
			if(stringIndex<currNode.getTextToDisplay().length)
			{
				//remove(dialogText);
			
				dialogText.text+= currNode.getTextToDisplay().charAt(stringIndex);
				
				//add(dialogText);
				stringIndex++;
			}
			
			dialogText.x = cameraScroll.x+90;
			dialogText.y = cameraScroll.y+170;
			
			
			if(FlxG.keys.justReleased("SPACE")) //This way you can't just constantly hold Space to move through dialogue faster
			{
				//Only move on if the text has completely displayed
				if(stringIndex>=currNode.getTextToDisplay().length)
				{
					
					currNode.handleDialogEnd(inventory,player);
					var nextNode: DialogNode = currNode.getNextNode();
					
					
					if(nextNode!=null && nextNode.canTransfer(inventory) && !nextNode.getHasQuestions())
					{
						setCurrNode(nextNode);
					}
					else if(nextNode!=null && nextNode.canTransfer(inventory) && nextNode.getHasQuestions())
					{
						setCurrNode(nextNode);
						toReturn = QUESTION_NEXT;
					}
					else
					{
						//We're done here
						toReturn = END;
					}
				}	
			}
			
			return toReturn;
			
		}
		
		public function getAfterEnd(): uint
		{
			return currNode.getAfterEnd();
		}

		//Sets question up in one go without the letter by letter display		
		public function displayDialogHandlerTotal(cameraScroll: FlxPoint):void
		{
			head.x = 10+cameraScroll.x;
			head.y= 170+cameraScroll.y;
			
			headBackground.x = cameraScroll.x;
			headBackground.y = cameraScroll.y+160;
			
			textBackground.x = cameraScroll.x+80;
			textBackground.y= cameraScroll.y+160;
			
			
			
			//Set string all up
			dialogText.text+= currNode.getTextToDisplay();
			
			dialogText.x = cameraScroll.x+90;
			dialogText.y = cameraScroll.y+170;
			
		}
		
		
		
	
	}
}