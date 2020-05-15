class WatchlistsController < ApplicationController
    
    get '/watchlists/new' do 
        # binding.pry
        if logged_in?
            erb :'watchlists/new'   
        else 
            flash[:alert] = "Must be logged in to create a new Watchlist"
            redirect '/'
        end
    end
    
    post '/watchlists/new' do 
        if params[:location].empty? || params[:date].empty?
            flash[:alert] = "Missing fields"
            redirect '/watchlists/new'
        else 
            birds = params[:birds].reject{|bird| bird[:name].empty?}
            if birds.any?{|bird| bird[:count] != bird[:count].to_i.to_s}
                flash[:alert] = "All counts must be integers"
                redirect '/watchlists/new'
            end
            watchlist = Watchlist.new(notes: params[:notes])
            watchlist.user = current_user
            watchlist.location = Location.find_or_create_by(name: params[:location].downcase)
            watchlist.date_created = Time.new(*params[:date].split("-"))

            birds.each do |bird|
                bird_object = Bird.find_or_create_by(name: bird[:name].downcase)
                count = bird[:count].empty? ? 1 : bird[:count].to_i
                count.times do 
                    watchlist.birds << bird_object
                end
            end

            watchlist.save
            flash[:message] = "Watchlist successfully created!"
            redirect "/watchlists/#{watchlist.id}"
        end
    end

    get '/watchlists/:id' do 
        @watchlist = Watchlist.find_by_id(params[:id])
        @session = session
        @bird_hash = group_by_hash(@watchlist.birds)
        if @watchlist
            erb :'watchlists/show'
        else 
            redirect '/profile'
        end
    end

    delete '/watchlists/:id' do 
        @watchlist = Watchlist.find_by_id(params[:id])
        if current_user == @watchlist.user
            @watchlist.destroy
        end
        redirect '/'
    end

    get '/watchlists/:id/edit' do 
        @watchlist = Watchlist.find_by_id(params[:id])
        if current_user = @watchlist.user
            erb :'watchlists/edit'
        else 
            flash[:alert] = "You may only edit your own watchlists."
            redirect '/profile'
        end
    end

    patch '/watchlists/:id/edit' do 
        @watchlist = Watchlist.find_by_id(params[:id])
        @watchlist.birds.clear
        birds = params[:birds].select{|bird| bird[:name] != ''}
 
        birds.each do |bird|
            bird_object = Bird.find_or_create_by(name: bird[:name].downcase)
            bird[:count] == '' ? count = 1 : count = bird[:count].to_i
            count.times do 
                @watchlist.birds << bird_object
            end
        end
        @watchlist.notes = params[:notes]
        @watchlist.save
        redirect "/watchlists/#{@watchlist.id}"

    end
end