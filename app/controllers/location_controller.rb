class LocationController < ApplicationController
    get '/locations' do 
        @locations = Location.all
        erb :'locations/index'
    end
    
    get '/locations/:id' do 
        @location = Location.find_by_id(params[:id])
        if @location 
            erb :'locations/show'
        else 
            redirect '/locations'
        end
    end
end