package 
{
	import org.flixel.*;
	
	//Info holder for enemy answers
	public class EnemyAnswer
	{
		private var answerText:String;
		private var correctAnswer: Boolean;
	
		public function EnemyAnswer(_answerText:String, _correctAnswer:Boolean=false)
		{
			answerText=_answerText;
			correctAnswer=_correctAnswer;
		}
		
		public function getAnswerText(): String
		{
			return answerText;
		}
		
		public function isCorrectAnswer(): Boolean
		{
			return correctAnswer;
		}
		
	}
}