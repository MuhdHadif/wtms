<?php

include_once("dbconnect.php");

$workerId = $_POST['workerId'];
$sqlgetworks = "SELECT * FROM `works` WHERE `assignedTo`='$workerId' ORDER BY `status` DESC";
$result = $conn->query($sqlgetworks);

if ($result->num_rows > 0) {
    $sentArray = array();
    while ($row = $result->fetch_assoc()) {
        $sentArray[] = $row;
    }
    $response = array('status' => 'success', 'data' => $sentArray);
    sendJsonResponse($response);
} else {
    $response = array('status'=> 'failed_query', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}