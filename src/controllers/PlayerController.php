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
            return false;
        }
    }

    public function removePlayer($playerId) {
        $this->db->beginTransaction();

        try {
            $usersQuery = 'DELETE FROM users WHERE player_id = :playerId';
            $usersStmt = $this->db->prepare($usersQuery);
            $usersStmt->bindParam(':playerId', $playerId);
            $usersStmt->execute();

            $playersQuery = 'DELETE FROM players WHERE player_id = :playerId';
            $playersStmt = $this->db->prepare($playersQuery);
            $playersStmt->bindParam(':playerId', $playerId);
            $playersStmt->execute();

            $injuriesQuery = 'DELETE FROM injuries WHERE injury_id IS NULL';
            $injuriesStmt = $this->db->prepare($injuriesQuery);
            $injuriesStmt->execute();

            $statisticsQuery = 'DELETE FROM statistics WHERE statistics_id IS NULL';
            $statisticsStmt = $this->db->prepare($statisticsQuery);
            $statisticsStmt->execute();

            $this->db->commit();
            return true;
        } catch (Exception $e) {
            $this->db->rollBack();
            error_log('Error removing player: ' . $e->getMessage());
            return false;
        }
    }



    public function getPlayerData($username) {
        $query = 'SELECT players.*, statistics.*, injuries.type AS injury_status FROM players
                  LEFT JOIN statistics ON players.player_id = statistics.player_id
                  LEFT JOIN injuries ON players.player_id = injuries.player_id
                  WHERE players.player_id = (SELECT player_id FROM users WHERE username = :username)';
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':username', $username);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getPlayers() {
        $query = 'SELECT players.*, injuries.type AS injury_status FROM players
                  LEFT JOIN injuries ON players.player_id = injuries.player_id';
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
