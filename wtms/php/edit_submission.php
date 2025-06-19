<?php
if (!isset($_POST['submit'])) {
	$response = array('status' => 'failed_instant', 'data' => null);
	sendJsonResponse($response);
	die();
}

include_once("dbconnect.php");
$submissionId = $_POST["submissionId"];
$submissionText = addslashes($_POST["submissionText"]);

$sqledit = 
"UPDATE `submissions` SET `submissionText`='$submissionText' WHERE `id`='$submissionId'";

try {
	if ($conn->query($sqledit) === TRUE) {
        $response = array('status' => 'success', 'data' => $sqledit);
        sendJsonResponse($response);
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