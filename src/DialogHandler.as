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
		private var continueText:FlxSprite;
		private var alphaCounter:Number;
		
		//The index we're at presently in copying the string over to our dialogText
		private var stringIndex:int;
		
		//Constants for various different heads
		public static const PLAYER_HEAD:int=0;
		//For example purposes
		public static const CAT_HEAD:uint=1;
		public static const CAT_HEAD_FLIP:uint=30;
		
		public static const RAT_HEAD:uint=2;
		public static const PRISONER_HEAD:uint=3;
		public static const SHARK_HEAD:uint=4;
		public static const WAITER_HEAD: uint = 5;
		public static const NELSON_HEAD:uint=6;
		public static const EYEPATCH_HEAD: uint = 7;
		public static const NI_HEAD: uint = 8;
		public static const NIMA_HEAD: uint = 9;
		public static const SEPAC_HEAD: uint = 10;
		public static const FEM_HEAD: uint = 11;
		public static const TAL_HEAD: uint = 12;
		public static const SIVA_HEAD: uint = 13;
		public static const HACHI_HEAD: uint = 14;
		public static const PITU_HEAD: uint = 15;
		public static const FISH_HEAD: uint = 16;
		public static const HEAD_COOK_HEAD: uint = 17;
		public static const HATLESS_COOK_HEAD: uint = 18;
		public static const EVIL_CELESTE_HEAD: uint = 19;
		public static const WALRUS_HEAD: uint = 20;
		public static const PRISONER_HEAD_FLIP: uint = 21;
		public static const BLIND_HEAD: uint = 22;
		public static const SHARKEESIAN_HEAD: uint = 23;
		public static const MOOGOST_HEAD: uint = 24;
		public static const FLAPPY_HEAD: uint = 25;
		public static const SEALIA_HEAD: uint = 26;
		
		
		//Potential Responses From Handling Dialog
		public static const KEEP_GOING: int = 0;
		public static const END: int = 1;
		public static const QUESTION_NEXT:int = 2;
		public static const MOVE_RAT_RIGHT:int = 3;
		
		
		public function DialogHandler()
		{
			super();
			//Set up display for a 320 by 240 screen
			head = new FlxSprite(-500,170);
			head.makeGraphic(60,60,0xff000000);//Black Background for heads
			
			headBackground = new FlxSprite(-500,160);
			headBackground.loadGraphic(Assets.FACE_BOX);//Gray head back
			
			textBackground = new FlxSprite(-500,-160);
			textBackground.loadGraphic(Assets.DIALOG_BOX);//Slightly lighter than head background
			
			dialogText = new FlxText(-500,-170,220);
			dialogText.setFormat("TEST", 8, 0xffffffff, "left");		
			
			continueText = new FlxSprite(-240,214,Assets.CONTINUE_TEXT);
			continueText.alpha = 0;
			
			
			add(headBackground);
			
			add(textBackground);
			add(dialogText);
			add(head);
			add(continueText);
			
		}
		
		
		//Sets up display
		public function setCurrNode(_currNode: DialogNode):void
		{
			alphaCounter=0;
			continueText.alpha = 0;
		
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
			else if(currNode.getFaceToDisplay() ==CAT_HEAD_FLIP)
			{
				head = new FlxSprite(head.x,head.y,Assets.CAT_HEAD_FLIP);
				
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
			else if(currNode.getFaceToDisplay() ==SHARK_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.SHARK_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==WAITER_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.WAITER_PORTRAIT); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==NELSON_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.NELSON_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==EYEPATCH_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.EYEPATCH_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==NI_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.NI_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==NIMA_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.NIMA_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==SEPAC_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.SEPAC_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==FEM_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.FEM_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==TAL_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.TAL_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==SIVA_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.SIVA_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==HACHI_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.HACHI_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==PITU_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.PITU_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==FISH_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.FISH_HEAD); //Replace this with correct head when we get it
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==HEAD_COOK_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.HEAD_COOK_HEAD);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==HATLESS_COOK_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.HATLESS_COOK_HEAD);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==EVIL_CELESTE_HEAD)
			{
				
				head = new FlxSprite(head.x,head.y,Assets.EVIL_CELESTE_HEAD);
				
				add(head);
			
			}
			else if(currNode.getFaceToDisplay()==WALRUS_HEAD)
			{
				
				head = new FlxSprite(head.x,head.y,Assets.WALRUS_HEAD);
				
				add(head);
			
			}
			else if(currNode.getFaceToDisplay()==PRISONER_HEAD_FLIP)
			{
				head = new FlxSprite(head.x,head.y,Assets.PRISONER_HEAD_FLIP);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==BLIND_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.BLIND_HEAD);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==SHARKEESIAN_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.SHARKEESIAN_PORTRAIT);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==MOOGOST_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.MOOGOST_PORTRAIT);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==FLAPPY_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.FLAPPY_PORTRAIT);
				
				add(head);
			}
			else if(currNode.getFaceToDisplay()==SEALIA_HEAD)
			{
				head = new FlxSprite(head.x,head.y,Assets.SEALIA_PORTRAIT);
				
				add(head);
			}
			
			//Play Sound
			
			var sound: Class = currNode.getSoundToPlay();
			
			if(sound!=null)
			{
				FlxG.play(sound);
			}
			
		}
		
		public function getCurrNode() :DialogNode
		{
			return currNode;
		}
		
		public function showDialogHandler(currLevel: FlxGroup):void
		{
			var cameraScroll:FlxPoint = FlxG.camera.scroll;
		
			continueText.alpha = 0;
			currLevel.add(this);
			
			head.x = 10+cameraScroll.x;
			head.y= 170+cameraScroll.y;
			
			headBackground.x = cameraScroll.x;
			headBackground.y = cameraScroll.y+160;
			
			textBackground.x = cameraScroll.x+80;
			textBackground.y= cameraScroll.y+160;
			
			
			//continueText = new FlxSprite(-240,214,Assets.CONTINUE_TEXT);
			continueText.x = cameraScroll.x+140;
			continueText.y = cameraScroll.y+225;
			continueText.alpha = 0;
			alphaCounter = 0;
		}
		
		public function hideDialogHandler(currLevel: FlxGroup):void
		{
			
		
			currLevel.remove(this);
		}
		
		
		//Return true if we're done
		public function displayDialogHandler(cameraScroll: FlxPoint, inventory:Inventory, player:Player):int
		{
		
			var toReturn:int = KEEP_GOING;

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
			
			
			alphaCounter+=FlxG.elapsed;
			
			if(alphaCounter>2)
			{
				continueText.alpha = Math.cos(alphaCounter*2);
			}
			
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
				else
				{
					//TESTING for "click through"
					dialogText.text = currNode.getTextToDisplay();
					stringIndex = currNode.getTextToDisplay().length;
				}	
			}
			
			return toReturn;
			
		}
		
		public function getAfterEnd(): uint
		{
			return currNode.getAfterEnd();
		}
		
		public function getConversationEnd():Boolean
		{
			return currNode.getEndOfConversation();
		}
		
		public function getConversation(): uint
		{
			return currNode.getConversation();
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