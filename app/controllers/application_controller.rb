require './config/environment'



class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

  get "/" do
    @session = session
    @watchlists = Watchlist.all.sort_by{|list| Date.parse(list.date_created)}.reverse[0..4]
    erb :welcome
  end

  helpers do 
    def logged_in?
      !!session[:user_id]
    end

    def current_user 
      User.find_by_id(session[:user_id])
    end

    def group_by_hash(objects) 
      hash = Hash.new(0)
      objects.each{|object| hash[object] += 1}
      hash
    end
  end

end
