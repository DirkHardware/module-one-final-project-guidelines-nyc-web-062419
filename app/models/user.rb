class User < ActiveRecord::Base

    has_many :assignments
    has_many :chores, through: :assignments

    def finish_all_chores
        self.assignments.each do |assignment_instance|
            assignment_instance.chore.delete
            assignment_instance.delete
            delete_similar(self, assignment_instance.taskname)
        end
        self.assignments.delete_all 
    end 

    def complete_task(taskname) 
        task = self.assignments.find_by taskname: taskname
        task.chore.delete
        task.delete 
        delete_similar(self, taskname)
    end 

# delete_similar is a helper method used by finish_all_chores and complete_task. It is used to delete assignments containing identical 
# chores. This way if one user completes chore, other users with similar assignments are no longer listed as obligated to complete the 
# same task


    def delete_similar(user, taskname)
        Assignment.all.each do |assignment_instance|
            if  assignment_instance.taskname == taskname
                assignment_instance.delete 
                # puts "#{user.name} finishes #{assignment_instance.taskname}"
            end
        end 
    end

    def shirk_task(user, taskname)
        can_shirk = similar_task(user, taskname)
        # can_shirk = true
        shirk_chore = Chore.find_by name: taskname.capitalize 
        if can_shirk == true
            new_assignment = Assignment.create(user: user, chore: shirk_chore, taskname: shirk_chore.name)
            old_assignment = Assignment.find_by taskname: taskname.capitalize, user: self 
            # binding.pry
            old_assignment.delete 
            puts "Haha! Now #{user.name} has to #{taskname.downcase}."
        else 
            puts "#{user.name} is already doing that you lazy bum!"
        end 
    end 

# similar_task is conceptually similar to delete_similar, in that it iterates through a series of assignments and checks for duplicates.
# However it differs in that rather than deleting them, it merely passes a boolean value to can_shirk in shirk_task, which determines
# whether or not shirk_task will move forward and create a new assignment for a user while deleting the old assignment for the old user.

    
    def similar_task(user, taskname)
        can_create_task = true
        similar = user.assignments.select do |assignment_instance| 
            assignment_instance.taskname.downcase == taskname.downcase
        end 
        if similar.count > 0
            can_create_task = false   
        end
        can_create_task
    end 
    
    def self.similar_user(username)
        can_create_user = true
        similar = User.all.select do |user_instance| 
            user_instance.name.downcase == username.downcase
        end 
        if similar.count > 0
            can_create_user = false   
        end
        can_create_user
    end 

    def self.list_roommates
        User.all.each do |user_instance|
            puts "#{user_instance.name} has #{user_instance.assignments.count} things to do."
        end 
    end  

end 