class LocationController < ApplicationController
    get '/locations' do 
        @locations = Location.all
        erb :'locations/index'
    end
    
    get '/locations/:id' do 
        @location = Location.find_by_id(params[:id])
        @common_birds = group_by_hash(@location.birds).sort_by{|bird, count| count}.reverse[0..4]
        if @location 
            erb :'locations/show'
        else 
            redirect '/locations'
        end
    end
end