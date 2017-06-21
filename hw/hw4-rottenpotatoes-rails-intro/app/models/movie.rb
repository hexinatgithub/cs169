class Movie < ActiveRecord::Base
    def self.ratings
        select(:rating).group(:rating)
    end
end
