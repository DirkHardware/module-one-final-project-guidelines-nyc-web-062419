class Chore < ActiveRecord::Base

    has_many :assignments
    has_many :users, through: :assignments

    def self.todo
        Chore.all.each do |chore_instance|
            puts "We still have to #{chore_instance.name.downcase}."
        end 
    end 

end 