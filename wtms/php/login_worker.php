<?php
if (!isset($_POST['login'])) {
	$response = array('status' => 'failed_instant', 'data' => null);
	sendJsonResponse($response);
	die();
}

include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqllogin = "SELECT * FROM `workers` WHERE `email` = '$email' AND `password` = '$password'";
$result = $conn->query($sqllogin);

try {
	if ($result->num_rows > 0) {
        $sentArray = array();
        while($row = $result->fetch_assoc()){
            $sentArray[] = $row; 
        }
		$response = array('status' => 'success', 'data' => $sentArray);
		sendJsonResponse($response);
	}else{
		$response = array('status' => 'failed_query', 'data' => $sqllogin);
		sendJsonResponse($response);
	}
} catch(Exception $e) {
  $response = array('status' => 'failed_exception', 'data' => null);
  sendJsonResponse($response);
  die;
}

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>