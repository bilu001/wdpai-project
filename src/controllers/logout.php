<?php
session_start();
session_unset();
session_destroy();

if (isset($_SERVER['HTTP_COOKIE'])) {
    $cookies = explode(';', $_SERVER['HTTP_COOKIE']);
    foreach ($cookies as $cookie) {
        $parts = explode('=', $cookie);
        $name = trim($parts[0]);
        setcookie($name, '', time() - 3600, '/');
        setcookie($name, '', time() - 3600, '/', $_SERVER['HTTP_HOST'], true, true); // Secure and HTTPOnly
    }
}

header('Location: /public/views/login.html');
exit();
?>
