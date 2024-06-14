# wdpai-project
Basics of Application Programming whole project - Bil Mateusz
Hello, this is a project which I have completed as part of Basics of Application Programming.
It's a "team management" tool.

## Features

- User roles: coach and player
- Player management
- Injury management
- Authentication with password, password change
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

### Accessing the Application As Coach
Once the containers are running, you can access the application at http://localhost:8080.

Coach Login: Use the following credentials:
Email: <set_up_yours_in_db>
Password: <set_up_yours_in_db>


### Adding player
Once logged in, from coach dashboard click on "Add a player", provide players image, name, surname and contract expiration date.

Uppon successful addition, you should see a player on your dashboard.

### Access player page
On another web browser access http://localhost:8080. Provide an email of the player ad namesurname@milano.com and password 'default'.

You will ber redirected to change_password.html file where you will be asked to change the password.

### Log injury as player
As a player move to "Report injury" tab on your nav bar, fill in necessary info and click submit.

Once you do this, on coach dashboard you will se an indicator that a player is injured ("!" mark next to "Remove player" button)

### Removing a player
As a coach by clicking "Remove player" you can remove a player from your team.


This `README.md` file provides a comprehensive overview of the project, including setup instructions, project structure, and additional resources. You can further customize it based on your project's specific needs and details.
