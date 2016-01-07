class User < ActiveRecord::Base
  has_many :owned_proposals, :class_name => 'Proposal', :foreign_key => :owner_id
  has_many :events
  has_many :votes
  has_and_belongs_to_many :proposals
  has_many :items
  has_many :groups
  has_many :lists

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  # def self.find_or_create_for_google_oauth2(access_token)
 #    data = access_token.info
 #    user = User.find_by(email: data.email)

 #    unless user
 #      user = User.create(name: data["name"],
 #                         email: data["email"],
 #                         provider: access_token.provider,
 #                         uid: access_token.uid,
 #                         token: access_token.credentials.token,
 #                         refresh_token: access_token.credentials.refresh_token)
 #    end
 #    user
  # end

  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(:email => data["email"]).first

      # Uncomment the section below if you want users to be created if they don't exist
      unless user
          user = User.create(name: data["name"],
             email: data["email"],
             password: Devise.friendly_token[0,20],
             provider: access_token.provider,
             uid: access_token.uid,
             token: access_token.credentials.token,
             refresh_token: access_token.credentials.refresh_token
          )
      end
      user
  end

end