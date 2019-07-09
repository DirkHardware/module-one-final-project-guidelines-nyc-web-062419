class Assignment < ActiveRecord::Base

    belongs_to :user
    belongs_to :chore

    def self.chore_wheel
        users = User.all
        chores = Chore.all 
        lucky_user = users.sample
        nasty_job = chores.sample
        Assignment.create(user: lucky_user, chore: nasty_job, taskname: nasty_job.name)
        puts "#{lucky_user.name} has to #{nasty_job.name.downcase}."
    end 

end 