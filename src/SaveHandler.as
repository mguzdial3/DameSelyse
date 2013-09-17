package
{
	import org.flixel.*;
 
	public class SaveHandler
	{
		private static var _save:FlxSave; //The FlxSave instance
		private static var levelTemp:int = 0; //Holds level data if bind() did not work. This is not persitent, and will be deleted when the application ends
		private static var _loaded:Boolean = false; //Did bind() work? Do we have a valid SharedObject?
		private static var _playerPositionTemp: FlxPoint; //The correct playerPosition temp
		
		
		/**
		 * Returns the number of levels that the player has completed
		 */
		public static function get levels():int
		{
			//We only get data from _save if it was loaded properly. Otherwise, use _temp
			if (_loaded)
			{
				return _save.data.levels;
			}
			else
			{
				return levelTemp;
			}
		}
		
		/**
		 * Returns the last saved playerPosition
		 */
		public static function get playerPosition():FlxPoint
		{
			//We only get data from _save if it was loaded properly. Otherwise, use _temp
			if (_loaded)
			{
				return _save.data.playerPosition;
			}
			else
			{
				return _playerPositionTemp;
			}
		}
		
		public static function getLoaded(): Boolean
		{
			return _loaded;
		}
		
		public static function checkPlayerPos(): Boolean
		{
			return _save.data.playerPosition!=null;
		}
		
		public static function getPlayerPos(): FlxPoint
		{
			return _save.data.playerPosition;
		}
		
		//////////////////////////////////////////////////////////////
		//SETTERS
		
		/**
		 * Sets the number of levels that the player has completed
		 */
		public static function set levels(value:int):void
		{
			if (_loaded)
			{
				_save.data.levels = value;
			}
			else
			{
				levelTemp = value;
			}
		}
		
		/**
		 * Sets the playerPosition
		 */
		public static function set playerPosition(value:FlxPoint):void
		{
			if (_loaded)
			{
				_save.data.playerPosition = value;
				_save.flush();
			}
			else
			{
				_playerPositionTemp = value;
			}
		}
		
		
 
		/**
		 * Setup SaveHandler
		 * returns true if it's setUpBefore, false otherwise
		 */
		public static function setUp(playerPos:FlxPoint):Boolean
		{
			_save = new FlxSave();
			_loaded = _save.bind("mySaveData");
			_playerPositionTemp = playerPos;
			//_save.erase();
			if (_loaded && _save.data.playerPosition == null)
			{
				_save.data.levels = 0;
				_save.data.playerPosition = playerPos;
				_save.flush();
				return false;
			}
			else if(_loaded && _save.data.playerPosition!=null)
			{
			
				
				return true;
			}
			
			return false;
			
			
		}
	}
}