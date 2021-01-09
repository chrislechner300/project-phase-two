class Beer < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :style, :brewery
end
