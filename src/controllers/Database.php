<?php
class Database {
    private $host = '172.19.0.4';
    private $db = 'db';
    private $username = 'docker';
    private $password = 'docker';
    private $conn;

    public function connect() {
        $this->conn = null;
        try {
            $this->conn = new PDO('pgsql:host=' . $this->host . ';dbname=' . $this->db, $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
            echo 'Connection Error: ' . $e->getMessage();
        }
        return $this->conn;
    }
}
?>
