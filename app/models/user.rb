class User < ActiveRecord::Base
    has_secure_password
    has_many :watchlists
    has_many :birds, through: :watchlists
    
    def slug 
        username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
    
    def self.find_by_slug(phrase)
        User.all.each do |user|
            return user if user.slug == phrase
        end
    end

end