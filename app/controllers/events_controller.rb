class EventsController < ApplicationController


    def new
      @event = Event.new
    end

    def create
      @timeslot = Timeslot.find(params[:timeslot])
      @timeslot.proposal.set_time
      @event = Event.new
      @timeslot.proposal.event = @event
      @event.title = @timeslot.proposal.title
      @event.user = current_user
      @event.location = @timeslot.proposal.location
      @event.description = @timeslot.proposal.description
      @event.start_date_time = @timeslot.proposal.start_date_time_proposal
      @event.end_date_time = @timeslot.proposal.end_date_time_proposal

      if @timeslot.proposal.save && @event.save
          redirect_to proposal_path(@timeslot.proposal)
      else
         redirect_to proposal_path(@timeslot.proposal), notice: "Your event did not save."
      end
    end

    def index
      Event.show_calendar(current_user).each do |event|
        start_event = nil
        if event["start"]["dateTime"] == nil
          start_event = DateTime.parse(event["start"]["date"])
        else
          start_event = DateTime.parse(event["start"]["dateTime"])
        end
        end_event = nil
        if event["end"]["dateTime"] == nil
          end_event = DateTime.parse(event["end"]["date"])
        else
          end_event = DateTime.parse(event["end"]["dateTime"])
        end
        e = Event.create({
          user_id: current_user.id,
          start_date_time: start_event,
          end_date_time: end_event,
          location: event["location"],
          description: event["description"],
          title: event["summary"],
          google_event_id: event["id"]
          })

      end

      @events = current_user.events
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      if @event.destroyed?
        unless @event.google_event_id.nil?
          client = Google::APIClient.new
          client.authorization.access_token = current_user.token
          service = client.discovered_api('calendar', 'v3')
          result = client.execute(:api_method => service.events.delete,
                                  :parameters => {'calendarId' => 'schedjewelsapp@gmail.com', 'eventId' => @event.google_event_id})
        end
      end
      redirect_to events_path, notice: "#{@event.title} - has been removed."
    end

    def update
    @event = Event.find(params[:id])


    if @event.update(event_params)
      render :nothing => true

      unless @event.google_event_id.nil?
        client = Google::APIClient.new
        client.authorization.access_token = current_user.token
        service = client.discovered_api('calendar', 'v3')

        result = client.execute(:api_method => service.events.get, :parameters => {'calendarId' => 'schedjewelsapp@gmail.com', 'eventId' => @event.google_event_id } )

        event = result.data
        event.summary = @event.title
        event.start.dateTime = @event.start_time
        event.end.dateTime = @event.end_time
        event.description = @event.description
        event.location = @event.location

        result = client.execute(:api_method => service.events.update,
                                :parameters => {'calendarId' => 'schedjewelsapp@gmail.com', 'eventId' =>  @event.google_event_id},
                                :body_object => event,
                                :headers => {'Content-Type' => 'application/json'})
      end
    else
      render :nothing => true
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :location, :start_date_time, :end_date_time)
    end
end
