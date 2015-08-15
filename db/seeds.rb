# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'russian'
city =  %w{Москва Санкт-Петербург Новосибирск Екатеринбург Нижний Новгород Казань Омск Самара Челябинск Ростов-на-Дону Уфа Волгоград Красноярск Пермь Курск Воронеж Саратов Томск Киров Калуга Сочи Нальчик Петропавловск-Камчатский Южно-Сахалинск}
city.each do |c|
  City.create(title: c, url: c.parameterize)
end
sities = Site.create([{ title: 'Первый сайт', url: 'localhost' }, { title: 'Allwash', url: 'allwash.ru' }, { title: 'Allrests', url: 'allrests.ru' }])
