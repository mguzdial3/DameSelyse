package
{
	import org.flixel.*;
	//import tutorial.*;

	[SWF(width="480", height="480", backgroundColor="#ffffff")]
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame
	{
		/**
		 * Constructor
		 */
		public function Main() {
			super(240, 240, GameState, 2);
		}
	}
}
