##Ruby version of simple recommender

## Sample data of bands
database = {"Angelica"=> {"Blues Traveler" => 3.5, "Broken Bells" => 2.0,'Norah Jones'=> 4.5,'Phoenix'=>5.0,'Slightly Stoopid'=> 1.5,"The Strokes"=>2.5,"Vampire Weekend" => 2.0},
  'Bill'=>{'Blues Traveler' => 2.0, 'Broken Bells'=>3.5,"Deadmau5"=> 4.0, "Phoenix"=> 2.0, "Slightly Stoopid"=> 3.5, "Vampire Weekend"=> 3.0},
  "Chan"=> {"Blues Traveler"=> 5.0, "Broken Bells"=> 1.0, "Deadmau5"=> 1.0, "Norah Jones"=> 3.0, "Phoenix"=> 5, "Slightly Stoopid"=> 1.0},
         "Dan"=> {"Blues Traveler"=> 3.0, "Broken Bells"=> 4.0, "Deadmau5"=> 4.5, "Phoenix"=> 3.0, "Slightly Stoopid"=> 4.5, "The Strokes"=> 4.0, "Vampire Weekend"=> 2.0},
         "Hailey"=> {"Broken Bells"=> 4.0, "Deadmau5"=> 1.0, "Norah Jones"=> 4.0, "The Strokes"=> 4.0, "Vampire Weekend"=> 1.0},
         "Jordyn"=>  {"Broken Bells"=> 4.5, "Deadmau5"=> 4.0, "Norah Jones"=> 5.0, "Phoenix"=> 5.0, "Slightly Stoopid"=> 4.5, "The Strokes"=> 4.0, "Vampire Weekend"=> 4.0},
         "Sam"=> {"Blues Traveler"=> 5.0, "Broken Bells"=> 2.0, "Norah Jones"=> 3.0, "Phoenix"=> 5.0, "Slightly Stoopid"=> 4.0, "The Strokes"=> 5.0},
         "Veronica"=> {"Blues Traveler"=> 3.0, "Norah Jones"=> 5.0, "Phoenix"=> 4.0, "Slightly Stoopid"=> 2.5, "The Strokes"=> 3.0}
}

##Computes the Manhattan distance. Both rating1 and rating2 are dictionaries
##       of the form {'The Strokes': 3.0, 'Slightly Stoopid': 2.5}
## Usage: manhattan(database['Hailey'],database['Veronica']) --> returns a number. closer to zero the more similar they are.
def manhattan(rating1,rating2) #ruby
	distance=0
	commonRatings=false
	rating1.each do |key,value|
		if rating2.has_key?(key)
			distance+= (rating1[key] - rating2[key]).abs
			commonRatings=true
		end
	end
	if commonRatings
		return distance
	else
		return "No ratings in common!"
	end
end
	
# creates a sorted list of users based on their distance to username
# Usage: computeNearestNeighbour('Hailey',database') --> returns a list of similar users in descending order. the lower the number the more similar.
def computeNearestNeighbour(username,users)
	
	distances=[]
	users.each do |key,value|
		if key != username
			distance = manhattan(users[key], users[username])
            distances << [distance, key]
		end
	end
	# sort based on distance -- closest first
	distances.sort!
	return distances
end

##Gives the list of recommendations
##Usage: recommend('Hailey',database) --> returns a list of recommendations with their estimated ratings of user.
def recommend(username,users)
	## first find nearest neighbor
	nearest = computeNearestNeighbour(username, users)[0][1]
	recommendations=[]
	# now find bands neighbor rated that user didn't
	neighbourRatings = users[nearest]
	userRatings=users[username]
	neighbourRatings.each do |artist,rating|
		if userRatings.has_key?(artist) == false
			recommendations << ([artist,neighbourRatings[artist]])
		end
	end
	return recommendations.sort! {|a,b| b[1] <=> a[1]}
end