#This is a simple recommender made in python. It uses a simple manhattan distance algorithm
#to find the similarity between users.


#sample data of bands
database = {"Angelica": {"Blues Traveler": 3.5, "Broken Bells": 2.0, "Norah Jones": 4.5, "Phoenix": 5.0, "Slightly Stoopid": 1.5, "The Strokes": 2.5, "Vampire Weekend": 2.0},
         "Bill":{"Blues Traveler": 2.0, "Broken Bells": 3.5, "Deadmau5": 4.0, "Phoenix": 2.0, "Slightly Stoopid": 3.5, "Vampire Weekend": 3.0},
         "Chan": {"Blues Traveler": 5.0, "Broken Bells": 1.0, "Deadmau5": 1.0, "Norah Jones": 3.0, "Phoenix": 5, "Slightly Stoopid": 1.0},
         "Dan": {"Blues Traveler": 3.0, "Broken Bells": 4.0, "Deadmau5": 4.5, "Phoenix": 3.0, "Slightly Stoopid": 4.5, "The Strokes": 4.0, "Vampire Weekend": 2.0},
         "Hailey": {"Broken Bells": 4.0, "Deadmau5": 1.0, "Norah Jones": 4.0, "The Strokes": 4.0, "Vampire Weekend": 1.0},
         "Jordyn":  {"Broken Bells": 4.5, "Deadmau5": 4.0, "Norah Jones": 5.0, "Phoenix": 5.0, "Slightly Stoopid": 4.5, "The Strokes": 4.0, "Vampire Weekend": 4.0},
         "Sam": {"Blues Traveler": 5.0, "Broken Bells": 2.0, "Norah Jones": 3.0, "Phoenix": 5.0, "Slightly Stoopid": 4.0, "The Strokes": 5.0},
         "Veronica": {"Blues Traveler": 3.0, "Norah Jones": 5.0, "Phoenix": 4.0, "Slightly Stoopid": 2.5, "The Strokes": 3.0}
        }


def manhattan(user1,user2):
    distance=0
    comparison=False  # To ensure if nothing in common, dont return 0 (best result)
    try:                # Find if users exist in the first place.
        database[user1]
        database[user2]
    except KeyError:
        raise Exception('No such user in Database!')
    else:        
        for key,value in database[user1].items():
            if key in database[user2]:
                comparison=True
                distance += abs(database[user1][key]-database[user2][key])
        
        if comparison == True:
            return distance
        else:
            return 'Users have no items in common'

def nearestneighbour(user,*k):        #returns a list in descending order of closeness.Uses Manhattan distance.
    #Database form: user: {books:rating}
    lst=[]
    for person in database:
        if person != user:
            lst.append([person,manhattan(user,person)])     #calculate manhattan distance between all users

    lst.sort(key = lambda x:x[1])  #sorts the list to descending order
    
    neighbours=[]

    for entry in lst:
        neighbours+=[entry[0]]      #return list without the numbers 
        
    if k:
        return neighbours[:k[0]]
    else:
        return neighbours

def recommend(user,*number): #Recommend all bands that user has not rated yet.
    """ Input a user name, and an optional argument number.
    Function will then return a list of recommendations for user.
    If numbers is specified, returns specified number of recommendations."""
    similar=nearestneighbour(user,1)
    similar=similar[0]
    lst=[]
    
    for key in database[similar]:
        if key not in database[user]:
            lst+= [[key,database[similar][key]]]
    lst.sort(key=lambda x:x[1],reverse=True)

    if lst==[]:
        return 'No recommendations available for ' + user + ' at this moment'
    
    if number:
        return lst[:number[0]]
    else:
        return lst
        

    
    
