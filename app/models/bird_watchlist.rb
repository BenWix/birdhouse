class BirdWatchlist < ActiveRecord::Base
    belongs_to :watchlist
    belongs_to :bird
end