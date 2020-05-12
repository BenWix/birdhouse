class Bird < ActiveRecord::Base
    has_many :bird_watchlists
    has_many :watchlists, through: :bird_watchlists
    has_many :users, through: :watchlists
    has_many :locations, through: :watchlists
end