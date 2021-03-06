# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do 
    Cat.destroy_all
    CatRentalRequest.destroy_all
    User.destroy_all

    u1 = User.create!(user_name: 'aya', password: 'lalaland')
    u2 = User.create!(user_name: 'kevin', password: 'kevinland')

    c1 = Cat.create!(name: 'Lili', birth_date: '2020/5/7', color: 'brown', sex:'F', description: "My most beloved kitty", owner: u1)
    c2 = Cat.create!(name: 'Iyad', birth_date: '2019/8/7', color: 'white', sex:'M', description: "It is my first and older cat!", owner:u2)

    cr1 = CatRentalRequest.create!(cat: c1, status: 'PENDING', start_date: '2020/12/7', end_date: '2021/5/7', requester: u2)
    cr2 = CatRentalRequest.create!(cat: c2, status: 'APPROVED', start_date: '2020/1/7', end_date: '2020/11/7', requester: u1)
end