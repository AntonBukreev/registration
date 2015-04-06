<?PHP

include_once('DBConnection.php');
include_once('User.php');

$op = $_POST["op"];

if ($op)
{
	
	$base = new DBConnection();
	$base->connect();
	
	switch ($op) 
	{
    case 'login':
	
      	$obj = User::validateLogin($_POST);
		echo json_encode($obj);	
        break;
		
    case 'reg':
		$obj = User::registrate($_POST);
		echo json_encode($obj);
        break;
		
	case 'del':
		$obj = User::delete($_POST);
		echo json_encode($obj);
        break;
	}

}	

?>