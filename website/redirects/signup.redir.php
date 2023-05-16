<?php
    include "../includes/connect.inc.php";


    if (!isset($_POST['signupButton'])) {

        header("location: ../index.php");

    } else {

        $username = mysqli_real_escape_string($connect, $_POST['newUsername']);
        $password = mysqli_real_escape_string($connect, $_POST['newPassword']);

        $hash = password_hash($password, PASSWORD_DEFAULT);

        $sql = "SELECT user FROM attempt WHERE user = '$username';";
        $result = mysqli_query($connect, $sql);
        $numberOfResults = mysqli_num_rows($result);

        if ($numberOfResults > 0) {

            header("location: ../signup.php?error=usernameInUse");

        } else {
            
            $sql = "INSERT INTO attempt (user, password) VALUES ('$username', '$hash');";
            mysqli_query($connect, $sql);
            
            session_start();

            $_SESSION["id"] = mysqli_insert_id($connect);
            $_SESSION["user"] = $username;

            header("location: ../index.php");
        
        }

    }
?>