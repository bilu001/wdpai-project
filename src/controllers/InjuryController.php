<?php
require_once 'Database.php';

class InjuryController {
    private $db;

    public function __construct() {
        $this->db = (new Database())->connect();
    }

    public function reportInjury($player_id, $type, $location, $date, $description, $feelings, $next_visit) {
        try {
            $this->db->beginTransaction();

            $query = 'INSERT INTO injuries (player_id, type, location, date, description, feelings, next_visit) 
                      VALUES (:player_id, :type, :location, :date, :description, :feelings, :next_visit)';
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':player_id', $player_id);
            $stmt->bindParam(':type', $type);
            $stmt->bindParam(':location', $location);
            $stmt->bindParam(':date', $date);
            $stmt->bindParam(':description', $description);
            $stmt->bindParam(':feelings', $feelings);
            $stmt->bindParam(':next_visit', $next_visit);
            $stmt->execute();
            $injury_id = $this->db->lastInsertId();

            $updateQuery = 'UPDATE players SET injury_id = :injury_id WHERE player_id = :player_id';
            $updateStmt = $this->db->prepare($updateQuery);
            $updateStmt->bindParam(':injury_id', $injury_id);
            $updateStmt->bindParam(':player_id', $player_id);
            $updateStmt->execute();

            $this->db->commit();

            return true;
        } catch (Exception $e) {
            $this->db->rollBack();
            return false;
        }
    }
}
