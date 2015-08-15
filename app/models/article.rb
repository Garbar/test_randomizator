class Article < ActiveRecord::Base
  belongs_to :city
  belongs_to :site
  validates_presence_of :title
end
