<?php
session_start();
require_once 'Database.php';
require_once 'InjuryController.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_SESSION['username'];
    $type = $_POST['type'];
    $location = $_POST['location'];
    $date = $_POST['date'];
    $description = $_POST['description'];
    $feelings = $_POST['feelings'];
    $next_visit = $_POST['next_visit'];

    try {
        $db = (new Database())->connect();
        $stmt = $db->prepare("SELECT player_id FROM users WHERE username = :username");
        $stmt->bindParam(':username', $username);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($result) {
            $player_id = $result['player_id'];

            $injuryController = new InjuryController();
            if ($injuryController->reportInjury($player_id, $type, $location, $date, $description, $feelings, $next_visit)) {
                echo json_encode(['status' => 'success']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Failed to report injury.']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Player not found.']);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => 'An error occurred.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
}
?>
