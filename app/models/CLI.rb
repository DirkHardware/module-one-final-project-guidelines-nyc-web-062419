require_relative '../../config/environment'

class CLI 

    def intro
        puts "Hello! Welcome to the Chore Master 5000! Type 'commands' for a full list of ways I can optimize your life!"
        puts "Type 'main menu' during any prompt to return to this menu!"
        input = gets.chomp  
        what_program(input) 
    end 

    def what_program(input)

        case input.downcase

        when "add todo"
            add_todo 
            intro 

        when "assignments"
            spacer(2)
            Assignment.who_does_what
            spacer(2)
            intro

        when "chores"
            spacer(2)
            Chore.todo
            spacer(2)
            intro

        when "commands"
            commands
            spacer(1)
            intro  

        when "finish"
            spacer(2)
            finish
            spacer(2)
            intro

        when "finish all"
            spacer(2)
            finish_all
            intro
            spacer(2)

        when "main menu"
            spacer(1)
            intro
        
        when "roomies"
            spacer(2)
            User.list_roommates
            spacer(2)
            intro
            
        when "shirk"
            spacer(2)
            shirk
            spacer(2)
            intro

        when "spin the wheel"
            spacer(2)
            spin_the_wheel
            spacer(2)
            intro 

        when "todo"
            spacer(2)
            Chore.todo
            spacer(2)
            intro

        when "volunteer"
            spacer(2)
            volunteer
            spacer(2)
            intro  

        when "exit"
            break_loop

        else 
            spacer(1)
            puts "Invalid Command!"
            spacer(1) 
            intro
            
        end 
    end 

    def add_todo 
        puts "What needs to be done?"
        taskname = gets.chomp 
        can_create = Chore.similar_chore(taskname)
        if can_create == true 
            Chore.create(name: taskname.capitalize)
        else 
            puts "That's already on the list!"
            intro 
        end
    end 


    def break_loop
    end 

    def commands 
        puts "Available Commands are: "
        puts "Assignments -- List who has been tasked with what chores."
        puts "Commands -- List all possible commands."
        puts "Chores -- List all the chores that need to be done. Same as todo"
        puts "Finish -- A user can list an assignment as finished."
        puts "Finish all -- A user can list all their tasks as finished"
        puts "Main menu -- Type main menu during any prompt to return to the main menu"
        puts "Roomies -- List all users who can be assigned chores."
        puts "Spin the wheel -- Invites a user to spin the chore wheel and recieve a random chore assignment."
        puts "Shirk -- Pawn off a task on another user...unless they already have to do it."
        puts "Todo -- List all the chores that need to be done. Same as chores"
        puts "Volunteer -- Select a user to assign a chore"
        puts "Exit -- Leaves the program. Probably for another, better program. It's okay though. I'm not mad about it, really its fine."
    end

    def finish
        puts "Who finished their task?"
        username = gets.chomp
        main_menu(username)
        user = User.find_by name: username.capitalize
        if user == nil 
            puts "Sorry but they don't live here. Type another name."
            finish
        end
        puts "Awesome! What did you finish?"
        taskname = gets.chomp 
        main_menu(taskname)
        chore = Chore.find_by name: taskname.capitalize
        if chore == nil
            puts "That wasn't on the list. Try again."
            finish
        end
        taskname = chore.name
        user.complete_task(taskname)
        puts "#{user.name} completed task #{taskname}!"
    end

    def finish_all 
        puts "Who finished their tasks?"
        username = gets.chomp
        main_menu(username)
        user = User.find_by name: username.capitalize
        if user == nil 
            puts "Sorry but they don't live here. Type another name."
            finish_all
        end
        user.finish_all_chores
        puts "#{user.name} has completed all their tasks!"
        spacer(2)
    end

    def main_menu(input)
        if input == "main menu" || input == " main menu" || input == "main menu " || input == "mainmenu" || input == " mainmenu" || input == "mainmenu "
            intro
        elsif input == "exit"
            what_program(input)
        end
    end 

    def spacer(i)
        i.times do 
            puts "."
        end  
    end

    def shirk 
        spacer(2)
        puts "Who doesn't want their job?"
        username = gets.chomp
        main_menu(username) 
        user = User.find_by name: username.capitalize
        if user == nil
            puts "Sorry but they don't live here. Type another name."
            username = nil 
            shirk 
        end 
        puts "What job do they not want to do? e.g. 'Do the dishes'"
        chorename = gets.chomp
        main_menu(chorename)
        proposed_chore = Chore.find_by name: chorename.capitalize
        if proposed_chore == nil 
            puts "Sorry, that doesn't seem to be on the list. Let's try again."
            chorename = nil 
            proposed_chore = nil 
            shirk 
        end
        puts "Who should do it instead?"
        suckername = gets.chomp
        main_menu(suckername)
        sucker = User.find_by name: suckername.capitalize
        if sucker == nil
            puts "Sorry, but they don't live here. Try another name."
            suckername = nil 
            shirk 
        end
        user.shirk_task(sucker, chorename)
        spacer(2)
    end 

    def spin_the_wheel
        spacer(2)
        puts "Who wants to spin the wheel!"
        username = gets.chomp
        main_menu(username)
        user = User.find_by name: username.capitalize
        if user == nil
            puts "Sorry but they don't live here. Type another name."
            spin_the_wheel
        end
        Assignment.chore_wheel(user)
        spacer(2)
    end
    
    def volunteer
        same_exists = false 
        puts "Who is volunteering for the task?"
        username = gets.chomp
        main_menu(username)
        user = User.find_by name: username.capitalize 
        if user == nil 
            puts "Sorry but they don't live here. Type another name."
            volunteer
        end
        puts "Awesome! What do you want to tackle?"
        taskname = gets.chomp 
        main_menu(taskname)
        chore = Chore.find_by name: taskname.capitalize
        if chore == nil
            puts "That wasn't on the list. Try again."
            volunteer
        end
        can_create = user.similar_task(user, taskname) 
        if can_create == false
            puts "Sorry, but they already have to do that. Pick another task."
            volunteer
        else 
            Assignment.create(user: user, chore: chore, taskname: chore.name)
            puts "#{user.name} has volunteered to #{taskname.downcase}!"  
        end 
    end 





end

# # intro 