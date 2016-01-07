class Item < ActiveRecord::Base
	belongs_to :group
	has_many :lists
	has_many :users, through: :lists
	belongs_to :user
end
