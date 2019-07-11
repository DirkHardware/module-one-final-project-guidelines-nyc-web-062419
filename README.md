Hello, and welcome to the README file for Chore Master 5000, the ultimate in domestic work necessity allocation solutions.

Chore Master 5000 is a product of Simpler Solutions LLC, a divison of General Dynamics Armament and Technical Products.

### Part One - Setup

  Rake and Sqlite 3 are the most essential components of this program. If you're using this program, you've most likely pulled it from github. Sqlite should come by default with your system. Rake probably doesn't. 
  
  Before running anything, run bundle install to make sure that all gemfile dependencies have been satisfied, especially rake. Once you have Rake up and running, run rake db:migrate in terminal. 

  You can instantiate objects automatically by running rake db:seed, which will populate your database with all of the objects listed in seeds.rb. The names, order, and attributes of these objects are not essential to its functionality however, and the iteration of seeds.rb you recieved with your pull request was only used to test functionality by setting the object database to a default state with every seed. Feel free to replace any of the objects your own. HOWEVER, BE AWARE:

  User.destroy_all
  Chore.destroy_all
  Assignment.destroy_all

  in the seeds.rb used to delete all the objects in the database and seed the db with a default set of objects every time rake db:seed is invoked. This allows a "default state" for program state. If you remove these instructions, rake db:seed will add new objects to the database without deleting the old, potentially creating duplicate objects. 

### Part Two - Concept 

  Chore Master 5000 utilizes four models, three of which the user can interact with. They are 

  1. The CLI -- The CLI class is a compilation of methods used to run the CLI. Do not mess with it. To activate the CLI, type 'ruby bin/run.rb' in the terminal. This automatically takes the user into the main menu of the CLI. In the main menu, the user can type 'commands' for a list of all possible commands. Once a command has been invoked, the user cannot return to the main menu until
  the prompts for that command have been satisfactorily completed, or unless the user terminates the process and runs 'ruby bin/run.rb' again. 

  2. The Chore -- Chores are the things we need to do. Cleaning the dishes, sweeping the floor, walking the dog, etc. etc. We indicate what things are indicated with a single attribute, :name. Similar to the User class, any input given when creating a new Chore in the CLI will be downcased and then capitalized.  "Clean the dishes" and "Sweep the floor" are both examples of Chore names. Chores can exist on their own, or they can either be paired with Users through the 'Assignment' class, a joiner class which assigns Chores as tasks that Users should complete. Chores must be unique. You can't have two instances of a Chore with the same :name variable. After all, you don't need to clean the same set of dirty dishes twice. However, multiple users can be paired with the same Chore through seperate Assignments unique to each user. 

  3. The User -- Sometimes called "roomies" in the CLI, as the schema were conceptualized around the idea of people living in the same space. Users have only one attribute specific to their table, :name. Users can be added in the CLI by using the command "move in" in the main menu. This asks for a name of the new user. Note that any name entered will automatically be downcased and then capitalized, e.g. entering 'bIG MiKe' when prompted for a name will create a new user with a name: "Big mike". Users can be paired with Chores via a our final class, the joiner class known as 'Assignment'. A User can have multiple Assignments, indicating they have been tasked to do multiple things. However, User's Assignments must be unique. For example, a user cannot be given an Assignment paired with the "Take out the trash" chore if the they already have an Assignment paired with that chore. After all, they have already been asked to throw out the trash! 

  4. The Assignment -- The Assignment is the joiner class of Chore and User. On a more conceptual, naturalistic level, an Assignment is what happens when my girlfriend Julia leaves a post-it note on the fridge that says: "Go grocery shopping." It is the pairing of something that must be completed with someone who can complete it. Users cannot complete Chores unless they have been joined with one through an Assignment, and Chores cannot be completed unless a User with a corresponding Assignment completes that Assignment. Chores do not know about Users except through their corresponding Assignments. Users are only aware of Chores that have been assigned to them. When an Assignment is completed, its corresponding Chore is deleted, along with *every other Assignment instance paired with that Chore.* For example, in the default seed, Users "Anderson" and "Julia" both have Assignments paired with the Chore "Go grocery shopping." If you indicate in the CLI that Julia completed her "Go grocery shopping" Assignment, not only delete Julia's instance of that Assignment along with the corresponding "Go grocery shopping" Chore, but Anderson's "Go Grocery Shopping" Assignment will also be deleted! Julia already picked up the groceries, so Anderson doesn't need to go down to the Grocery Store anymore. 

### Part Three - Use 

  Chore Master 5000 uses a Command Line Interface. To utilize Chore Master 5000's crud functions, use the listed series of commands
  to create users, create chores, and task Users with Chores via Assignments. 

  Available Commands are: 
    Assignments -- List which users has been tasked with what chores.
    Commands -- List all possible commands.
    Chores -- List all the chores that need to be done. Same as 'to do'
    Finish -- A user can list an assignment as finished.
    Finish all -- A user can list all their tasks as finished
    Move in -- Add a user to the list of roommates.
    Move out -- Indicate that a user has moved out...without completing their asssignments.
    Move out gracefully -- Indicate that a user completed their assignments before moving out.
    Roomies -- List all users who can be assigned chores.
    Spin the wheel -- Invites a user to spin the chore wheel and recieve a random chore assignment.
    Shirk -- Pawn off a task on another user...unless they already have to do it.
    Volunteer -- Select a user to assign a chore
    Exit -- Leaves the program. 

  The CLI is fairly simple. The most important feature to remember is that these commands only work in the main menu prompt. Almost every command will ask the user for input when invoked. Every command is contingent on correct input (i.e. you must provide chore names that point to extant Chores, user names that point to extant Users, names for the creation of new Users and Chores that do not already exist etc.). If you input text, hit enter, and the input curser merely goes down a line and continues to blink, it is because you've provided invalid input and must try again. In plain English, you made a typo and the program can't handle it. Just check the prompt you were given and try again.  



  


### Option Two - Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate models for your runner and CLI interface.


