def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  Movie
    .select('movies.id, movies.title')
    .joins(:actors)
    .where('actors.name IN (?)', those_actors)
    .group(:id)   # movies id
    .having('COUNT(actors.id) >= ?', those_actors.count)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .select('yr / 10 * 10 AS decade')
    .group('decade')
    .order('AVG(score) DESC')
    .first 
    .decade
    
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  movies_id = Movie
                    .select('movies.id')
                    .joins(:actors)
                    .where('actors.name = name')
  Movie
  .joins(:actors)
  .where.not(actors: { name: name })
  .where(movies: { id: movies_id })
  .distinct
  .pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .select(:name)
    .left_outer_joins(:movies)
    .where(movies: {id: nil})
    .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

  matcher = "%#{whazzername.split(//).join('%')}%"
  Movie
    .joins(:actors)
    .where('UPPER(name) LIKE UPPER(?)', matcher)
    .distinct
  
  # Note: The below code also works:
  # Actor.where('name ilike ?', matcher).first.movies

  # As the Postgres docs say,
  # "the keyword ILIKE can be used instead of LIKE to make the match
  # case insensitive according to the active locale.
  # This is not in the SQL standard but is a PostgreSQL extension."
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

  Actor
    .select(:id, :name,'MAX(movies.yr) - MIN(movies.yr) AS career')
    .joins(:movies)
    .group(:id)
    .order('career DESC , actors.name')
    .limit(3)
end
