class WatchlistsController < ApplicationController
    
    get '/watchlists/new' do 
        # binding.pry
        if logged_in?
            erb :'watchlists/new'   
        else 
            redirect '/'
        end
    end
    
    post '/watchlists/new' do 
        
        watchlist = Watchlist.new(notes: params[:notes])
        watchlist.user = current_user
        birds = params[:birds].select{|bird| bird[:name] != ''}
 
        birds.each do |bird|
            bird_object = Bird.find_or_create_by(name: bird[:name].downcase)
            bird[:count] == '' ? count = 1 : count = bird[:count].to_i
            count.times do 
                watchlist.birds << bird_object
            end
        end
 
        watchlist.save
        redirect "/watchlists/#{watchlist.id}"
    end
    
    get '/watchlists/:id' do 
        @watchlist = Watchlist.find_by_id(params[:id])
        erb :'watchlists/show'
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
     
        redirect "/watchlists/#{@watchlist.id}"

    end
end