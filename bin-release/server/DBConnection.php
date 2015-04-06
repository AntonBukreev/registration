<?PHP

class DBConnection
{
	public static $db;
	public static $TABLE_USERS="users";
	
	public function connect()
	{
		$dbase = "web_forge";
		$login = "root";
		$pass = "UfFqyRpsn6oL8ahk";

		self::$db = mysql_connect("localhost",$login,$pass) or die ("Error! DB connection error!");
		mysql_select_db($dbase,self::$db);               

		mysql_query("set character_set_results='utf8'",self::$db);
		mysql_query("SET NAMES 'utf8'",self::$db);
	}
}

?>