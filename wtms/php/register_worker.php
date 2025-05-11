<?php
if (!isset($_POST['register'])) {
	$response = array('status' => 'failed_instant', 'data' => null);
	sendJsonResponse($response);
	die();
}

include_once("dbconnect.php");
$fullName = $_POST['fullName'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
$phoneNum = $_POST['phoneNum'];
$address = $_POST['address'];

$sqlregister = 
"INSERT INTO `workers`(`fullName`, `email`, `password`, `phoneNum`, `address`) VALUES ('$fullName','$email','$password','$phoneNum','$address')";

try {
	if ($conn->query($sqlregister) === TRUE) {
		$response = array('status' => 'success', 'data' => null);
		sendJsonResponse($response);
	}else{
		$response = array('status' => 'failed_query', 'data' => $sqlregister);
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