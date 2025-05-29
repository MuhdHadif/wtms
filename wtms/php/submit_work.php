<?php
if (!isset($_POST['submit'])) {
	$response = array('status' => 'failed_instant', 'data' => null);
	sendJsonResponse($response);
	die();
}

include_once("dbconnect.php");
$workId = $_POST["workId"];
$workerId = $_POST["workerId"];
$submissionText = $_POST["submissionText"];

$sqlsubmit = 
"INSERT INTO `submissions`(`workId`, `workerId`, `submissionText`) VALUES ('$workId','$workerId','$submissionText')";

$sqltaskcomplete = 
"UPDATE `works` SET `status` = 'complete' WHERE `id` = '$workId'";

try {
	if ($conn->query($sqlsubmit) === TRUE) {
		if ($conn->query($sqltaskcomplete) === TRUE) {
			$response = array('status' => 'success', 'data' => null);
			sendJsonResponse($response);
		}
	}else{
		$response = array('status' => 'failed_query', 'data' => $sqlsubmit);
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