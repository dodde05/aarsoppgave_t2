# Project description
A graphical highscore based 2D platforming game where scores can be uploaded to a database and viewed on a website.

# Technical details

## Client side
### The game
The game is written in Lua using the Love2d framework. The object of the game is to survive as long as possible without getting hit by the cannonballs firing from each side. The time you survive is your score.

## Server side
The server is a physical machine running Debian 11.

### The database
MariaDB is used as database. The database contains 1 table, which in turn contains 5 columns: id, user, password, score and date.

### The webserver
Apache is used as webserver. The main page of the website contains the leaderboard for the game which is gathered from the database through PHP. There is also a login page, a signup page and a game download page.