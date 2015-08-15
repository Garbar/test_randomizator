class Site < ActiveRecord::Base
  has_many :articles
  has_many :randomizators
end
