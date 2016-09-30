# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

46.times do
  Department.create(name: Faker::Commerce.department)
end

Department.all.each do |d|
  1.times do
    manager = d.employees.create(name: Faker::Name.name)
    n = Random.rand(100)
    n.times do
      d.employees.create(name: Faker::Name.name, manager_id: manager.id)
    end
  end
end
