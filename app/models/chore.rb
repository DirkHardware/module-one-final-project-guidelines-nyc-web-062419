class Chore < ActiveRecord::Base

    has_many :assignments
    has_many :users, through: :assignments

    def self.todo
        Chore.all.each do |chore_instance|
            puts "We still have to #{chore_instance.name.downcase}."
        end 
    end
    
    def self.similar_chore(taskname)
        can_create_chore = true
        Chore.all.each do |chore_instance|
            # binding.pry
            if chore_instance.name.downcase == taskname.downcase
                can_create_chore = false  
            end 
        end
        can_create_chore
    end  

end 