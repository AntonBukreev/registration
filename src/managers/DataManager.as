package managers
{
	import utils.DataSender;

	public class DataManager
	{
		
		public static const URL:String = "http://bukreev.in.ua/webforge/index.php";
		
		private static const COMMAND_REGISTRATE:String = "reg";
		private static const COMMAND_LOGIN:String = "login";
		private static const COMMAND_DEL:String = "del";
		
		public static const STATUS_OK:String = "1";
		public static const STATUS_DUPLICATE_LOGIN:String = "2";
		public static const STATUS_DUPLICATE_EMAIL:String = "3";
		public static const STATUS_INCOREECT_DATA:String = "4";
		
		private static var dataSender:DataSender = new DataSender();
		
		public function DataManager()
		{
			
		}
		
		public static function login(login:String, pass:String, callBack:Function):void
		{
			dataSender.sendRequestData(URL, {op:COMMAND_LOGIN, login:login, pass:pass}, callBack);
		}
		
		public static function registrate(login:String, pass:String, email:String, firstName:String, secondName:String, city:String, year:String, comment:String, callBack:Function):void
		{
			dataSender.sendRequestData(URL, {op:COMMAND_REGISTRATE, login:login, pass:pass, email:email, first:firstName, second:secondName, city:city, year:year, comment:comment}, callBack);
		}
		
		public static function deleteUser(uid:String, pass:String, callBack:Function):void
		{
			dataSender.sendRequestData(URL, {op:COMMAND_DEL, uid:uid, pass:pass}, callBack);
		}
	}
}