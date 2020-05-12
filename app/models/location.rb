class Location < ActiveRecord::Base
    has_many :watchlists
    has_many :birds, through: :watchlists

    def common_birds
        bird_hash = Hash.new(0)
        self.birds.each do |bird|
            bird_hash[bird.name] += 1
        end
        bird_hash.sort_by{|bird, count| count}.reverse[0...4]
    end
end