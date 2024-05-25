<?php
require_once 'src/controllers/LoginController.php';
require_once 'src/controllers/SessionController.php';
require_once 'src/controllers/PlayerController.php';
require_once 'src/controllers/InjuryController.php';

$loginController = new LoginController();
$sessionController = new SessionController();
$playerController = new PlayerController();
$injuryController = new InjuryController();

$action = isset($_GET['action']) ? $_GET['action'] : '';

switch ($action) {
    case 'login':
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $username = $_POST['username'];
            $password = $_POST['password'];
            $loginController->login($username, $password);
        } else {
            include 'public/views/login.html';
        }
        break;

        case 'change_password':
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                session_start();
                $username = $_SESSION['username'];
                $currentPassword = $_POST['current_password'];
                $newPassword = $_POST['new_password'];
                $confirmPassword = $_POST['confirm_password'];
                if ($newPassword !== $confirmPassword) {
                    echo 'New passwords do not match.';
                } else {
                    $loginController->changePassword($username, $currentPassword, $newPassword);
                }
        } else {
            include 'public/views/change_password.html';
        }
        break;

    case 'logout':
        $sessionController->logout();
        break;

    case 'add_player':
        include 'src/controllers/add_player.php';
        break;

    case 'remove_player':
        include 'src/controllers/remove_player.php';
        break;

    case 'get_player_data':
        include 'src/controllers/get_player_data.php';
        break;

    case 'report_injury':
        include 'src/controllers/report_injury.php';
        break;

    default:
        include 'public/views/login.html';
        break;
}
?>
