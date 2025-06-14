class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update]

  def index
    @events = Event.all
    # if params[:query].present?
    #   sql_subquery = <<~SQL
    #     events.title @@ :query
    #     OR events.description @@ :query
    #     OR stores.name @@ :query
    #   SQL
    #   @events = @events.joins(:store).where(sql_subquery, query: params[:query])
    # end
  end

  def show
    @event = Event.find(params[:id])

    @store = @event.store
    @marker = [{
                lat: @store.latitude,
                lng: @store.longitude,
                info_window_html: render_to_string(partial: "shared/info_window", locals: {point: @store})
              }]
  end

  def new
    @store = Store.find(params[:store_id])
    @event = Event.new
  end

  def create
    @store = Store.find(params[:store_id])
    @event = Event.new(event_params)
    @event.store = @store
    if @event.save
      redirect_to store_path(@event.store), notice: "Événement créé avec succès."
    else
      @order = Order.find_or_create_by(user: current_user, store: @store, status_customer: "pending", status_store: "pending")
      render "stores/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to store_path(@store)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date, :store_id, :photo)
  end
end
