<?php
if (!isset($_POST['submit'])) {
	$response = array('status' => 'failed_instant', 'data' => null);
	sendJsonResponse($response);
	die();
}

include_once("dbconnect.php");
$workerId = $_POST['workerId'];
$fullName = $_POST['fullName'];
$email = $_POST['email'];
$phoneNum = $_POST['phoneNum'];
$address = $_POST['address'];

$workerId = $_POST['workerId'];
$sqleditprofile = "UPDATE `workers` SET `fullName`='$fullName', `email`='$email', `phoneNum`='$phoneNum', `address`='$address' WHERE `id`='$workerId'";

try {
	if ($conn->query($sqleditprofile) === TRUE) {
		$response = array('status' => 'success', 'data' => null);
		sendJsonResponse($response);
	}else{
		$response = array('status' => 'failed_query', 'data' => $sqleditprofile);
		sendJsonResponse($response);
	}
} catch(Exception $e) {
  $response = array('status' => 'failed_exception', 'data' => null);
  sendJsonResponse($response);
  die;
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}