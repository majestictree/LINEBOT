# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

destinations = ["札幌ターミナル", "花川3丁目", "花川5丁目"]
sapporo = [
  "10:20", "10:55", "10:37",
  "11:20", "11:55", "11:37",
  "12:20", "12:55", "12:37",
  "13:20", "13:55", "13:37",
  "14:20", "14:55", "14:37",
  "15:20", "15:55", "15:37",
  "16:20", "16:55", "16:37",
  "17:35", "17:20", "17:55",
  "18:35", "18:20", "18:55",
  "19:37",
  "20:35",
  "21:45"
]

hanakawa3 = [
  "10:12", "10:42",
  "11:12", "11:42",
  "12:12", "12:42",
  "13:12", "13:42",
  "14:12", "14:42",
  "15:12", "15:42",
  "16:12", "16:42",
  "17:12", "17:21", "17:42",
  "18:07", "18:25", "18:52",
  "19:09", "19:48",
  "20:15", "20:47",
  "21:15",
  "22:17"
]

hanakawa5 = [
  "10:25", "10:48", "10:09",
  "11:25", "11:48", "11:09",
  "12:25", "12:48", "12:09",
  "13:25", "13:48", "13:09",
  "14:25", "14:48", "14:09",
  "15:25", "15:48", "15:09", "15:58",
  "16:05", "16:37", "16:15", "16:50",
  "17:33", "17:07", "17:43",
  "18:33", "18:07", "18:43",
  "19:18", "19:30", "19:50",
  "20:10", "20:30",
  "21:25",
  "22:30"
]

sapporo.each do |t|
  Bus.create!(time: t, goto: destinations[0])
end

hanakawa3.each do |t|
  Bus.create!(time: t, goto: destinations[1])
end

hanakawa5.each do |t|
  Bus.create!(time: t, goto: destinations[2])
end

