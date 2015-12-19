class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :proposal

	validates :body_text, presence: true
end
