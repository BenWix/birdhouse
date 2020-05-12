class Watchlist < ActiveRecord::Base
    belongs_to :user
    has_many :bird_watchlists
    has_many :birds, through: :bird_watchlists

    def get_bird_hash
        bird_hash = Hash.new(0)
        self.birds.each{|bird| bird_hash[bird.name] += 1}
        bird_hash
    end
end