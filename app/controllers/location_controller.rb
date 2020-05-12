class LocationController < ApplicationController
    get '/locations' do 
        erb :'locations/index'
    end
    
    get '/locations/:id' do 
        @location = Locations.find_by_id(params[:id])
        if @location 
            erb :'locations/show'
        else 
            redirect '/locations'
        end
    end
end