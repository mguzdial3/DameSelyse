package  {
	
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import org.flixel.*;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	
	public class IntroState extends FlxState {
																				
		
		[Embed(source="/assets/DameCelesteOpening.swf", mimeType="application/octet-stream")]private static var SPONSOR:Class;
		private var len:Number = 860; //Frames
		private var zoomFactor:int = 1;
		private var movie:Loader;
		
		override public function create():void {
		
			FlxG.mouse.hide();
			movie = new Loader();
			var lc:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			movie.loadBytes(new SPONSOR(), lc);
			FlxG.bgColor = 0xffffffff;
			movie.contentLoaderInfo.addEventListener(Event.COMPLETE, contentsRetrieve);
		}
		
		private function contentsRetrieve(e:Event):void {
			FlxG.flashFramerate = 11;
			movie.scaleX = 1.3 / zoomFactor;
			movie.scaleY = 1.3 / zoomFactor;
			
			FlxG.stage.addChildAt(movie, 1);
			movie.addEventListener(Event.EXIT_FRAME, next);
		}
		
		private function next(e:Event):void {
			len--;
			if (len <= 0) {
				FlxG.stage.removeChildAt(1);
				SoundMixer.stopAll();
				movie.removeEventListener(Event.EXIT_FRAME, next);
				movie.unload();
				len = 10;
				FlxG.flashFramerate = 11;
				FlxG.bgColor = 0xff000000;
				
				FlxG.switchState( new GameState());
				
			}
		}
		
		
		
		
		private var clicked:Boolean = false;
		override public function update():void {
		
			if (FlxG.mouse.justPressed() && !clicked) {
				clicked=true;
				FlxG.stage.removeChildAt(1);
				SoundMixer.stopAll();
				movie.removeEventListener(Event.EXIT_FRAME, next);
				movie.unload();
				FlxG.flashFramerate = 60;
				FlxG.bgColor = 0xff000000;
			}
			
			if(clicked)
			{
				
				FlxG.switchState( new GameState());
			}
			
		}
	}
}