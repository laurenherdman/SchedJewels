class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :proposal
	belongs_to :group

	validates :body_text, presence: true
end
