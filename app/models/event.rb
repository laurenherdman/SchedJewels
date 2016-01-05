require 'google/api_client'

class Event < ActiveRecord::Base
	belongs_to :user
	has_one :proposal

  validates_uniqueness_of :google_event_id
  before_validation :add_to_calendar, if: :not_yet_added


	after_commit on: :create

  def not_yet_added
    self.google_event_id.nil?
  end

  def self.google_client(user)
  	# user = self.user
    # Application name is what you named it in Google Developer Console
    google_api_client = Google::APIClient.new({
      application_name: 'schedjewels2'
    })
    google_api_client.authorization = Signet::OAuth2::Client.new({
      client_id: ENV["GOOGLE_KEY"],
      client_secret: ENV["GOOGLE_SECRET"],
      access_token: user.token,
      refresh_token: user.refresh_token,
      :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
      :token_credential_uri =>  'https://www.googleapis.com/oauth2/v3/token'

    })
    return google_api_client
  end

	def get_all_calendars(user)
	  client = Event.google_client(user)
	  service = client.discovered_api('calendar', 'v3')
	  @result = client.execute(
	    :api_method => service.calendar_list.list,
	    :parameters => {},
	    :headers => {'Content-Type' => 'application/json'})
	end

  def get_calendar(user)
    client = Event.google_client(user)
    service = client.discovered_api('calendar', 'v3')
    @result = client.execute(
      :api_method => service.calendars.get,
      :parameters => {'calendarId' => 'primary' },
      :headers => {'Content-Type' => 'application/json'})
  end

  def start_date_time
    sd = proposal.start_date
    st = proposal.start_time.in_time_zone('Islamabad')


    sdt = DateTime.new(sd.year, sd.month, sd.day, st.hour, st.min)

  end

  def end_date_time
    ed = proposal.end_date
    et = proposal.end_time.in_time_zone('Islamabad')


    edt = DateTime.new(ed.year, ed.month, ed.day, et.hour, et.min)
  end

  def add_to_calendar
    client = Event.google_client(self.user)
    service = client.discovered_api('calendar', 'v3')
    @result = client.execute(
      :api_method => service.events.insert,
      :parameters => {'calendarId' => 'primary' },
      :body_object => {'summary' => self.title, 
                       'description' => self.description, 
                       'location' => self.location,  
                       'start' => { 'dateTime' => self.start_date_time}, 
                       'end' => { 'dateTime' => self.end_date_time },
                       'attendees' => self.proposal.attendee_array,
                       'reminders' => {
                              'useDefault' => false,
                              'overrides' => [
                                {'method' => 'email', 'minutes' => 24 * 60},
                                {'method' => 'popup', 'minutes' => 10},
                              ], 
                            }, 
                        },

      :headers => {'Content-Type' => 'application/json'})
    googleeventid = JSON.load(@result.response.body)["id"]
    self.update_attributes(google_event_id: googleeventid)
  end

  def self.show_calendar(user)
    client = Event.google_client(user)
    service = client.discovered_api('calendar', 'v3')
    @result = client.execute(

      :api_method => service.events.list,
      :parameters => {'calendarId' => 'primary' })
    JSON.load(@result.response.body)["items"]

  end

  # def start_time
  #   self.start_date_time if proposal
  #   ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  # end

end
