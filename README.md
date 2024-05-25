# wdpai-project
Basics of Application Programming whole project - Bil Mateusz
Hello, this is a project which I have completed as part of Basics of Application Programming.
It's a "team management" tool.

## Features

- User roles: coach and player
- Player and injury management
- Statistics management
- Authentication with encrypted passwords
- Session management with cookies
- Dynamic data rendering based on user role

## Prerequisites

- Docker
- Docker Compose

## Getting Started

### Clone the Repository

git clone https://github.com/bilu001/wdpai-project.git
cd wdpai-project

### Run the application
docker-compose up --build


### Accessing the Database
Once the containers are running, you can access the application at http://localhost:5050.

Login to pg-admin using credentials from docker-compose.yml file

### Connecting to database

It may happen that address of docker container on which database resides is different from what we have here.
Please always run `docker container list` command, grasp an ID of container with DB.
Then run `docker inspect <id>` command to get an IP Address. Once gathered, update Database.php controller with correct IP

### Accessing the Application
Once the containers are running, you can access the application at http://localhost:8080.

Coach Login: Use the following credentials:
Email: <set_up_yours_in_db>
Password: <set_up_yours_in_db>


This `README.md` file provides a comprehensive overview of the project, including setup instructions, project structure, and additional resources. You can further customize it based on your project's specific needs and details.

***NOTE***
REMOVE PLAYER FUNCTIONALITY IS STILL TBH, THUS THERE IS remove_player.php controller and function in PlayerController.php present for this functionality. However, they do not yet work.