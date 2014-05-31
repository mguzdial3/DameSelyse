package
{
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
	
		/**
		 * Current level
		 * NOTE: "public static" allows us to get info about the level from other classes
		 * if we wanna do that at some point
		 */
		public static var LEVEL:TopDownLevel = null;
		public static var NEXT_LEVEL:TopDownLevel = null;
		
		
			private var waterMax: uint = 10;
		
		protected static var WATER:Array = new Array( 
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0
		);
		
		 private var baseWater: FlxTilemap;
	
		private var count:int;
		private var MAX_COUNT:int=1200;
		private var currCount:int = 0;
		
		private var minRatio:Number=0.1; //Less than 10%
		
		/**
		 * Create state
		 */
		 
		private var saveStuff: FlxSave;
		 
		private var counter:uint;
		
		private var fpsCounter:uint =1;
		 
	 	private var firstTime: Boolean = false;
		
		
		private var currAnimState: uint=0;
		private var WAITING:uint=0;
		private var SADNESS:uint = 1;
		private var HAPPINESS:uint = 2;
		
		protected var audience: Vector.<FlxSprite>;
		 
		 
		private var stringComplete: String = "Level Complete!"
		private var stringDroplets:String;
		private var stringCaught:String;
		private var stringConversations:String;
		private var stringLevelTime: String;
		
		private var levelComplete: FlxText;
		private var dropletsText:FlxText;
		private var caughtText:FlxText;
		private var conversationsText:FlxText;
		private var levelTimeText:FlxText;
		 
		private var addTextTimer:Number=0;
		private var addTextTimerMax:Number = 0.05;
		
		private var stateTimer:Number = 0;
		private var startText:Number = 1;
		
		private var gameplay:Boolean = true; 
		
		public static var saveString:String = "LEVEL_ON_DATA";
		 
		private static var levelNames: Array = new Array("Dungeon", "Kitchen", "Ballroom", "Sanctum", "Brain");
		 
		override public function create():void 
		{
			
			super.create();
			
			//LEVEL = new celeste1Fin1(new FlxPoint(4992, 3392),new FlxPoint(16, 16));
			
			
			saveStuff = new FlxSave();
			
			var _loaded: Boolean = saveStuff.bind(saveString);
			
			
			//saveStuff.erase();
			/**
			if(!_loaded)
			{
				LEVEL = new celeste1Fin1(new FlxPoint(4992, 3392),new FlxPoint(16, 16));
			}
			else
			{
				if(saveStuff.data.levelName==null)
				{
					saveStuff.data.levelName="Dungeon";
					LEVEL = new celeste1Fin1(new FlxPoint(4992, 3392),new FlxPoint(16, 16));
				}
				else
				{
					//Load level based on levelName
					if(saveStuff.data.levelName=="Dungeon")
					{
						//trace("Hit dungeon");
						LEVEL = new celeste1Fin1(new FlxPoint(4992, 3392),new FlxPoint(16, 16));
					}
					else if(saveStuff.data.levelName=="Kitchen")
					{
						//trace("Hit kitchen");
						LEVEL = new celeste2Fin3(new FlxPoint(5216, 3488),new FlxPoint(16, 16));	
					}
					else if(saveStuff.data.levelName=="Ballroom")
					{
						//trace("Hit ballroom");
						LEVEL = new celeste3Fin(new FlxPoint(3616, 5856),new FlxPoint(16, 16));	
					}
					else if(saveStuff.data.levelName=="Sanctum")
					{
						//trace("Hit sanctum");
						LEVEL = new celeste4Real(new FlxPoint(5792, 4128),new FlxPoint(16, 16));
					}
					else if(saveStuff.data.levelName=="Brain")
					{
						//trace("Hit brain");
						LEVEL = new celeste5Real2(new FlxPoint(5792, 4128),new FlxPoint(16, 16));
					}
					
				}
			}
			*/

			//LEVEL = new celeste2Fin3(new FlxPoint(5216, 3488),new FlxPoint(16, 16));	
			LEVEL = new celeste3Fin(new FlxPoint(3616, 5856),new FlxPoint(16, 16));
			//Testing purposes 
			//
			//LEVEL =  new celeste5Real2(new FlxPoint(5792, 4128),new FlxPoint(16, 16));
			//new celeste5Real(new FlxPoint(6720, 4192),new FlxPoint(16, 16));//new celeste4Real(new FlxPoint(5792, 4128),new FlxPoint(16, 16));
			//new celeste4Real(new FlxPoint(5792, 4128),new FlxPoint(16, 16));//new celeste4Fin(new FlxPoint(5792, 4128),new FlxPoint(16, 16));
			//LEVEL = new celeste3Fin(new FlxPoint(3616, 5856),new FlxPoint(16, 16));	
			this.add(LEVEL);
			
		}
		
		public static function clearAllLevelData():void
		{
			var i:int = 0;
			
			for(i = 0; i<levelNames.length; i++)
			{
				var levelSave:FlxSave = new FlxSave();
				
				levelSave.bind("levelData"+levelNames[i]);
				
				levelSave.erase();
			}
		}
		
		public function setUpLevelEnd():void 
		{
		
		
			if(FlxG.music!=null)
			{
				FlxG.music.stop();
				FlxG.music.destroy();
			}
		
			//MUSIC
			var introMusic:FlxSound = new FlxSound();
			introMusic.loadEmbedded(Assets.MENU_SONG, true);
			
			FlxG.music=introMusic;
			FlxG.music.volume = 0.6;
			FlxG.music.play();
		
			count = 0;
		
			var menuBackground:FlxSprite = new FlxSprite(0,0, Assets.SCREEN_BELOW);
			menuBackground.scrollFactor = new FlxPoint(0, 0);
			add(menuBackground);
			
			
			
			baseWater = new FlxTilemap();
			baseWater.loadMap(
				FlxTilemap.arrayToCSV(WATER, 48),
				Assets.WATER_TILES, 1, 1, 0, 0, 0, uint.MAX_VALUE
			);
			
			baseWater.x=224;
			baseWater.y = 36;
			baseWater.scrollFactor = new FlxPoint(0, 0);
			add(baseWater);
			
			var menuBackground2:FlxSprite = new FlxSprite(0,0, Assets.SCREEN_ABOVE);
			menuBackground2.scrollFactor = new FlxPoint(0, 0);
			add(menuBackground2);
			
			
			audience = new Vector.<FlxSprite>();
			
			
			var currentLevel:String = LEVEL.getLevelName();
			
			var levelNamesArray:Array = new Array("Dungeon", "Kitchen", "Ballroom", "Sanctum");
			
			var i:int=0;
			var levelAt:int = 0;
			for(i=0; i<levelNamesArray.length; i++)
			{
				if(currentLevel==levelNamesArray[i])
				{
					levelAt=i;
				}
			}
			
			
			//GOAT
			var audienceSprite:FlxSprite = new FlxSprite(280,49-18);
				audienceSprite.loadGraphic(
				Assets.GOAT_SPRITE, // image to use
				true, // animated
				false, // do generate "flipped" images since they're not already in the image
				18, // width of each frame (in pixels)
				18 // height of each frame (in pixels)
				);
			
			audienceSprite.addAnimation("idle", [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,6],30, true);
			audienceSprite.addAnimation("celebrate", [0,1,2,3,4,3,2,1],10, true);
			audienceSprite.addAnimation("sadness", [7,7,7,8,8,8,9,9,9,10,10],10, true);
			audienceSprite.play("idle");
			audienceSprite.scrollFactor = new FlxPoint(0, 0);
			add(audienceSprite);
			audience.push(audienceSprite);
			
			//RABBIT
			var audienceSprite2:FlxSprite = new FlxSprite(280+14,49-18);
				audienceSprite2.loadGraphic(
				Assets.RABBIT_SPRITE, // image to use
				true, // animated
				false, // do generate "flipped" images since they're not already in the image
				16, // width of each frame (in pixels)
				18 // height of each frame (in pixels)
				);
			
			audienceSprite2.addAnimation("idle", [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4],10, true);
			audienceSprite2.addAnimation("celebrate", [0,0,0,0,0,1,1,1,1,0,0,0,0,2,2,2,2],10, true);
			audienceSprite2.addAnimation("sadness", [5,5,5,6,6,6,7,7,7,8,8,8],10, true);
			audienceSprite2.play("idle");
			audienceSprite2.scrollFactor = new FlxPoint(0, 0);
			add(audienceSprite2);
			audience.push(audienceSprite2);
			
			//TURTLE
			var audienceSprite3:FlxSprite = new FlxSprite(280+8,49-16);
				audienceSprite3.loadGraphic(
				Assets.TURTLE_SPRITE, // image to use
				true, // animated
				false, // do generate "flipped" images since they're not already in the image
				13, // width of each frame (in pixels)
				16 // height of each frame (in pixels)
				);
			
			audienceSprite3.addAnimation("idle", [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,6],10, true);
			audienceSprite3.addAnimation("celebrate", [0,0,0,1,1,2,2,3,4,3,2,2,1,2,0,0,0,0,0],10, true);
			audienceSprite3.addAnimation("sadness", [7],10, false);
			audienceSprite3.play("idle");
			audienceSprite3.scrollFactor = new FlxPoint(0, 0);
			add(audienceSprite3);
			audience.push(audienceSprite3);
			
			//colors
			var colorsArray:Array = new Array(0xFFFFFAFA, 0xFFFAFFFF, 0xFFF9F9F9, 0xFFFCFCFC);
			
			//TESTING
			//levelAt = 4;
			
			if(levelAt>0)
			{
				for(i=0; i<levelAt; i++)
				{
					var currType:int = int(Math.random()*2);
					
					var currX:Number = 288+(i*8)+(12*Math.random())+4;
					
					if(currType==0)
					{
						//RABBIT
						audienceSprite2 = new FlxSprite(currX,49-18);
							audienceSprite2.loadGraphic(
							Assets.RABBIT_SPRITE, // image to use
							true, // animated
							false, // do generate "flipped" images since they're not already in the image
							16, // width of each frame (in pixels)
							18 // height of each frame (in pixels)
							);
			
						audienceSprite2.addAnimation("idle", [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4],10, true);
						audienceSprite2.addAnimation("celebrate", [0,0,0,0,0,1,1,1,1,0,0,0,0,2,2,2,2],10, true);
						audienceSprite2.addAnimation("sadness", [5,5,5,6,6,6,7,7,7,8,8,8],10, true);
						audienceSprite2.play("idle");
						audienceSprite2.scrollFactor = new FlxPoint(0, 0);
						audienceSprite2.color = colorsArray[int(Math.random()*4)];
						add(audienceSprite2);
						audience.push(audienceSprite2);
					
					}
					else if(currType==1)
					{
						//TURTLE
						audienceSprite3 = new FlxSprite(currX,49-16);
							audienceSprite3.loadGraphic(
							Assets.TURTLE_SPRITE, // image to use
							true, // animated
							false, // do generate "flipped" images since they're not already in the image
							13, // width of each frame (in pixels)
							16 // height of each frame (in pixels)
							);
			
						audienceSprite3.addAnimation("idle", [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,6],10, true);
						audienceSprite3.addAnimation("celebrate", [0,0,0,1,1,2,2,3,4,3,2,2,1,2,0,0,0,0,0],10, true);
						audienceSprite3.addAnimation("sadness", [7],10, false);
						audienceSprite3.play("idle");
						audienceSprite3.scrollFactor = new FlxPoint(0, 0);
						audienceSprite3.color = colorsArray[int(Math.random()*4)];
						add(audienceSprite3);
						audience.push(audienceSprite3);
					
					}
				}
			}
			
			
			//TEXT STUFF
			
			var waterTextColor:uint = 0x557DB8FF;
			
			//Text stuff
			levelComplete =new FlxText(1, 6, 300, "");
			levelComplete.size= 16;
			levelComplete.color = waterTextColor;
			
			levelComplete.scrollFactor = new FlxPoint(0, 0);
			add(levelComplete);
			
			var totalDropletsMax:int = LEVEL.getMaxDropletsCollected();
			var totalDropletsCollected:int = LEVEL.getWaterDropletsCollected();
			stringDroplets = "Water Droplets Collected: "+totalDropletsCollected+"/"+totalDropletsMax;
			dropletsText =new FlxText(9, 61, 132, "");
			dropletsText.color = waterTextColor;
			dropletsText.scrollFactor = new FlxPoint(0, 0);
			add(dropletsText);
			
			var timesCaught:int = LEVEL.timesCaught();
			stringCaught = "Times Caught: "+timesCaught;
			caughtText =new FlxText(9, 91, 79, "");
			caughtText.color = waterTextColor;
			caughtText.scrollFactor = new FlxPoint(0, 0);
			add(caughtText);
			
			var conversationsHad:int = LEVEL.conversationsHad();
			stringConversations = "Conversations Had: "+conversationsHad;
			conversationsText =new FlxText(9, 121, 102, "");
			conversationsText.color = waterTextColor;
			conversationsText.scrollFactor = new FlxPoint(0, 0);
			add(conversationsText);
			
			var timeItTook:int = LEVEL.levelCompleteTime();
			stringLevelTime = "Level Completion Time: "+timeItTook+" mins";
			levelTimeText =new FlxText(9, 151, 124, "");
			levelTimeText.color = waterTextColor;
			levelTimeText.scrollFactor = new FlxPoint(0, 0);
			add(levelTimeText);
			
			//Set up the current count
			currCount = int((Number(totalDropletsCollected)/Number(totalDropletsMax))*Number(MAX_COUNT));
		}
		
		public function displayLevelEnd(): void
		{
			//TEXT STUFF
			if(stateTimer<startText)
			{
				stateTimer+=FlxG.elapsed;
			}
			else
			{
				if(levelComplete.text.length<stringComplete.length)
				{
					if(addTextTimer>=addTextTimerMax)
					{
						addTextTimer = 0;
						levelComplete.text+= stringComplete.charAt(levelComplete.text.length);
					}
					else
					{
						addTextTimer+=FlxG.elapsed;
					}
				
				}
				else if(dropletsText.text.length<stringDroplets.length)
				{
					if(addTextTimer>=addTextTimerMax)
					{
						addTextTimer = 0;
						dropletsText.text+= stringDroplets.charAt(dropletsText.text.length);
					}
					else
					{
						addTextTimer+=FlxG.elapsed;
					}
				
				}
				else if(caughtText.text.length<stringCaught.length)
				{
					if(addTextTimer>=addTextTimerMax)
					{
						addTextTimer = 0;
						caughtText.text+= stringCaught.charAt(caughtText.text.length);
					}
					else
					{
						addTextTimer+=FlxG.elapsed;
					}
				
				}
				else if(conversationsText.text.length<stringConversations.length)
				{
					if(addTextTimer>=addTextTimerMax)
					{
						addTextTimer = 0;
						conversationsText.text+= stringConversations.charAt(conversationsText.text.length);
					}
					else
					{
						addTextTimer+=FlxG.elapsed;
					}
				
				}
				else if(levelTimeText.text.length<stringLevelTime.length)
				{
					if(addTextTimer>=addTextTimerMax)
					{
						addTextTimer = 0;
						levelTimeText.text+= stringLevelTime.charAt(levelTimeText.text.length);
						
						
						if(levelTimeText.text.length>=stringLevelTime.length)
						{
							//The end
							var continueButton:FlxButton = new FlxButton(40,192,Assets.CONTINUE_BUTTON, startNextLevel, Assets.CONTINUE_BUTTON_HIGHLIGHT);
							continueButton.scrollFactor = new FlxPoint(0, 0);
							add(continueButton);
							var saveButton:FlxButton = new FlxButton(148,192,Assets.SAVE_BUTTON, returnToMainMenu, Assets.SAVE_BUTTON_HIGHLIGHT);
							saveButton.scrollFactor = new FlxPoint(0, 0);
							add(saveButton);
							
							FlxG.mouse.show();
						}
						
					}
					else
					{
						addTextTimer+=FlxG.elapsed;
					}
				
				}
			
			}
			
			if(count<currCount)
			{
				var x:int;
				var y:int;
				for(x=0; x<10; x++)
				{
					for(y=0; y<9; y++)
					{ 
						//Perf with 3 loops
						baseWater.setTile(x,0,uint(Math.random()*3+7));
						
						
					}
				}
				count++;
				
				var u:int = 0;
				if(count>=currCount)
				{
					for(u=0; u<audience.length; u++)
					{ 
						var currRatio:Number = Number(currCount)/Number(MAX_COUNT);
					
						if(currRatio>minRatio)
						{
							audience[u].play("celebrate");
						}
						else
						{
							audience[u].play("sadness");
						}
					}
				}
				
			}
			
			var i:int;
			
			for(i = 0; i<3; i++)
			{
				updateWater();
			}
		}
		
		
		
		//This is called once per frame. Like Update in Unity3D.
		
		override public function update(): void {
			super.update();

			
			
			
			if(gameplay)
			{
				
				//See if we should transfer the level
				NEXT_LEVEL= LEVEL.transferLevel();
			
				// If we've got a new level to transfer to, let's get rid of the old one and 
				// add the new one
				
				if(NEXT_LEVEL!=null && NEXT_LEVEL.getLevelName()!=LEVEL.getLevelName())
				{
					LEVEL.gameStateSave(); //Game State Save real fast
					
					saveStuff.data.levelName = NEXT_LEVEL.getLevelName();
					
					this.clear();
										
					gameplay= false;
					
					setUpLevelEnd();

				}
				else if(NEXT_LEVEL!=null)
				{
					saveStuff.data.levelName = NEXT_LEVEL.getLevelName();
				
					
				
					//startNextLevel();
					if(this!=null)
					{
						this.clear();
					}
					gameplay=true;
			
					LEVEL = NEXT_LEVEL;
					//FlxG.mouse.hide();
					this.add(LEVEL);
					LEVEL.startMusic();
				}
				
			}
			else
			{
			
				if(countLiving()==0)
				{
					setUpLevelEnd();
				}
			
				displayLevelEnd();
			}
			
			
		}
		
		
		public function startNextLevel():void
		{
			FlxG.mouse.hide();
			gameplay=true;
			if(NEXT_LEVEL!=null)
			{
			
				saveStuff.data.levelName =NEXT_LEVEL.getLevelName();
			}
			this.clear();
			FlxG.switchState(new GameState());
			
		}
		
		public function returnToMainMenu():void
		{
			
			this.clear();
			FlxG.switchState( new MainMenuState());
		}
		
		
			
		
		
		public function updateWater(): void
		{
			counter=0;
				var i:int;
				var j:int;
				
				for(i=0; i<baseWater.widthInTiles; i++)
				{
					for(j=baseWater.heightInTiles-1; j>=0; j--)
					{
						if(baseWater.getTile(i,j)>1) //Greater than one means not empty
						{
							
							//VERTICAL
						
							//If we can move down
							if((j+1)<baseWater.heightInTiles && baseWater.getTile(i,j+1)<waterMax
							&& baseWater.getTile(i,j+1)!=0)
							{
								
								var myAmnt:int = int(baseWater.getTile(i,j));
								var belowAmnt:int = int(baseWater.getTile(i,j+1));
								
								var amntToAdd:int = int(waterMax - belowAmnt);
								
								if((myAmnt)>amntToAdd)
								{
									myAmnt-=amntToAdd;
								}								
								else
								{
									amntToAdd = myAmnt-1; //one is the base
									myAmnt = 1;
								}
								
								//printText2.text = "At "+i+", "+j+": "+baseWater.getTile(i,j)
								//+" And At "+i+", "+(j+1)+": "+baseWater.getTile(i,(j+1));
								
								
								var newbelowAmnt:int =belowAmnt + amntToAdd;
								
								
								var yVal:int = new int(j);
								
								//baseWater.setTile((i),(yVal), (myAmnt));
								//baseWater.setTile((i),(yVal+1), (newbelowAmnt));
								
								baseWater.setTileByIndex((yVal)*baseWater.widthInTiles+i, (myAmnt));
								baseWater.setTileByIndex((yVal+1)*baseWater.widthInTiles+i, (newbelowAmnt));
								
								
								
							}
							
							//HORIZONTAL CHECKS
							
							/**
							//FIRST OFF: WHAT TO DO IF YOU'RE surrounded by water on either side 
							if(i+1<baseWater.widthInTiles && i-1>0
							&& baseWater.getTile(i+1,j)>1
							&& baseWater.getTile(i-1,j)>1)
							{
								var myAmnt4:int  = baseWater.getTile(i,j);
								var leftAmnt: int = baseWater.getTile(i-1,j);
								var rightAmnt: int = baseWater.getTile(i+1,j);
								
								//Spread out if you can't go down no more due to water density, or surface
								if(j+1>=baseWater.heightInTiles
									|| baseWater.getTile(i,j+1)==0
									|| baseWater.getTile(i,j+1)==waterMax)
								{
									
									//And if the water is different values
									if(myAmnt4!=leftAmnt || myAmnt4!=rightAmnt)
									{
										var total:int = myAmnt4+leftAmnt+rightAmnt;
										var split:int = total/3;
									
										var diff:int = (total)-(split*3);
									
										myAmnt4 = split;
										leftAmnt = split;
										rightAmnt = split;
										
										if(diff!=0)
										{
											if(diff==1)
											{
												myAmnt4+=1;
											}
											else
											{
												myAmnt4+=1;
												
												var chance:Number = Math.random();
												
												if(chance<0.5)
												{
													leftAmnt+=1;
												}
												else
												{
													rightAmnt+=1;
												}
											}
										}
										
									
									
									}
									//If they have the same values, do nothing
									
								}
								
								else
								{
								//We can move down more, so we should bunch up
									if(leftAmnt>myAmnt)
									{
										 var amntToAddL:int = int(waterMax - leftAmnt);
										 
										 if((myAmnt4)>amntToAddL)
										 {
										 	myAmnt4-=amntToAddL;
										 }
										 else
										 {
										 	amntToAddL = myAmnt4 - 1;
										 	myAmnt4 = 1;
										 }
										 
										 leftAmnt+=amntToAddL;
										 
									}
									else if(rightAmnt>myAmnt)
									{
										var amntToAddR:int = int(waterMax - rightAmnt);
										 
										 if((myAmnt4)>amntToAddR)
										 {
										 	myAmnt4-=amntToAddR;
										 }
										 else
										 {
										 	amntToAddR = myAmnt4 - 1;
										 	myAmnt4 = 1;
										 }
										 
										 rightAmnt+=amntToAddR;
									}
									
									else if(myAmnt>leftAmnt && myAmnt>rightAmnt)
									{
										var amntToAddM:int = int(waterMax-myAmnt);
										
										var halfAmnt:int = amntToAddM/2;
										
										//Should pull equally
										
										if((rightAmnt-1)<halfAmnt)
										{
											myAmnt4+=(rightAmnt-1);
											rightAmnt=1;
										}
										else
										{
											rightAmnt-=halfAmnt;
											myAmnt4+=halfAmnt;
										}
										
										if((leftAmnt-1)<halfAmnt)
										{
											myAmnt4+=(leftAmnt-1);
											leftAmnt=1;
										}
										else
										{
											leftAmnt-=halfAmnt;
											myAmnt4+=halfAmnt;
										}
										
										//Just one is not enough of a pull
										
									}
									else
									{
										//They are all the same, do nothing
									}
									
									
								}
								
								
								
								
								//Set the vals
								baseWater.setTile(i,j,myAmnt4);
								baseWater.setTile(i-1,j,leftAmnt);
								baseWater.setTile(i+1,j,rightAmnt);
								
									
							}
							//Check if there's air on the left but not the right
							else if(baseWater.getTile(i-1,j)==1
							&& baseWater.getTile(i+1,j)!=1)
							{
							
								var myAmnt3:int = baseWater.getTile(i,j);
								var leftAmnt3: int = baseWater.getTile(i-1,j);
								var rightAmnt3: int = baseWater.getTile(i+1,j);
								
								
								//If air below, get closer
								if(baseWater.getTile(i,j+1)==1)
								{
									if(rightAmnt3>myAmnt3)
									{
										diff = waterMax-rightAmnt3;
										
										if(myAmnt3>diff)
										{
											myAmnt3-=diff;
										}
										else
										{
											diff = myAmnt3-1;
											myAmnt3 = 1;
										}
										rightAmnt3+=diff;
										
									}
									else if(myAmnt3>rightAmnt3)
									{
										diff = waterMax-myAmnt3;
										
										if(rightAmnt3>diff)
										{
											rightAmnt3-=diff;
										}
										else
										{
											diff = rightAmnt3-1;
											rightAmnt3 = 1;
										}
										myAmnt3+=diff;
									}
								}
								else
								{
									//Should I involve all three?
									var origAmnt:int = myAmnt3;
									//Spread to the air if on firm ground
									var halfMyAmnt:int = myAmnt3/2;
									
									if(halfMyAmnt!=0)
									{
										myAmnt3 = halfMyAmnt;
										leftAmnt3 = halfMyAmnt;
									
										if(halfMyAmnt*2<origAmnt)
										{
											myAmnt3+=1;
										}
									}
									
								}
								
								baseWater.setTile(i,j,myAmnt3);
								baseWater.setTile(i-1,j,leftAmnt3);
								baseWater.setTile(i+1,j,rightAmnt3);
							}
							//Check if there's air on the right but not the left
							else if(baseWater.getTile(i+1,j)==1
							&& baseWater.getTile(i-1,j)!=1)
							{
								var myAmnt2:int  = baseWater.getTile(i,j);
								var leftAmnt2: int = baseWater.getTile(i-1,j);
								var rightAmnt2: int = baseWater.getTile(i+1,j);
								
								
								//If air below, get closer
								if(baseWater.getTile(i,j+1)==1)
								{
									if(leftAmnt2>myAmnt2)
									{
										var diff00:int = waterMax-leftAmnt2;
										
										if(myAmnt2>diff00)
										{
											myAmnt2-=diff00;
										}
										else
										{
											diff00 = myAmnt2-1;
											myAmnt2 = 1;
										}
										leftAmnt2+=diff00;
										
									}
									else if(myAmnt2>leftAmnt2)
									{
										var diff0:int = waterMax-myAmnt2;
										
										if(leftAmnt2>diff0)
										{
											leftAmnt2-=diff0;
										}
										else
										{
											diff0 = leftAmnt2-1;
											leftAmnt2 = 1;
										}
										myAmnt2+=diff0;
									}
								}
								else
								{
									//Should I involve all three?
									var origAmnt2:int  = myAmnt2;
									//Spread to the air if on firm ground
									var halfMyAmnt1:int = myAmnt2/2;
									if(halfMyAmnt1!=0)
									{
										myAmnt2 = halfMyAmnt1;
										rightAmnt2 = halfMyAmnt1;
									
										if(halfMyAmnt1*2<origAmnt2)
										{
											myAmnt2+=1;
										}
									}
									
								}
							
								
								baseWater.setTile(i,j,myAmnt2);
								baseWater.setTile(i-1,j,leftAmnt2);
								baseWater.setTile(i+1,j,rightAmnt2);
							}
							
							
							//Check if there's air on left and right
							else if(baseWater.getTile(i-1,j)==1
							&& baseWater.getTile(i+1,j)==1)
							{
								//If air below, do nothing
								if(baseWater.getTile(i,j+1)==1)
								{
								}
								else
								{
									var myAmnt1:int  = baseWater.getTile(i,j);
									var leftAmnt1: int = baseWater.getTile(i-1,j);
									var rightAmnt1: int = baseWater.getTile(i+1,j);
								
									//Spread
									var origAmnt1:int = myAmnt1;
									var splitUpAmnt:int = myAmnt1/3;
									//make sure there wasn't too little water to split
									if(splitUpAmnt!=0)
									{
									
										myAmnt1 = splitUpAmnt;
										leftAmnt1 = splitUpAmnt;
										rightAmnt1 = splitUpAmnt;
									
										var diff1:int = (origAmnt1)-(splitUpAmnt*3);
									
										if(diff1==1)
										{
											myAmnt1+=1;
										}
										else if(diff1==2)
										{
											myAmnt1 +=1;
											var chance1:Number = Math.random();
										
											if(chance1<0.5)
											{
												leftAmnt1+=1;
											}
											else
											{
												rightAmnt1+=1;
											}
										
										}
									}
									else if(myAmnt1==2)
									{
										myAmnt1 = 1;
										var chance2:Number = Math.random();
										
										if(chance2<0.5)
										{
											leftAmnt1+=1;
										}
										else
										{
											rightAmnt1+=1;
										}
										
									}
									
									
									baseWater.setTile(i,j,myAmnt1);
									baseWater.setTile(i-1,j,leftAmnt1);
									baseWater.setTile(i+1,j,rightAmnt1);
									
								}
															
							}
							*/
							if((i+1)<baseWater.widthInTiles && baseWater.getTile(i+1,j)!=0
							&& (i-1)>=0 && baseWater.getTile(i-1,j)!=0)
							{
								myAmnt = int(baseWater.getTile(i,j));
								var leftAmnt:int = int(baseWater.getTile(i+1,j));
								var rightAmnt:int = int(baseWater.getTile(i-1,j));
								
								//Left or right are different than this one
								//Left and right are both water filled
								if(((myAmnt!=leftAmnt || myAmnt!=rightAmnt)
								) && leftAmnt>1 && rightAmnt>1)
								{
									var total: int = (myAmnt+leftAmnt+rightAmnt);
									
									var split:int = total/3;
									
									if(split*3<total)
									{
										var diff:int = total-(split*3);
									
										if(diff==1)
										{
											if(myAmnt<waterMax)
											{
												myAmnt = split+diff;
												leftAmnt = split;
												rightAmnt = split;
											}
											else if(leftAmnt<waterMax
											&& rightAmnt<waterMax)
											{
												var num:Number = Math.random();
												
												if(num<0.5)
												{
													myAmnt = split;
													leftAmnt = split+diff;
													rightAmnt = split;
												}
												else
												{
													myAmnt = split;
													leftAmnt = split;
													rightAmnt = split+diff;
												}
																									
											}
											else if(leftAmnt<waterMax)
											{
												myAmnt = split;
												leftAmnt = split+diff;
												rightAmnt = split;
											}
											else if(rightAmnt<waterMax)
											{
												myAmnt = split;
												leftAmnt = split;
												rightAmnt = split+diff;
											}
											
										
											
										}
										else if(diff==2)
										{
											//All could use some
											if(myAmnt<waterMax
											&& rightAmnt<waterMax
											&& leftAmnt<waterMax)
											{
												myAmnt=split+1;
												
												if(num<0.5)
												{
													leftAmnt = split+1;
													rightAmnt = split;
												}
												else
												{
													leftAmnt = split;
													rightAmnt = split+1;
												}
					
											}
											else if(myAmnt<waterMax
											&& rightAmnt<waterMax)
											{
												myAmnt=split+1;
												rightAmnt = split+1;
												leftAmnt= split;
											}
											else if(myAmnt<waterMax
											&& leftAmnt<waterMax)
											{
												myAmnt=split+1;
												leftAmnt = split+1;
												rightAmnt= split;
											}
											else if(rightAmnt<waterMax
											&& leftAmnt<waterMax)
											{
												myAmnt=split;
												leftAmnt = split+1;
												rightAmnt= split+1;
											}
											else if(myAmnt+1<waterMax)
											{
												myAmnt=split+2;
												leftAmnt = split;
												rightAmnt= split;
											}
											else if(leftAmnt+1<waterMax)
											{
												myAmnt=split;
												leftAmnt = split+2;
												rightAmnt= split;
											}
											else if(rightAmnt+1<waterMax)
											{
												myAmnt=split;
												leftAmnt = split;
												rightAmnt= split+2;
											}
											
										}
										
										
										
									}
									else
									{
										myAmnt = split;
										leftAmnt = split;
										rightAmnt = split;
									}
									
									baseWater.setTile(uint(i),uint(j), uint(myAmnt));
									baseWater.setTile(uint(i+1),uint(j), uint(leftAmnt));
									baseWater.setTile(uint(i-1),uint(j), uint(rightAmnt));
								}
								
								//OCCLUSION
								//When the thing on the left is air
								
								else if(((myAmnt!=leftAmnt || myAmnt!=rightAmnt))
								&& leftAmnt == 1)
								{
									//Spread out if you have something below you that can "support" you
									if((j<baseWater.heightInTiles &&
									baseWater.getTile(i,j+1)<waterMax)
									|| (j<baseWater.heightInTiles &&
									baseWater.getTile(i,j+1)==0)
									|| j>=baseWater.heightInTiles
									
									
									)
									{
								
										var amntToAddR:int = int(waterMax - rightAmnt);
							
										if(myAmnt>amntToAddR)
										{
											myAmnt-=amntToAddR;
										}								
										else
										{
											amntToAddR = myAmnt-1; //one is the base
											myAmnt = 1;
										}
									
										rightAmnt +=amntToAddR;
										baseWater.setTile(uint(i),uint(j), uint(myAmnt));
										baseWater.setTile(uint(i-1),uint(j), uint(rightAmnt));
									}
									else
									{
										var totalR:int  = rightAmnt+myAmnt;
										var splitR:int = totalR/3;
										rightAmnt = splitR;
										myAmnt = splitR;
										leftAmnt = splitR;
										
										if(splitR*3<totalR)
										{
											myAmnt+=(totalR-splitR*3)
										}
										
										baseWater.setTile(uint(i),uint(j), uint(myAmnt));
										baseWater.setTile(uint(i+1),uint(j), uint(leftAmnt));
										baseWater.setTile(uint(i-1),uint(j), uint(rightAmnt));
										
									}
								
								}
								
								
								else if(((myAmnt!=leftAmnt || myAmnt!=rightAmnt))
								&& rightAmnt == 1)
								{
								
								//If we've got stuff below
								if((j<baseWater.heightInTiles &&
									baseWater.getTile(i,j+1)<waterMax)
									|| (j<baseWater.heightInTiles &&
									baseWater.getTile(i,j+1)==0)
									|| j>=baseWater.heightInTiles
									
									
									)
								{
									var amntToAddL:int = int(waterMax - leftAmnt);
							
									if(myAmnt>amntToAddL)
									{
										myAmnt-=amntToAddL;
									}								
									else
									{
										amntToAddL = myAmnt-1; //one is the base
										myAmnt = 1;
									}
									
									leftAmnt +=amntToAddL;
								
								
									baseWater.setTile(uint(i),uint(j), uint(myAmnt));
									baseWater.setTile(uint(i+1),uint(j), uint(leftAmnt));
								}
								/**
								else
								{
									var totalL:int  = rightAmnt+myAmnt;
									var splitL:int = totalL/3;
									
									if(splitL>0)
									{
										rightAmnt = splitL;
										myAmnt = splitL;
										leftAmnt = splitL;
									
										if(splitL*3<totalL)
										{
											if(myAmnt<waterMax)
											{
												myAmnt+=(totalL-splitL*3);
											}
										
										}
									
										if(myAmnt>waterMax)
										{
											myAmnt = waterMax;
										}
									}
									
									
									
									baseWater.setTile(uint(i),uint(j), uint(myAmnt));
									baseWater.setTile(uint(i+1),uint(j), uint(leftAmnt));
									baseWater.setTile(uint(i-1),uint(j), uint(rightAmnt));
										
								}
								*/
								
								
							}
								
								
						}
						//We're up against the left wall and spot on the right is open
						else if(((i+1)<baseWater.widthInTiles && baseWater.getTile(i+1,j)!=0)
						&& (i-1)<0)
						{
							 myAmnt = int(baseWater.getTile(i,j));
							 rightAmnt = int(baseWater.getTile(i+1,j));
							
							if((myAmnt!=rightAmnt ))
							{
								total = (myAmnt+rightAmnt);
								split = total/2;
								
								if(split*2<total)
								{
									myAmnt = split+1;
									rightAmnt = split;
								}
								else
								{
									myAmnt = split;
									rightAmnt = split;
								}
								
							}
							baseWater.setTile(uint(i),uint(j), uint(myAmnt));
							baseWater.setTile(uint(i+1),uint(j), uint(rightAmnt));
						}
						else if((i+1)>=baseWater.widthInTiles
						&& (i-1)>=0 && baseWater.getTile(i-1,j)!=0)
						{
							 myAmnt = int(baseWater.getTile(i,j));
							 leftAmnt = int(baseWater.getTile(i-1,j));
							
							if((myAmnt!=leftAmnt ))
							{
								total = (myAmnt+leftAmnt);
								split = total/2;
								
								if(split*2<total)
								{
									myAmnt = split+1;
									leftAmnt = split;
								}
								else
								{
									myAmnt = split;
									leftAmnt = split;
								}
								
							}
							baseWater.setTile(uint(i),uint(j), uint(myAmnt));
							baseWater.setTile(uint(i-1),uint(j), uint(leftAmnt));
						}
						
							
							
							
					}
						
				}
		}
		
		}
		
		
		
		
	}
}
