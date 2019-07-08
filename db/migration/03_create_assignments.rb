class CreateAssignments.rb < ActiveRecord::Migration[5.0]

    def change 
        create_table :assignments do |t|
            t.integer :user_id
            t.integer :chore_id
            t.string :due_by
        end
    end 

end 