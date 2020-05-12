class Location < ActiveRecord::Base
    has_many :watchlists
    has_many :birds, through: :watchlists
end