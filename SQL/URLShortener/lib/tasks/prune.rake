namespace :prune do
  task old_urls: :environment do        # to access ActiveRecord models, load in the environment
    minutes = ENV['minutes'].to_i || 144
    puts "Pruning old urls..."
    ShortenedUrl.prune(minutes)
  end
end
  
  