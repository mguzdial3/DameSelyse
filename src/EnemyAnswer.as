package 
{
	import org.flixel.*;
	
	//Info holder for enemy answers
	public class EnemyAnswer
	{
		private var answerText:String;
		private var keyToPress: String;
		private var correctAnswer: Boolean;
	
		public function EnemyAnswer(_answerText:String, _keyToPress:String, _correctAnswer:Boolean=false)
		{
			answerText=_answerText;
			correctAnswer=_correctAnswer;
			keyToPress = _keyToPress;
		}
		
		public function getAnswerText(): String
		{
			return answerText;
		}
		
		public function getKey(): String
		{
			return keyToPress;
		}
		
		public function isCorrectAnswer(): Boolean
		{
			return correctAnswer;
		}
		
	}
}