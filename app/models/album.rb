class Album < ActiveRecord::Base
  belongs_to :order
  has_many :results
end
