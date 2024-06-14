<?php
session_start();
require_once 'LoginController.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['current_password']) && isset($_POST['new_password']) && isset($_POST['confirm_password'])) {
    $username = $_SESSION['username'];
    $currentPassword = $_POST['current_password'];
    $newPassword = $_POST['new_password'];
    $confirmPassword = $_POST['confirm_password'];

    if ($newPassword !== $confirmPassword) {
        echo 'New passwords do not match.';
        exit();
    }

    $loginController = new LoginController();
    $loginController->changePassword($username, $currentPassword, $newPassword);
}
?>
