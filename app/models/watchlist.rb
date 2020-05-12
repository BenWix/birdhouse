class Watchlist < ActiveRecord::Base
    belongs_to :user
    belongs_to :location
    has_many :bird_watchlists
    has_many :birds, through: :bird_watchlists

    def get_bird_hash
        bird_hash = Hash.new(0)
        self.birds.each{|bird| bird_hash[bird.name] += 1}
        bird_hash
    end

    def self.rare_birds
        bird_hash = Hash.new(0)
        self.all.each do |list|
            list.birds.each{|bird| bird_hash[bird.name] += 1}
        end
        bird_hash.sort_by{|bird, count| count}[0..4]
    end
end