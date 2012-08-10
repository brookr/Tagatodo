class Todo < ActiveRecord::Base
  attr_accessible :completed, :notes, :title
end
