categories = [
  "Новости",
  "Технологии",
  "Разработка",
  "Дизайн",
  "Разное"
]

categories.each do |name|
  Category.find_or_create_by!(name: name)
end
