require_relative '../../config/environment'

#your final task is to create a logic checker to compare the count of the user assignments and the chores to make sure you
#don't wind up in a logical paradox where a user must be assigned a task to complete the block but there are no tasks to be assigned

class CLI 

    def intro
        puts "Hello! Welcome to the Chore Master 5000! Type 'commands' for a full list of ways I can optimize your life!"
        spacer(1)
        input = gets.chomp  
        what_program(input) 
    end 

    def what_program(input)

        case input.downcase

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
        
        when "chore wheel"
            spacer(2)
            spin_the_wheel
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

        when "move in"
            spacer(2)
            new_user
            spacer(2)
            intro

        when "move out"
            spacer(2)
            move_out("not graceful")
            spacer(2)
            intro

        when "move out gracefully"
            spacer(2)
            move_out("graceful")
            spacer(2)
            intro 

        when "new chore"
            spacer(2)
            new_chore
            spacer(2)
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
        puts "Assignments -- List which users has been tasked with what chores."
        puts "Commands -- List all possible commands."
        puts "Chores -- List all the chores that need to be done. Same as 'to do'"
        puts "Finish -- A user can list an assignment as finished."
        puts "Finish all -- A user can list all their tasks as finished"
        puts "Move in -- Add a user to the list of roommates."
        puts "Move out -- Indicate that a user has moved out...without completing their asssignments."
        puts "Move out gracefully -- Indicate that a user completed their assignments before moving out like a decent fucking human being"
        puts "Roomies -- List all users who can be assigned chores."
        puts "Spin the wheel -- Invites a user to spin the chore wheel and recieve a random chore assignment."
        puts "Shirk -- Pawn off a task on another user...unless they already have to do it."
        puts "Volunteer -- Select a user to assign a chore"
        puts "Exit -- Leaves the program. Probably for another, better program. It's okay though. I'm not mad about it, really its fine."
    end
    
    def finish
        puts "Who finished their task?"
        username = gets.chomp
        user = User.find_by name: username.capitalize
        if user == nil 
            puts "Sorry but they don't live here. Type another name."
            finish
        end
        puts "Awesome! What did you finish?"
        taskname = gets.chomp 
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
        user = User.find_by name: username.capitalize
        if user == nil 
            puts "Sorry but they don't live here. Type another name."
            finish_all
        end
        user.finish_all_chores
        puts "#{user.name} has completed all their tasks!"
        spacer(2)
    end

    def get_user
        username = gets.chomp
        user = User.find_by name: username.capitalize
    end

    def get_chore 
        taskname = gets.chomp 
        chore = Chore.find_by name: taskname.capitalize
    end

    # def main_menu(input)
    #     if input == "main menu" || input == " main menu" || input == "main menu " || input == "mainmenu" || input == " mainmenu" || input == "mainmenu "
    #         intro
    #     elsif input == "exit"
    #         what_program(input)
    #     end
    # end 

    def move_out(arg) 
        puts "Who is moving out?"
        user = nil 
        while user == nil
            user = get_user
        end
        if arg == "graceful" 
            user.finish_all_chores
            user.delete
            puts "#{user.name} completes all their chores before leaving"
        else 
            user.assignments.destroy_all
            user.delete
            # binding.pry
            puts "#{user.name} left without completing all their chores!"
        end 
    end
    
    def new_chore
        puts "What needs to be done?"
        task = gets.chomp
        task = task.downcase.capitalize
        can_create = Chore.similar_chore(task)
        if can_create == true 
            new_chore = Chore.create(name: task)
            puts "Its time to #{new_chore.name.downcase}!"
        else
            puts "Thats already on the list!" 
        end 
    end

    def new_user
        puts "Who is moving in?"
        username = gets.chomp
        username = username.downcase.capitalize
        binding.pry
        can_create = User.similar_user(username)
        if can_create == true 
            new_user = User.create(name: username)
            puts "Welcome #{new_user.name}! Now get crackin'."
        else
            puts "We've already got someone with that name living here, to avoid confusion maybe try again with a nickname." 
        end 
    end   

    def spacer(i)
        i.times do 
            puts "."
        end  
    end

    def shirk
        puts "Who doesn't want their job"
        user = nil 
        while user == nil
            user = get_user
        end
        puts "What job do they want to shirk?"
        chore = nil 
        while chore == nil 
            chore = get_chore
        end
        puts "Who should do it instead?"
        second_user = nil 
        while second_user == nil 
            second_user = get_user
        end 
        user.shirk_task(second_user, chore.name)
    end  
    
    def spin_the_wheel
        spacer(2)
        puts "Who wants to spin the wheel!"
        user = nil 
        while user == nil
            user = get_user
        end
        # binding.pry
        can_spin = user.chores_maxed
        maxed = user.chores_maxed
        # binding.pry
        if maxed == false 
            Assignment.chore_wheel(user)
            spacer(2)
        elsif maxed == true 
            puts "#{user.name} has already been assigned every possible chore!"
        end 
    end


    # def volunteer
    #     puts "Who doesn't want their job"
    #     user = nil 
    #     while user == nil
    #         user = get_user
    #     end
    #     puts "What job do they want to shirk?"
    #     chore = nil 
    #     while chore == nil 
    #         chore = get_chore
    #     end
    #     puts "Who should do it instead?"
    #     second_user = nil 
    #     while second_user == nil 
    #         second_user = get_user
    #     end 
    #     user.shirk_task(second_user, chore.name)
    # end
    
    def volunteer
        puts "Who is volunteering for the task?"
        user = nil 
        while user == nil
            user = get_user
        end
        puts "Awesome! What do you want to tackle?"
        chore = nil 
        while chore == nil 
            chore = get_chore
        end
        can_create = user.similar_task(user, chore.name)
        if can_create == true 
            assignment = Assignment.create(user: user, chore: chore, taskname: chore.name)
            puts "#{user.name} has volunteered to #{assignment.taskname.downcase}!" 
        else 
            puts "You already signed up for that you lazy bum!"
        end   
    end 





end


# this is how NOT to correct for edge cases during user input. The Library of Congress has voted to preserve
# this fuckup so that future generations may learn from it 
   # puts "What job do they not want to do? e.g. 'Do the dishes'"
        # chorename = gets.chomp
        # main_menu(chorename)
        # proposed_chore = Chore.find_by name: chorename.capitalize
        # if proposed_chore == nil 
        #     puts "Sorry, that doesn't seem to be on the list. Let's try again."
        #     chorename = nil 
        #     proposed_chore = nil 
        #     shirk 
        # end
