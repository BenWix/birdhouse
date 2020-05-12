User.destroy_all
Bird.destroy_all
Watchlist.destroy_all
Location.destroy_all

users = {"benwix" => "password", "megholla" => "password", 
 "birder123" => "password", "flamingofanatix" => "password",
"crazycardinal" => "password", "beltedkingbirder" => "password"}

def rand_bird
    birds = ["belted kingfisher", 'northern cardinal', 'tufted titmouse',
    'robin', 'mochingbird', 'red winged blackbird', 'red eyed vireo',
    'killdeer', 'hooded merganser', 'goose', 'green heron', 'indigo bunting',
    'carolina wren', 'black and white warbler', 'gray catbird', 'wood duck',
    'mallard', 'yellow rumped watbler', 'white throated sparrow',
    'carolina chickadee', 'barred owel', 'bald eagle', 'osprey', 
    'ring-billed gull', 'baltimore oriole']
    
    birds.sample
end

def rand_location        
    locations = ["capperton swamp park", "cherokee park", 'leonard springs',
    'lake griffy', 'big four bridge', 'home']
    
    Location.find_or_create_by(name: locations.sample)
end

def time_rand from = 1557755486, to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f)).to_s.split(" ").first
end

def new_watchlist
    list = Watchlist.new
    list.location = rand_location
    list.date_created = time_rand
    rand(3..10).times do 
        rand(5).times do 
            list.birds << Bird.find_or_create_by(name: rand_bird)
        end
    end
    list
    
end

users.each do |name, pass|
    user = User.create(username: name, password: pass)

    rand(3...7).times do 
        user.watchlists << new_watchlist
    end

end