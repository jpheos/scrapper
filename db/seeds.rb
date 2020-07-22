Item.destroy_all
JsonEntry.destroy_all
Area.destroy_all
User.destroy_all

ap "Creation User"
user = User.create!(email: "inicolas69@gmail.com", password: "azerty")
ap user

ap "Creation Area"
area = Area.create!(user: user, name: "Test Lyon")
ap area

ap "Creation JsonEntry"
json_entries = [
  {
    name: "Espaces atypiques",
    area: area,
    data: open("data/json_files/espaces_atypiques.json").read,
  },
  {
    name: "Selection Immo",
    area: area,
    data: open("data/json_files/selection_immo.json").read,
  },
]
json_entries.each do |attr|
  json_entry = JsonEntry.create!(attr)
  ap json_entry
end
