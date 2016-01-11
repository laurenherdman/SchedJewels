class Group < ActiveRecord::Base
	has_many :users
	belongs_to :owner, :class_name => "User"
	has_many :lists
	has_many :items, through: :lists
	has_many :comments
	has_many :commenting_users, through: :comments, :source => :user
	accepts_nested_attributes_for :lists
	accepts_nested_attributes_for :items
end
