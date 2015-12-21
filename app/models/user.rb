class User < ActiveRecord::Base
  has_many :owned_proposals, :class_name => 'Proposal', :foreign_key => :owner_id
  has_many :events
  has_many :votes
  has_and_belongs_to_many :proposals
  scope :event_create, lambda { where('event. = ?', Date.today) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

	def self.find_or_create_for_google_oauth2(access_token)
    data = access_token.info
    user = User.find_by(email: data.email)

    unless user
    	user = User.create(name: data["name"],
    										 email: data["email"],
    										 provider: access_token.provider,
    										 uid: access_token.uid,
    										 token: access_token.credentials.token,
                         refresh_token: access_token.credentials.refresh_token)
    end
    user
	end

  def self.send_event
    self.event_create.each do |user|
      EventCreateJob.enqueue(user.id)
    end
  end
end
