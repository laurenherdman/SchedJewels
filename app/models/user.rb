class User < ActiveRecord::Base

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
    										 token: access_token.credentials.token)
    end
    user
	end
end
