package 
{
	import org.flixel.*;

	public class EnemyNode
	{
		private var X:Number;
		private var Y:Number;
		private var distTo:Number;
		private var myParent:EnemyNode;
	
		public function EnemyNode(X: Number, Y:Number,_distTo:Number=0, _myParent: EnemyNode=null):void
		{
			this.X = X;
			this.Y= Y;
			this.distTo = _distTo;
			this.myParent = _myParent;
		}	
		
		//Full G Score is a combo of dist to this point and dist to goal
		public function getGScore(goalX:Number, goalY:Number):Number
		{
			var distToGoal:Number = Math.sqrt(Math.pow((goalX-X),2)+Math.pow((goalY-Y),2));
			
			return distToGoal+distTo;
		}
		
		public function nodeEquals(nodeX:Number, nodeY:Number): Boolean
		{
			return ((nodeX==X) && (nodeY==Y));
		}
		
		public function nodeEqualsSpecial(nodeX:Number, nodeY:Number, minDifference:Number): Boolean
		{
		
			var distFrom:Number = Math.sqrt(Math.pow((nodeX-X),2)+Math.pow((nodeY-Y),2));
		
			return distFrom<minDifference;
		}
		
		
		//GETTERS
		public function getX():Number
		{
			return X;
		}
		
		public function getY():Number
		{
			return Y;
		}
		
		public function getDistTravelled(): Number
		{
			return distTo;
		}
		
		public function getParent():EnemyNode
		{
			return myParent;
		}
		
		
		
		
	
	}
}