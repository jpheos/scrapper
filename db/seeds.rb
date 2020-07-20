Item.destroy_all
JsonEntry.destroy_all


if User.first
  user = User.first
else
  user = User.create!(email: "jooo.blanchard@gmail.com", password: "azerty")
end
area = Area.create!(user: user, name: "Test Lyon")
json_entries = [
  {
    name: "Espaces atypiques",
    area: area,
    data: open("data/json_files/espaces_atypiques.json").read
  },
  {
    name: "Selection Immo",
    area: area,
    data: open("data/json_files/selection_immo.json").read
  }
]
json_entries.each do |attr|
  JsonEntry.create!(attr)
end

