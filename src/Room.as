package{
	import org.flixel.*;
	public class Room {
		private var leftCorner:FlxPoint;
		private var size: FlxPoint;
		private var cameraPosition: FlxPoint;
		
		public var adjacentRooms: Vector.<Room>;
		public var nextRoom: Room;
		
		
		public var numRooms: int;
		
		//Constructor, sets up room rectangle
		public function Room(_leftCorner: FlxPoint, _size: FlxPoint, _cameraPosition: FlxPoint)
		{
		
			leftCorner = _leftCorner;
			size = _size;
			cameraPosition = _cameraPosition;
			
			adjacentRooms = new Vector.<Room>();
			
			numRooms=0;
		}
		
		
		public function getCameraPosition(): FlxPoint
		{
			return cameraPosition;
		}
		
		//Called to add rooms that are adjacent to this one
		public function addNeighbor(room: Room):void
		{
			//nextRoom = room;
			numRooms=adjacentRooms.push(room);
			//numRooms++;
		}
		
		public function checkRooms(playerPnt: FlxPoint): Room
		{
			var roomToReturn: Room;
			
			
			var i:int;
			if(!within(playerPnt))
				{
				for (i = 0; i < numRooms; i++)
				{
				
					
					//TROUBLE PART
    				if(adjacentRooms[i].within(playerPnt))
    				{
    					roomToReturn = adjacentRooms[i];
    				}
				}
			

			}
			
			return roomToReturn;
		}
		
		
		//Pass in the center of the player to determine if it's in this room or not
		public function within(playerPnt: FlxPoint): Boolean
		{
			
			var toReturn: Boolean =false;
			if(playerPnt.x>leftCorner.x && playerPnt.x<leftCorner.x+size.x)
			{
				if(playerPnt.y>leftCorner.y && playerPnt.y<leftCorner.y+size.y)
				{
					toReturn = true;
				}
			}
			return toReturn;
			
			return false;
		}
		
		
		
		
		
		
		
	}

}