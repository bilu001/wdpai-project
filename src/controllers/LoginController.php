<?php
session_start();
require_once 'Database.php';

class LoginController {
    private $db;

    public function __construct() {
        $this->db = (new Database())->connect();
    }

    public function login($username, $password) {
        $query = 'SELECT * FROM users WHERE username = :username AND password = :password';
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':password', $password);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            $_SESSION['username'] = $user['username'];
            $_SESSION['role'] = $user['role'];
            $_SESSION['changed_password'] = $user['changed_password'];

            setcookie("username", $user['username'], time() + (86400 * 30), "/");

            if ($user['role'] === 'coach') {
                header('Location: /public/views/coach_dashboard.html');
            } else if ($user['changed_password'] == FALSE) {
                header('Location: /public/views/change_password.html');
            } else {
                header('Location: /public/views/player_dashboard.html');
            }
            exit();
        } else {
            echo 'Invalid Credentials';
        }
    }

    public function changePassword($username, $currentPassword, $newPassword) {
        $query = 'SELECT * FROM users WHERE username = :username AND password = :currentPassword';
        $stmt = $this->db->prepare($query);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':currentPassword', $currentPassword);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            $updateQuery = 'UPDATE users SET password = :newPassword, changed_password = TRUE WHERE username = :username';
            $updateStmt = $this->db->prepare($updateQuery);
            $updateStmt->bindParam(':username', $username);
            $updateStmt->bindParam(':newPassword', $newPassword);
            $updateStmt->execute();
            header('Location: /public/views/player_dashboard.html');
        } else {
            echo 'Current Password is incorrect';
        }
    }
}
?>
