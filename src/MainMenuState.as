package
{
	import org.flixel.*;
	
	public class MainMenuState extends FlxState
	{
	
		private var startButton: FlxButton;
		private var clicked: Boolean;
		override public function create():void 
		{
			super.create();
			
			FlxG.flashFramerate = 60; //60 before
			//FlxG.framerate = 60; //Try getting rid of
			
			var dungeonMusic: FlxSound = new FlxSound;
			dungeonMusic.loadEmbedded(Assets.MENU_SONG,true);
			FlxG.music = (dungeonMusic);
			FlxG.music.volume = 0.6; //Was 0.6 at first
			FlxG.music.play();
			
			var mainMenu: FlxSprite = new FlxSprite(0,0,Assets.MAIN_MENU);
			//mainMenu.scale = new FlxPoint(0.5,0.5);
			mainMenu.antialiasing = true;
			add(mainMenu);
			
			
			var saveStuff:FlxSave = new FlxSave();
			
			var guiCam:FlxCamera = new FlxCamera(0, 0, FlxG.width*2, FlxG.height*2, 1);
			//guiCam.screen = mainMenu;
			mainMenu.cameras = new Array(guiCam);
			FlxG.addCamera(guiCam);
			
			
			var regCam:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height, 2);
			regCam.bgColor = 0x00000000;
			FlxG.addCamera(regCam);
			
			var _loaded: Boolean = saveStuff.bind(GameState.saveString);
			
			if(!_loaded || saveStuff.data.levelName==null)
			{
				startButton = new FlxButton(37,142,Assets.START_BUTTON, startButtonPress, Assets.START_BUTTON_HIGHLIGHT);
				add(startButton);
				startButton.cameras = new Array(regCam, FlxG.camera);
			}
			else
			{
				var continueButton:FlxButton = new FlxButton(37,142,Assets.CONTINUE_BUTTON, continueSansIntroduction, Assets.CONTINUE_BUTTON_HIGHLIGHT);
				add(continueButton);
				
				var newGameButton:FlxButton = new FlxButton(37,199,Assets.NEW_GAME_BUTTON, startButtonPress, Assets.NEW_GAME_BUTTON_HIGHLIGHT);
				add(newGameButton);
				
				continueButton.cameras = new Array(regCam, FlxG.camera);
				newGameButton.cameras = new Array(regCam, FlxG.camera);
			}
			
			
			
			
			
			FlxG.mouse.show();
		}
		
		private function startButtonPress(): void
		{
			
			FlxG.resetCameras();
			
			GameState.clearAllLevelData();
			
			var saveStuff:FlxSave = new FlxSave();
			var _loaded: Boolean = saveStuff.bind(GameState.saveString);
			saveStuff.erase();
			
			//Remove all save stuff
			var levelNameArray: Array = new Array("Dungeon", "Kitchen", "Ballroom", "Sanctum", "Brain");
			var i:int = 0; 
			
			for(i=0; i<levelNameArray.length; i++)
			{
				var saver:FlxSave = new FlxSave();
				saver.bind("levelData"+levelNameArray[i]);
				saver.erase();
			}
			
			
			
			FlxG.switchState( new IntroState());
		}
		
		
		
		
		
		private function continueSansIntroduction(): void
		{
			
			clicked=true;
			
			FlxG.resetCameras();
			//FlxG.switchState( new TestState());
			FlxG.switchState( new GameState());
		}
		
		
		override public function update():void {
			super.update();
			
				//FlxG.flashFramerate = 60;
				//this.clear();
				//FlxG.switchState( new GameState());
			
			
			
		}
		
	}
}