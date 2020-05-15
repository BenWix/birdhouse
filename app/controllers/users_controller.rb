class UsersController < ApplicationController
    get '/signup' do 
        if logged_in?
            redirect '/'
        end
        erb :'users/signup'
    end

    post '/signup' do 
        unless params[:username].empty?
            existing_user = User.find_by(username: params[:username])
            unless existing_user
                user = User.new(params)
                if user.save
                    session[:user_id] = user.id
                    redirect '/profile'
                end
            else
                flash[:alert] = "That username is unavailable." 
                redirect '/signup'
            end
        end
        flash[:alert] = "Please enter a valid username and password."
        redirect '/signup'
    end

    get '/login' do 
        if logged_in?
            flash[:alert] = "You are already logged in."
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
            flash[:alert] = "Your username or password is incorrect"
            redirect '/login'
        end
    end

    

    get '/logout' do 
        session.clear
        redirect '/'
    end

    get '/profile' do 
        if logged_in?
            @user = current_user
            @common_birds = group_by_hash(@user.birds).sort_by{|bird, count| count}.reverse[0..4]
            erb :'users/profile'
        else 
            flash[:alert] = "You must be logged in to view your profile."
            redirect '/'
        end
    end




end