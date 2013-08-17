package 
{
	import org.flixel.*;
	
	//Passes in reference to a number of sprites, which are hidden at the end of this dialogue
	public class SpriteHideDialogNode extends DialogNode{
		protected var sprites: Vector.<FlxSprite>;
		protected var showSprites: Vector.<FlxSprite>;
		
		public function SpriteHideDialogNode(_nextNode:DialogNode, _faceToDisplay:uint, _displayText:String,_sprites:Vector.<FlxSprite>,
		_showSprites:Vector.<FlxSprite>=null,
		 _pausesGame:Boolean=false, 
		_alternateNode:DialogNode=null)
		{
			super(_nextNode,_faceToDisplay, _displayText,true,_alternateNode);
			sprites = _sprites;
			showSprites = _showSprites;
		}
		
		
		override public function handleDialogEnd(inventory:Inventory, player:Player):void
		{
			//Hides Sprites
			var i:int;
			
			for(i =0; i<sprites.length; i++)
			{
				sprites[i].alpha = 0;
			}
			
			if(showSprites!=null)
			{
				for(i =0; i<showSprites.length; i++)
				{
					showSprites[i].alpha = 1;
				}
			}
					
		}
		
	}
}