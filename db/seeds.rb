# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

team = FactoryGirl.create(:team)
date = Date.new(2016,7,1)
4.times do
  pr = FactoryGirl.create(:progress, team: team, start_date: date)
  FactoryGirl.create(:topic, progress: pr)
  date += 1.weeks
end
