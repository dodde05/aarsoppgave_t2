<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    
    if (isset($_SESSION['id'])) {
        header("location: index.php");
    }
    
    if (isset($_GET['error'])) {
    
        if ($_GET["error"] === "usernameInUse") {
            echo "<script>alert('The username is taken');</script>";
        }
    
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
</head>
<body>

    <nav>
        <a href="index.php">Back</a>
    </nav>
    
    <form action="redirects/signup.redir.php" method="post">
        <input type="text" name="newUsername" placeholder="Username" required>
        <input type="password" name="newPassword" placeholder="Password" required>
        <br>
        <button type="submit" name="signupButton">Sign up</Button>
    </form>

</body>
</html>