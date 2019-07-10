require_relative '../../config/environment'

class CLI 

    def intro
        puts "Hello! Welcome to the Chore Master 5000! How can I optimize your life today?"
        puts "Available Commands are: "
        puts "Roomies -- List all users who can be assigned chores."
        puts "Todo -- List all the chores that need to be done."
        puts "Assignments -- List who has been tasked with what chores."
        puts "Exit -- Leaves the program"
        input = gets.chomp  
        what_program(input) 
    end 

    def what_program(input)

        case input.downcase
        when "roomies"
            User.list_roommates
            intro
        when "todo"
            Chore.todo
            intro
        when "assignments"
            Assignment.who_does_what
            intro 
        when "shirk"
            shirk
            # puts "Who doesn't want their job?"
            # username = gets.chomp
            # user = User.find_by name: username.capitalize
            # if user == nil
            #     puts "Sorry but they don't live here. Type another name."
            # puts "What job do they not want to do? e.g. 'Do the dishes'"
            # chorename = gets.chomp
            # puts "Who should do it instead?"
            # suckername = gets.chomp
            # sucker = User.find_by name: suckername.capitalize
            # # binding.pry 
            # user.shirk_task(sucker, chorename)
            intro

        when "spin the wheel"
            spin_the_wheel
            intro 

        when "finish"
            finish
            intro

        when "finish all"
            finish_all
            intro

        when "exit"
            break_loop
        else 
            puts "Invalid Command!"
            intro 
        end 
    end 

    def break_loop
    end 

    def shirk 
        puts "Who doesn't want their job?"
        username = gets.chomp
        user = User.find_by name: username.capitalize
        if user == nil
            puts "Sorry but they don't live here. Type another name."
            shirk 
        end 
        puts "What job do they not want to do? e.g. 'Do the dishes'"
        chorename = gets.chomp
        puts "Who should do it instead?"
        suckername = gets.chomp
        sucker = User.find_by name: suckername.capitalize
        # binding.pry 
        user.shirk_task(sucker, chorename)
    end 

    def spin_the_wheel
        puts "Who wants to spin the wheel!"
        username = gets.chomp
        user = User.find_by name: username.capitalize
        if user == nil
            puts "Sorry but they don't live here. Type another name."
            spin_the_wheel
        end
        Assignment.chore_wheel(user)
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
            finish
        end
        user.finish_all_chores
        puts "#{user.name} has completed all their tasks!"
    end




end

# # intro 