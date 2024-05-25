<?php
session_start();
require_once 'PlayerController.php';

header('Content-Type: application/json');

if (!isset($_SESSION['username'])) {
    echo json_encode(['error' => 'User not logged in']);
    exit();
}

$username = $_SESSION['username'];
$playerController = new PlayerController();
$playerData = $playerController->getPlayerData($username);

if ($playerData) {
    echo json_encode($playerData);
} else {
    echo json_encode(['error' => 'No player data found']);
}
?>
