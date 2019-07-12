class Assignment < ActiveRecord::Base

    belongs_to :user
    belongs_to :chore

    def self.chore_wheel(user)
        lucky_user = user
        chores = Chore.all 
        nasty_job = chores.sample
        already_doing = lucky_user.similar_task(lucky_user, nasty_job.name)
        if already_doing == true 
            Assignment.create(user: lucky_user, chore: nasty_job, taskname: nasty_job.name)
            puts "#{lucky_user.name} has to #{nasty_job.name.downcase}."
        else 
            puts "The wheel says #{lucky_user.name} has to #{nasty_job.name.downcase} but they already have to do that! Lets try again!"
            Assignment.chore_wheel(lucky_user)
        end
    end 

    def self.who_does_what
        Assignment.all.each do |assignment_instance|
            # binding.pry
            puts "#{assignment_instance.user.name} has been asked to #{assignment_instance.taskname.downcase}."
        end 
    end 


end 