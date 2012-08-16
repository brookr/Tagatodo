class Todo < ActiveRecord::Base
  attr_accessible :completed, :notes, :title, :tag_list

  belongs_to :user

  acts_as_taggable
end
