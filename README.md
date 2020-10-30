<h1>TRIVIA TUMBLE</h1>

# INTRODUCTION
Welcome to Trivia Tumble!

This game was created by the two-person team of Anna Reed and Micah Mosley during the third week of the Flatiron Software Engineering bootcamp. After learning Ruby in the first two weeks of the program, this was created as an end of module project over the course of one week.

The main requirements for this project were to use an API to seed a database with data, access the database using ActiveRecord, and to have multiple models that had relationships with each other.

Trivia Tumble is an interactive game where random trivia facts begin falling down the player's terminal. The player guesses as to whether each fact is True or False by entering in a "T" or "F" into their command line. The player's score will increase by one for each correct answer. If the player does not answer before the question hits the floor (dashed line going across the screen) or answers incorrectly, they lose a life. A player starts the game with 3 lives. Facts will begin falling faster when the player's score reaches 5 points and then again at 10 points. 

# INSTALL INSTRUCTIONS
Step 1. Clone this directory to your device. <br>
Step 2. From your terminal, cd into the directory.<br>
Step 3. Using the terminal's command line enter the following commands:<br>
    - bundle install <br>
    - (enter)<br>
    - rake db:migrate <br>
    - (enter)

You are now ready to begin playing Trivia Tumble. To start the game go to your command line and enter the following: <br>
    - ruby bin/run.rb

From here the game will provide you all necessary instructions. If at any time you would like to exit the game mid-game type the folowing:<br>
    - control+c

# TECH STACK

- Ruby (2.7.1)<br>
- ActiveRecord<br>
- Awesome Print (Ruby gem for customizing terminal output)<br>
- Terminal Table (Ruby gem for printing data in table form)


# FUTURE DEVELOPMENT GOALS
- Having methods run in parallel so that we can have multiple questions falling down the screen at the same time. 