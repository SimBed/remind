class BirthdaysController < ApplicationController
  before_action :initialize_sort, only: :index

  def index
    @birthdays = Birthday.all
    handle_sort
    handle_response
  end

  def new
    @birthday = Birthday.new
  end

  def create
    @birthday = Birthday.new(birthday_params)

    if @birthday.save
      flash[:success] = "Birthday was successfully added."
      redirect_to birthdays_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @birthday = Birthday.find(params.expect(:id))
    @birthday.destroy!

    flash[:success] = "Birthday was successfully deleted."
    redirect_to birthdays_path
  end

  private

    def initialize_sort
      session[:birthday_sort_option] = params[:birthday_sort_option] || session[:birthday_sort_option] || "upcoming"
    end

    def handle_sort
      @birthdays = @birthdays.send("order_by_#{session[:birthday_sort_option]}")
    end

    def handle_response
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end

    def birthday_params
      params.expect(birthday: [ :first_name, :last_name, :date ])
    end
end
