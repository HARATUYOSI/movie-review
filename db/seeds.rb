# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.create(name: 'アクション')
Genre.create(name: 'ドラマ')
Genre.create(name: '恋愛')
Genre.create(name: 'サスペンス')
Genre.create(name: 'SF')
Country.create(name: '日本')
Country.create(name: 'アメリカ')
Country.create(name: 'フランス')
Country.create(name: 'イギリス')

ReleaseYear.create(year: 2018)
ReleaseYear.create(year: 2017)
ReleaseYear.create(year: 2016)
ReleaseYear.create(year: 2015)
ReleaseYear.create(year: 2014)
