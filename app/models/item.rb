class Item < ActiveRecord::Base
	belongs_to :group
	belongs_to :lists
	has_many :users, through: :lists
	belongs_to :user
end
