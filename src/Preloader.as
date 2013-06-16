package
{
	import org.flixel.system.FlxPreloader;

	public class Preloader extends FlxPreloader
	{
		/**
		 * Constructor
		 */
		public function Preloader():void {
			//Reference to Main.as 
			className = "Main";
			super();
		}
	}
}
