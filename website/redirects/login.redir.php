<?php
    include "../includes/connect.inc.php";


    if (!isset($_POST['loginButton'])) {
        
        header("location: ../index.php");

    } else {

        $username = mysqli_real_escape_string($connect, $_POST['username']);
        $password = mysqli_real_escape_string($connect, $_POST['password']);

        $sql = "SELECT id, user, password, score, DATE_FORMAT(date, '%d.%m.%Y') date FROM attempt WHERE user = '$username';";
        $result = mysqli_query($connect, $sql);
        $numberOfResults = mysqli_num_rows($result);

        if ($numberOfResults > 0) {

            while ($row = mysqli_fetch_assoc($result)) {

                if (password_verify($password, $row["password"])) {
    
                    session_start();
                    
                    $_SESSION["id"] = $row["id"];
                    $_SESSION["user"] = $row["user"];
                    $_SESSION["score"] = $row["score"];
                    $_SESSION["date"] = $row["date"];

                } else {
                    header("location: ../login.php?error=wrongUsernamePassword");
                }
            }
            header("location: ../index.php");

        } else {
            header("location: ../login.php?error=wrongUsernamePassword");
        }

    }
?>