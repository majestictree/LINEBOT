# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

destinations = ["札幌ターミナル", "花川3丁目", "花川5丁目"]
sapporo = [
  "10:20", "10:55",
  "11:20", "11:55",
  "12:20", "12:55",
  "13:20", "13:55",
  "14:20", "14:55",
  "15:20", "15:55",
  "16:20", "16:55",
  "17:35",
  "18:35",
  "19:37",
  "20:22",
  "21:15"
]

hanakawa3 = [
  "10:05", "10:32",
  "11:05", "11:32",
  "12:05", "12:32",
  "13:05", "13:32",
  "14:05", "14:32",
  "15:05", "15:32",
  "16:05", "16:32",
  "17:07", "17:47", "17:21",
  "18:07", "18:20", "18:47",
  "19:09", "19:48",
  "20:11", "20:48",
  "21:52",
  "22:17"
]

hanakawa5 = [
  "10:27", "10:50", "10:09",
  "11:27", "11:50", "11:09",
  "12:27", "12:50", "12:09",
  "13:27", "13:50", "13:09",
  "14:27", "14:50", "14:09",
  "15:27", "15:50", "15:09",
  "16:02", "16:27", "16:11", "16:45",
  "17:02", "17:11", "17:45",
  "18:02", "18:11", "18:45",
  "19:22", "19:03", "19:35",
  "20:03", "20:43",
  "21:33",
  "22:23"
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

