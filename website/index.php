<?php
    include "includes/connect.inc.php";


    if (!isset($_SESSION)) {
        session_start();
    }

    $userLoggedIn = isset($_SESSION['id']);
    $userHasScore = isset($_SESSION['score']);
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/style.css">
        <title>Leaderboard</title>
    </head>
    <body>
        
        <div id="root">

            <div id="header">
                <nav>
                    <a href="download.php">Game download</a>

                    <?php
                        if (!$userLoggedIn) {

                            echo 
                            "<a href='login.php'>Sign in</a>
                            <a href='signup.php'>Sign up</a>";

                        } else {

                            echo 
                            "<form action='redirects/logout.redir.php' method='post'>
                                <button type='submit' name='logoutButton' id='logoutButton'>Sign out</button>
                            </form>";

                        }
                    ?>
                </nav>
            </div>
            
            <div id="leaderboard">

                <div id="users">

                    <h1>Leaderboards</h1>

                    <table>

                        <tr>
                            <th>Rank</th>
                            <th>Name</th>
                            <th>Score</th>
                            <th>Date</th>
                        </tr>
                        <?php

                            $sql = "SELECT id, user, score, DATE_FORMAT(date, '%d.%m.%Y') date FROM attempt WHERE score IS NOT NULL ORDER BY score DESC;";
                            $result = mysqli_query($connect, $sql);
                            $numberOfResults = mysqli_num_rows($result);

                            if ($numberOfResults > 0) {

                                $rank = 1;
                                while ($row = mysqli_fetch_assoc($result)) {
                                    echo 
                                    "<tr>" .
                                        "<td>" . $rank . "." . "</td>" .
                                        "<td>" . $row["user"] . "</td>" .
                                        "<td>" . $row["score"] . "</td>" .
                                        "<td>" . $row["date"] . "</td>" .
                                    "</tr>";

                                    if ($userHasScore) {

                                        if ($row["id"] === $_SESSION["id"]) {
                                            $_SESSION["rank"] = $rank;
                                        }

                                    }

                                    $rank++;
                                    
                                }
                            }

                        ?>

                    </table>

                </div>

                <div id="you">

                    <?php
                        if ($userHasScore) {
                            echo "<h3>Your placement:</h3>
                            <table>

                                <tr>
                                    <th>Rank</th>
                                    <th>Name</th>
                                    <th>Score</th>
                                    <th>Date</th>
                                </tr>

                                <tr>
                                    <td>" . $_SESSION["rank"] . "." . "</td>
                                    <td>" . $_SESSION["user"] . "</td>
                                    <td>" . $_SESSION["score"] . "</td>
                                    <td>" . $_SESSION["date"] . "</td>
                                </tr>

                            </table>";

                        } elseif ($userLoggedIn) {

                            echo "<h3>Your placement:</h3>
                            <p>No score yet</p>";

                        }
                    ?>

                </div>

            </div>

        </div>

    </body>
</html>