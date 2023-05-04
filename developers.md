# Instructions for developers

## Project contents

- cannongame (folder)
- website (folder)
    - gameBackend (folder)
- serversetup.sh

The "cannongame" folder contains all code for the game alone. The game is written in Lua using the Love2d framework.
The "website" folder contains all code for the main website. Pure JavaScript and CSS is used for the frontend, and pure PHP for the backend.
The "gameBackend" folder is a subfolder within "website". It contains PHP files which serves as the backend for the game. These files does not effect the website, they only handle logins and score uploads from the game directly.

## Setup

### Webserver

All the content inside "website" is hosted with a webserver. Remember to put servers file priority to PHP instead of Html.

### Database

For the leaderboard on the weniste to work, a database is required. The backend is set up to work with MariaDB, but you can use MySQL if you want to (I haven't tested that though).
The database should have the following structure:
A database called "highscores" with 1 table called "attempts". The table should have 4 columns: 'id', 'user', 'password', 'score', 'date'. The columns should have the following data types respectively: INT(auto incremental), VARCHAR(30), VARCHAR(255), DECIMAL(6, 2), DATE. Additionally, the database should have 1 user called "client" with password "79E76w864dcKbja". The user must have the grants SELECT, INSERT and UPDATE on the attempts table.

If you need to change the database structure, then you also need to make changes to the code. The following files establish a database connection:
- website/index.php
- website/redirects/login.redir.php
- website/gameBackend/upload.php