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
            puts "Who doesn't want their job?"
            username = gets.chomp
            user = User.find_by name: username.capitalize
            puts "What job do they not want to do? e.g. 'Do the dishes'"
            chorename = gets.chomp
            puts "Who should do it instead?"
            suckername = gets.chomp
            sucker = User.find_by name: suckername.capitalize
            # binding.pry 
            user.shirk_task(sucker, chorename)

        when "exit"
            break_loop
        else 
            puts "Invalid Command!"
            intro 
        end 
    end 

    def break_loop
    end 


end

# # intro 