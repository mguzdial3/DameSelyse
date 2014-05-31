package  {
	
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import org.flixel.*;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	
	public class IntroState extends FlxState {
		[Embed(source="assets/FontsToCheck/redAlertNet.otf", fontName="testfontname", fontFamily="testfontfamily", embedAsCFF= "false")]private static var RedAlertFont:Class;

		[Embed(source="/assets/slide0.swf", mimeType="application/octet-stream")]private static var Slide0:Class;																		
		[Embed(source="/assets/Slide1.swf", mimeType="application/octet-stream")]private static var Slide1:Class;
		[Embed(source="/assets/Slide2.swf", mimeType="application/octet-stream")]private static var Slide2:Class;
		[Embed(source="/assets/Slide3.swf", mimeType="application/octet-stream")]private static var Slide3:Class;
		[Embed(source="/assets/slide4.swf", mimeType="application/octet-stream")]private static var Slide4:Class;
		[Embed(source="/assets/Slide5.swf", mimeType="application/octet-stream")]private static var Slide5:Class;
		[Embed(source="/assets/Slide6.swf", mimeType="application/octet-stream")]private static var Slide6:Class;
		[Embed(source="/assets/Slide7.swf", mimeType="application/octet-stream")]private static var Slide7:Class;
		private var framesArray:Array =  new Array(80, 220, 250,250, 220, 330, 300, 220); //Frames 
		private var zoomFactor:int = 1;
		private var movie:Loader;
		private var currScreen:int=0;
		//go to 130 for slide 3
		private var introText:FlxText;
		
		private var slideFrame:int = 0;
		private var currIndex:int= 0;
		
		//STRING ARRAYS
		private var slide1Text:Array = new Array("Long ago in the land of Ecta, a clan of walruses arrived", 
		"riding a great glacier, and bringing cooling water and life to the desert.");


		private var slide2Text:Array = new Array("But with each generation the clan grew smaller and smaller.",
		"Its remaining members grew more and more powerful,", 
		"for only they controlled the water.");
		
		private var slide3Text:Array = new Array(
		"These days there's only one Walrus in Ecta, the self appointed \"Walrus King\"", 
		"and he’s keeping all the water for himself, the royal jerk." );
		
		private var slide4Text:Array = new Array(
		"Without the Walrus King’s water, my land and its people are dying." );
		
		private var slide5Text:Array = new Array(
		"The Queen sent me, Dame Celeste, her chief engineer,", 
		"to reason with him about the water’s importance.", 
		"Unfortunately, the crazy fool fell tail over tusks for me!");
		
		private var slide6Text:Array = new Array(
		"Not paying attention to my arguments,",
		"and claiming I'd \"friendzoned\" him (whatever that means)",
		"he locked me in his dungeon.",
		"He also made me wear this dress. The creep.");
		
		private var slide7Text:Array = new Array(
		"Happily, the lovestruck fool forgot to take away my blueprints.", 
		"I was able to make use of the castle’s oversized pipes to get out of my cell...");
		
		

		private var myText:TextField;
		
		private var lc:LoaderContext;		

		
		override public function create():void {
		
		
			FlxG.mouse.hide();
		
			movie = new Loader();
			lc = new LoaderContext(false, ApplicationDomain.currentDomain);
			movie.loadBytes(new Slide0(), lc);
			
			FlxG.bgColor = 0xff000000;
			movie.contentLoaderInfo.addEventListener(Event.COMPLETE, contentsRetrieve);
			
			var dungeonMusic: FlxSound = new FlxSound;
			dungeonMusic.loadEmbedded(Assets.SANCTUM_SONG,true);
			FlxG.music = (dungeonMusic);
			
			FlxG.music.volume = 0.6; //Was 0.6 at first
			
			
			FlxG.music.play();
			
			
			var myFont:Font = new RedAlertFont();
			Font.registerFont(RedAlertFont);
			var fmt:TextFormat = new TextFormat();
			fmt.align = TextFormatAlign.CENTER;
			fmt.color = 0xFFFFFFFF;
			fmt.size = 20;
			fmt.font = myFont.fontName;
			
			myText= new TextField(); 
			myText.x = 0;
			myText.y = 445;
			myText.width = 640;
			//myText.defaultTextFormat = fmt;
			//myText.embedFonts = true;
        	//myText.border = true;
			//myText.wordWrap = true;
			
			myText.embedFonts = true;
			
			//myText.autoSize = TextFieldAutoSize.CENTER;
			myText.selectable = false;
			myText.wordWrap =  true;
			myText.defaultTextFormat = fmt;
			myText.text =""; 
			
		}
		
		
		private function moveToNext(): void
		{
			currScreen++;
			
			if(currScreen<framesArray.length)
			{
				slideFrame=0;
				
				myText.text= "";
				/**
				var square:Sprite = new Sprite();
				FlxG.stage.addChild(square);
				square.graphics.lineStyle(0,0x000000);
				square.graphics.beginFill(0x000000);
				square.graphics.drawRect(0,445,640,100);
				square.graphics.endFill();
				*/
				
				FlxG.stage.removeChildAt(1);
				
				
				movie.removeEventListener(Event.EXIT_FRAME, next);
				movie.unload();
				
				currIndex=0;
				movie = new Loader();
				var lc:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
				
				if(currScreen==1)
				{
					movie.loadBytes(new Slide1(), lc);
					myText.text =slide1Text[currIndex]; 
				}
				else if(currScreen==2)
				{
					movie.loadBytes(new Slide2(), lc);
					myText.text =slide2Text[currIndex]; 
				}
				else if(currScreen==3)
				{
					movie.loadBytes(new Slide3(), lc);
					myText.text =slide3Text[currIndex]; 
				}
				else if(currScreen==4)
				{
					movie.loadBytes(new Slide4(), lc);
					myText.text =slide4Text[currIndex]; 
				}
				else if(currScreen==5)
				{
					movie.loadBytes(new Slide5(), lc);
					myText.text =slide5Text[currIndex]; 
				}
				else if(currScreen==6)
				{
					movie.loadBytes(new Slide6(), lc);
					myText.text =slide6Text[currIndex]; 
				}
				else if(currScreen==7)
				{
					movie.loadBytes(new Slide7(), lc);
					myText.text =slide7Text[currIndex]; 
				}
				
				
				FlxG.bgColor = 0xff000000;
				movie.contentLoaderInfo.addEventListener(Event.COMPLETE, contentsRetrieve);
				
		
			
			}
			else
			{	
				transferToGame();
			}
		}
		
		private function contentsRetrieve(e:Event):void {
			FlxG.flashFramerate = 24;
			//movie.scaleX = 1.3 / zoomFactor;
			//movie.scaleY = 1.3 / zoomFactor;
			
			FlxG.stage.addChildAt(movie, 1);
			movie.addEventListener(Event.EXIT_FRAME, next);
			
			
			
			FlxG.stage.addChildAt(myText,2);
			
			
		}
		
		private function transferToGame():void
		{
			//FlxG.stage.removeChildAt(1);
			FlxG.stage.removeChildAt(2);
			myText=null;
			SoundMixer.stopAll();
			movie.removeEventListener(Event.EXIT_FRAME, next);
			movie.unload();
			FlxG.flashFramerate = 60;
			//FlxG.framerate = 60;
			FlxG.bgColor = 0xff000000;
			FlxG.flashFramerate = 60;
			FlxG.switchState( new GameState());
		}
		
		private function next(e:Event):void {
			slideFrame++;
			
			if(currScreen>=framesArray.length)
			{
				transferToGame();
			}
			else if (framesArray[currScreen] <=slideFrame) {
				moveToNext();
				
			}
			
		}
		
		
		
		
		override public function update():void {
		
		
			
			if(currScreen==1)
			{
				if(slideFrame>(currIndex+1)*(framesArray[currScreen]/slide1Text.length))
				{
					currIndex++;
					myText.text =slide1Text[currIndex]; 
				}
			}
			else if(currScreen==2)
			{
				if(slideFrame>(currIndex+1)*(framesArray[currScreen]/slide2Text.length))
				{
					currIndex++;
					myText.text =slide2Text[currIndex]; 
				}
			}
			else if(currScreen==3)
			{
				if(slideFrame>(currIndex+1)*(framesArray[currScreen]/slide3Text.length))
				{
					currIndex++;
					myText.text =slide3Text[currIndex]; 
				} 
			}
			else if(currScreen==4)
			{
				if(slideFrame>(currIndex+1)*(framesArray[currScreen]/slide4Text.length))
				{
					currIndex++;
					myText.text =slide4Text[currIndex]; 
				}
			}
			else if(currScreen==5)
			{
				if(slideFrame>(currIndex+1)*(framesArray[currScreen]/slide5Text.length))
				{
					currIndex++;
					myText.text =slide5Text[currIndex]; 
				} 
			}
			else if(currScreen==6)
			{
				if(slideFrame>(currIndex+1)*(framesArray[currScreen]/slide6Text.length))
				{
					currIndex++;
					myText.text =slide6Text[currIndex]; 
				} 
			}
			else if(currScreen==7)
			{
				if(slideFrame>(currIndex+1)*(framesArray[currScreen]/slide7Text.length))
				{
					currIndex++;
					myText.text =slide7Text[currIndex]; 
				}
			}
		
			
			
			if(FlxG.keys.justReleased("SPACE"))
			{
			
				
				//Here
				if(currScreen==0)
				{
					moveToNext();
				}
				else if(currScreen==1)
				{
					if(slideFrame>(currIndex+1)*10)
					{
					
						currIndex++;
						if(currIndex<slide1Text.length)
						{
							myText.text =slide1Text[currIndex]; 
						}
						else
						{
							if(slideFrame>framesArray[currScreen]/5)
							{
								moveToNext();
							}
						}
					}
				}
				else if(currScreen==2)
				{
					if(slideFrame>(currIndex+1)*10)
					{
					
						currIndex++;
						if(currIndex<slide2Text.length)
						{
							myText.text =slide2Text[currIndex]; 
						}
						else
						{
							if(slideFrame>framesArray[currScreen]/5)
							{
								moveToNext();
							}
						}
					}
				}
				else if(currScreen==3)
				{
					if(slideFrame>(currIndex+1)*10)
					{
					
						currIndex++;
						if(currIndex<slide3Text.length)
						{
							myText.text =slide3Text[currIndex]; 
						}
						else
						{
							if(slideFrame>framesArray[currScreen]/5)
							{
								moveToNext();
							}
						}
					}
				}
				else if(currScreen==4)
				{
					if(slideFrame>(currIndex+1)*10)
					{
					
						currIndex++;
						if(currIndex<slide4Text.length)
						{
							myText.text =slide4Text[currIndex]; 
						}
						else
						{
							if(slideFrame>framesArray[currScreen]/5)
							{
								moveToNext();
							}
						}
					}
				}
				else if(currScreen==5)
				{
					if(slideFrame>(currIndex+1)*10)
					{
					
						currIndex++;
						if(currIndex<slide5Text.length)
						{
							myText.text =slide5Text[currIndex]; 
						}
						else
						{
							if(slideFrame>framesArray[currScreen]/5)
							{
								moveToNext();
							}
						}
					}
				}
				else if(currScreen==6)
				{
					if(slideFrame>(currIndex+1)*10)
					{
					
						currIndex++;
						if(currIndex<slide6Text.length)
						{
							myText.text =slide6Text[currIndex]; 
						}
						else
						{
							if(slideFrame>framesArray[currScreen]/5)
							{
								moveToNext();
							}
						}
					} 
				}
				else if(currScreen==7)
				{
					if(slideFrame>(currIndex+1)*10)
					{
					
						currIndex++;
						if(currIndex<slide7Text.length)
						{
							myText.text =slide7Text[currIndex]; 
						}
						else
						{
							if(slideFrame>framesArray[currScreen]/5)
							{
								transferToGame();
							}
						}
					}
				}
				else
				{
					moveToNext();
				}
			}
			
			
			
		}
	}
}
