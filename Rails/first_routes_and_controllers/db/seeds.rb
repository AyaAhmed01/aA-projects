# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do 
    User.destroy_all
    ArtWork.destroy_all
    ArtworkShare.destroy_all

    u1 = User.create!(username: 'aya')
    u2 = User.create!(username: 'Ismael')
    
    a1 = ArtWork.create!(title: 'monaliza', image_url: 'paintings.com', artist: u1)
    a2 = ArtWork.create!(title: 'castle', image_url: 'middel_ages.com', artist: u2)

    as1 = ArtworkShare.create!(viewer: u1, artwork: a2)
    as2 = ArtworkShare.create!(viewer: u2, artwork: a1)

end