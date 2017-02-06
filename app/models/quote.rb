class Quote < ActiveRecord::Base
  enum category: [:motivation, :travel, :fitness]
end
