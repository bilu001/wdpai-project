<?php
require_once 'Database.php';
require_once 'PlayerController.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    if (isset($data['player_id'])) {
        $playerId = $data['player_id'];

        $playerController = new PlayerController();
        if ($playerController->removePlayer($playerId)) {
            echo json_encode(['status' => 'success']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Failed to remove player.']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
}
?>
