<?php
require_once 'Database.php';

class PlayerController {
    private $db;

    public function __construct() {
        $this->db = (new Database())->connect();
    }

    public function addPlayer($name, $surname, $position, $contractEnds, $imagePath) {
        $query = 'INSERT INTO players (name, surname, position, contract_ends, image) VALUES (:name, :surname, :position, :contractEnds, :image)';
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':surname', $surname);
        $stmt->bindParam(':position', $position);
        $stmt->bindParam(':contractEnds', $contractEnds);
        $stmt->bindParam(':image', $imagePath);

        if ($stmt->execute()) {
            return $this->db->lastInsertId();
        } else {
            $errorInfo = $stmt->errorInfo();
            return false;
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['playerName'];
    $surname = $_POST['playerSurname'];
    $position = $_POST['playerPosition'];
    $contractEnds = $_POST['contractEndDate'];
    $imagePath = '../../public/images/' . basename($_FILES['playerImage']['name']);
    if (!is_writable('../../public/images/')) {
        http_response_code(500);
        echo 'Error: The images directory is not writable.';
        exit;
    }

    if (!move_uploaded_file($_FILES['playerImage']['tmp_name'], $imagePath)) {
        http_response_code(500);
        echo 'Error: Failed to move uploaded file.';
        exit;
    }

    $playerController = new PlayerController();
    $playerId = $playerController->addPlayer($name, $surname, $position, $contractEnds, $imagePath);

    if ($playerId) {
        echo json_encode([
            'player_id' => $playerId,
            'name' => $name,
            'surname' => $surname,
            'position' => $position,
            'contract_ends' => $contractEnds,
            'image' => basename($imagePath)
        ]);
    } else {
        http_response_code(500);
        $errorInfo = $playerController->db->errorInfo();
        echo 'Error adding player: ' . implode(' ', $errorInfo);
    }
}
?>
