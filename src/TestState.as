package
{
	import org.flixel.*;
	
	public class TestState extends FlxState
	{
	
		override public function create():void 
		{
			super.create();
			
			var printText2:FlxText =new FlxText(20, 40, 300, "Print");
			printText2.alignment = "right";
			printText2.scrollFactor = new FlxPoint(0, 0);
			printText2.text = "TEST";
			printText2.color = 0xff000000;
			
			add(printText2);
			
		}
		
		
		override public function update():void {
			super.update();
			
				FlxG.flashFramerate = 60;
				//this.clear();
				FlxG.switchState( new GameState());
			
			
			
		}
		
	}
}