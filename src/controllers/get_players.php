<?php
require_once 'PlayerController.php';

header('Content-Type: application/json');

$playerController = new PlayerController();
$players = $playerController->getPlayers();

echo json_encode($players);
?>
