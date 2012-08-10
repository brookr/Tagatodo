class Todo < ActiveRecord::Base
  attr_accessible :completed, :notes, :title

  belongs_to :user
end
