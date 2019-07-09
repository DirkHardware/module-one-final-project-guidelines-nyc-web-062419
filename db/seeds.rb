require_relative '../app/models/assignment.rb'
require_relative '../app/models/chore.rb'
require_relative '../app/models/user.rb'

User.destroy_all
Chore.destroy_all
Assignment.destroy_all

julia = User.create(name: "Julia")
anderson = User.create(name: "Anderson")
nick = User.create(name: "Nick")

dishes = Chore.create(name: "Do the dishes")
laundry = Chore.create(name: "Do the laundry")
bathroom = Chore.create(name: "Clean the bathroom")
trash = Chore.create(name: "Take out the trash")
shopping = Chore.create(name: "Go grocery shopping")


dishes_assignment1 = Assignment.create(user: anderson, chore: dishes, taskname: dishes.name)
trash_assignment = Assignment.create(user: anderson, chore: trash, taskname: trash.name)
shopping_assignment1 = Assignment.create(user: anderson, chore: shopping, taskname: shopping.name)
shopping_assignment2 = Assignment.create(user: julia, chore: shopping, taskname: shopping.name)
dishes_assignment2 = Assignment.create(user: julia, chore: dishes, taskname: dishes.name)
laundry_assignment = Assignment.create(user: nick, chore: laundry, taskname: laundry.name)
