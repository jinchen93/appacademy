def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  Movie
    .select(:title, :id)
    .joins(:actors)
    .where('actors.name IN (?)', those_actors)
    .group('movies.id')
    .having("COUNT(actors.id) = ?", those_actors.length)

end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .group("yr / 10")
    .order("AVG(score) DESC")
    .pluck("yr / 10 * 10").first
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery

  movies =  Actor
    .joins(:castings)
    .where('actors.name = ?', name)
    .pluck('castings.movie_id')

  Actor
    .joins(:castings)
    .where('castings.movie_id IN (?) AND actors.name != ?', movies, name)
    .pluck('DISTINCT actors.name')
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie

  Actor
    .joins('LEFT OUTER JOIN castings ON castings.actor_id = actors.id')
    .where('castings.movie_id IS NULL')
    .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"

  letters = "%#{whazzername.split('').join('%')}%"

  Movie
    .joins(:actors)
    .where('UPPER(actors.name) LIKE UPPER(?)', letters)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.

  Actor
    .select(:id, :name, '(MAX(movies.yr) - MIN(movies.yr)) AS career')
    .joins(:movies)
    .group(:id)
    .order('career DESC, actors.name')
    .limit(3)
end