class UsersController < ApplicationController
    get '/signup' do 
        if logged_in?
            redirect '/'
        end
        erb :'users/signup'
    end

    post '/signup' do 
        unless params[:username] == ''
            exisitng_user = User.find_by(username: params[:username])
            unless exisitng_user
                user = User.new(params)
                if user.save
                    session[:user_id] = user.id
                    redirect '/profile'
                end
            else
                #That username is already taken
                redirect '/signup'
            end
        end
        #please enter a valid username and password
        redirect '/signup'
    end

    get '/login' do 
        if logged_in?
            redirect '/'
        end
        erb :'users/login'
    end

    post '/login' do 
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/profile'
        else 
            redirect '/login'
        end
    end

    post '/logout' do 
        session.clear
        redirect '/'
    end

    get '/profile' do 
        if logged_in?
            @user = current_user
            #binding.pry
            erb :'users/profile'
        else 
            redirect '/'
        end
    end




end