package 
{
	import org.flixel.*;

	//Extends FlxSprite so it can be displayed easily
	public class InventoryItem extends FlxSprite
	{
		private var itemName: String;
		
		
		public function InventoryItem(itemImage:Class, x:Number, y:Number, _itemName:String, _scale:FlxPoint)
		{
			super(x,y,itemImage);
			itemName=_itemName;
			this.scale = _scale;
		}
		
		public function getItemName():String
		{
			return itemName;
		}
		
	}
}