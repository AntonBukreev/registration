package utils
{
	public class Utils
	{
		public function Utils()
		{
		}
		
		
		public static function get anticash():String
		{
			var value:String  = (new Date().time).toString()+(Math.random()*100).toString();
			return value;
		}
	}
}