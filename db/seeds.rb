if User.first
  user.User.first
else
  user = User.create!(email: "toto@toto.com", password: "password")
end
area = Area.create!(user: user, name: "Test Lyon")
json_entries = [
  {
    name: "Espaces atypiques",
    area: area,
    data: "{\"_id\":\"espaceatypique\",\"startUrl\":[\"https://www.espaces-atypiques.com/villefranche-beaujolais/immobilier/ventes/?types_de_bien=&localisations=&order_by=date_desc&prix_min=148000&prix_max=550000&s=&order=&lang=fr\"],\"selectors\":[{\"id\":\"card\",\"type\":\"SelectorElement\",\"parentSelectors\":[\"_root\"],\"selector\":\"article\",\"multiple\":true,\"delay\":0},{\"id\":\"title\",\"type\":\"SelectorText\",\"parentSelectors\":[\"card\"],\"selector\":\"h2\",\"multiple\":false,\"regex\":\"\",\"delay\":0},{\"id\":\"price\",\"type\":\"SelectorText\",\"parentSelectors\":[\"card\"],\"selector\":\"div.price\",\"multiple\":false,\"regex\":\"\",\"delay\":0},{\"id\":\"area\",\"type\":\"SelectorText\",\"parentSelectors\":[\"card\"],\"selector\":\"div.surface\",\"multiple\":false,\"regex\":\"\",\"delay\":0},{\"id\":\"ref\",\"type\":\"SelectorText\",\"parentSelectors\":[\"card\"],\"selector\":\"div.reference\",\"multiple\":false,\"regex\":\"\",\"delay\":0},{\"id\":\"url\",\"type\":\"SelectorLink\",\"parentSelectors\":[\"card\"],\"selector\":\"a\",\"multiple\":false,\"delay\":0},{\"id\":\"image\",\"type\":\"SelectorImage\",\"parentSelectors\":[\"card\"],\"selector\":\"img\",\"multiple\":false,\"delay\":0}]}",

  },
]
json_entries.each do |attr|
  JsonEntry.create!(attr)
end
