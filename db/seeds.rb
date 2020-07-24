Item.destroy_all
JsonEntry.destroy_all
Area.destroy_all
User.destroy_all

ap "Creation User"

email = ENV['EMAIL_SEED']

raise 'you need to have a `EMAIL_SEED` env variable' if email.blank?

user = User.create!(email: email, password: "azerty")

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
  {
    name: "Rhone soane Immo",
    area: area,
    data: open("data/json_files/rhone_soane_immo.json").read,
    verb: true,
    post_body: open("data/json_files/rhone_soane_immo_request.txt").read,
  }
]
json_entries.each do |attr|
  json_entry = JsonEntry.create!(attr)
  ap json_entry
end

ap "Creation Items"

JsonEntry.all.each do |jsonentry|
  FetchItemsFromJsonEntry.new(jsonentry).call
end
