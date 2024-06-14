<?php
require_once 'PlayerController.php';

header('Content-Type: application/json');

try {
    $data = json_decode(file_get_contents('php://input'), true);
    if (!isset($data['player_id'])) {
        throw new Exception('Player ID is missing.');
    }

    $playerId = $data['player_id'];
    $playerController = new PlayerController();
    $result = $playerController->removePlayer($playerId);

    if ($result) {
        echo json_encode(['status' => 'success']);
    } else {
        throw new Exception('Failed to remove player.');
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>
