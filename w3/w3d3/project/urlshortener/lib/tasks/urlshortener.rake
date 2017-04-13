namespace :urlshortener do
  desc 'Pruning unpopular links from the database'
  task purge_old_links: :environment do
    puts "Deleting old links that haven't been visited in the past 10 minutes"
    pruned = ShortenedUrl.prune(10)

    puts
    puts 'DELETED:'
    p pruned
  end
end
