<?PHP
class User {

public static	$STATUS_OK = "1";
public static	$STATUS_DUPLICATE_LOGIN = "2";
public static	$STATUS_DUPLICATE_EMAIL = "3";
public static	$STATUS_INCOREECT_DATA = "4";
	
private static function checkSymbols($field, $length)
{
	if (strlen($field) > $length) return "";
	return mysql_real_escape_string($field);
}

private static function checkDuplicate($login, $name)
{
	$table = DBConnection::$TABLE_USERS;
	$query="SELECT * FROM $table WHERE ($name='$login')";
	
	$result = mysql_query($query,DBConnection::$db) or die ("Error! ".$query."\n".mysql_error());

	$rdb = mysql_fetch_object($result);
	mysql_free_result($result);
	
	return $rdb; 
}

private static function addUser($login, $pass, $email, $first, $second, $city, $year, $comment)
{
	
	$table = DBConnection::$TABLE_USERS;
	$query="INSERT INTO ".$table." (user_id, user_login, user_pass, user_email, user_first, user_second, user_year, user_city, user_comment) VALUES ('', '$login', '$pass', '$email', '$first', '$second', '$year', '$city', '$comment')";
	$result = mysql_query($query,DBConnection::$db) or die ("Error! ".$query."\n".mysql_error());

	$rdb = mysql_fetch_object($result);
	mysql_free_result($result);
	
	return $rdb; 
}

private static function getUser($login)
{
	return self::checkDuplicate($login, 'user_login');
}



private static function validateUser($login,$email)
{
	if (self::checkDuplicate($login,"user_login")) return self::$STATUS_DUPLICATE_LOGIN;
	if (self::checkDuplicate($email,"user_email")) return self::$STATUS_DUPLICATE_EMAIL;
		
	return self::$STATUS_OK; 
}

public static function registrate($post)
{
	$login = self::checkSymbols($post["login"],100);	
	$pass = self::checkSymbols($post["pass"],100);	
	$email = self::checkSymbols($post["email"],100);	
	$first = self::checkSymbols($post["first"],100);	
	$second = self::checkSymbols($post["second"],100);
	$city = self::checkSymbols($post["city"],100);
	
	$year = self::checkSymbols($post["year"],100);	
	$comment = self::checkSymbols($post["comment"],200);
	
	$status = self::validateUser($login, $email);
	
	if ($status == self::$STATUS_OK)
	{
		self::addUser($login, $pass, $email, $first, $second, $city, $year, $comment);
		$data = self::getUser($login);
	}
	$obj = array('op'=>'reg', 'status'=>$status, 'data'=>$data);
	return $obj;
}


private static function checkLogin($login, $pass)
{
	$table = DBConnection::$TABLE_USERS;
	$query="SELECT * FROM $table WHERE (user_login='$login' && user_pass='$pass')";
	$result = mysql_query($query,DBConnection::$db) or die ("Error! ".$query."\n".mysql_error());

	$rdb = mysql_fetch_object($result);
	mysql_free_result($result);
	return $rdb; 
}

public static function validateLogin($post)
{

	$login = self::checkSymbols($post["login"],20);	
	$pass = self::checkSymbols($post["pass"],20);	
	$data = self::checkLogin($login, $pass);
	if ($data) $status = self::$STATUS_OK;
	$obj = array('op'=>'login', 'status'=>$status, 'data'=>$data);
	return $obj;
}

public static function delete($post)
{
	$uid = self::checkSymbols($post["uid"],20);	
	$pass = self::checkSymbols($post["pass"],20);	
	
	$table = DBConnection::$TABLE_USERS;
	$query="DELETE FROM $table WHERE (user_id='$uid' && user_pass='$pass')";
	$result = mysql_query($query,DBConnection::$db) or die ("Error! ".$query."\n".mysql_error());

	$obj = array('op'=>'del', 'status'=>self::$STATUS_OK, 'data'=>$data);
	return $obj;
}

}

?>