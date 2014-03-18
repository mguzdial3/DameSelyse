package
{
	import org.flixel.*;
	
	public class MainMenuState extends FlxState
	{
	
		private var startButton: FlxButton;
	
		override public function create():void 
		{
			
			var mainMenu: FlxSprite = new FlxSprite(0,0,Assets.MAIN_MENU);
			add(mainMenu);
			
			startButton = new FlxButton(100,200,Assets.START_BUTTON, startButtonPress);
			
			
			
			add(startButton);
			
			FlxG.mouse.show();
		}
		
		private function startButtonPress(): void
		{
			FlxG.switchState( new IntroState());
		}
		
		
		
	}
}