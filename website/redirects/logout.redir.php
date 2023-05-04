<?php
    if (!isset($_SESSION)) {
        session_start();
    }

    if (!isset($_POST['logoutButton'])) {

        header("location: ../index.php");
    
    } else {

        session_destroy();
        header("location: ../index.php");

    }
?>