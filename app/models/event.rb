require 'google/api_client'

class Event < ActiveRecord::Base
	belongs_to :user
	has_many :proposals

	after_commit on: :create

  def google_client(user)
  	# user = self.user
    # Application name is what you named it in Google Developer Console
    google_api_client = Google::APIClient.new({
      application_name: 'schedjewels2'
    })
    google_api_client.authorization = Signet::OAuth2::Client.new({
      client_id: ENV["GOOGLE_KEY"],
      client_secret: ENV["GOOGLE_SECRET"],
      access_token: user.token
    })
    return google_api_client
  end

	def get_all_calendars(user)
	  client = google_client(user)
	  service = client.discovered_api('calendar', 'v3')
	  @result = client.execute(
	    :api_method => service.calendar_list.list,
	    :parameters => {},
	    :headers => {'Content-Type' => 'application/json'})
	end

  def add_to_calendar(user)
    client = google_client(user)
    service = client.discovered_api('calendar', 'v3')
    @result = client.execute(
      :api_method => service.events.quick_add,
      :parameters => {'calendarId' => 'primary', 'text' => self.title},
      :headers => {'Content-Type' => 'application/json'})
  end

end
