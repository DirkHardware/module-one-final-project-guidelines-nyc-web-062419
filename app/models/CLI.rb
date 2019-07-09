require_relative '../../config/environment'

class CLI 

    def intro
        puts "Hello! Welcome to the Chore Master 5000! How can I optimize your life today?"
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