<?php
    include "../includes/connect.inc.php";


    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Get the JSON data from the request body
        $json_data = file_get_contents('php://input');
        var_dump($json_data);

        // Decode the JSON data into a PHP array
        $data = json_decode($json_data, true);

        // Access the variables in the PHP array
        $name = $data['name'];
        $password = $data['password'];
        $score = $data['score'];

        $hash = password_hash($password, PASSWORD_DEFAULT);

        // Uploading to database
        $sql = "INSERT INTO attempt (user, password, score, date) VALUES ('$name', '$hash', $score, CURDATE());";
        mysqli_query($connect, $sql);
    } else {
        header("location: ../index.php");
    }

?>