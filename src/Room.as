package{
	import org.flixel.*;
	public class Room {
		private var leftCorner:FlxPoint; //Left corner of room
		private var size: FlxPoint; //Size in pixels of room (width, height)
		private var cameraPosition: FlxPoint; //Camera position for the room
		
		public var adjacentRooms: Vector.<Room>; //A collection of all the rooms next to this one
		
		public var numRooms: int;
		
		public var roomName:String;
		
		//Constructor, sets up room rectangle
		public function Room(_leftCorner: FlxPoint, _size: FlxPoint, _cameraPosition: FlxPoint, _roomName:String="RoomRoom")
		{
		
			leftCorner = _leftCorner;
			size = _size;
			cameraPosition = _cameraPosition;
			roomName=_roomName;
			adjacentRooms = new Vector.<Room>();
			
			numRooms=0;
		}
		
		//Returns a reference to the camera position
		public function getCameraPosition(): FlxPoint
		{
			return cameraPosition;
		}
		
		//Called to add rooms that are adjacent to this one
		public function addNeighbor(room: Room):void
		{
			
			
			if(adjacentRooms.indexOf(room)==-1)
			{	
			
				
				numRooms=adjacentRooms.push(room);
				
				room.addNeighbor(this);
			}
		}
		
		//Returns a room if we should transfer into that one
		public function checkRooms(playerPnt: FlxPoint): Room
		{
			var roomToReturn: Room;
			
			
			var i:int;
			if(!within(playerPnt))
				{
				for (i = 0; i < numRooms; i++)
				{
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