class BirthdaysController < ApplicationController
  before_action :set_birthday, only: %i[ show edit update destroy ]
  before_action :initialize_sort, only: :index

  def index
    @birthdays = Birthday.all
    handle_sort
    handle_response
  end

  def show
  end
  def new
    @birthday = Birthday.new
  end
  def edit
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
  def update
    respond_to do |format|
      if @birthday.update(birthday_params)
        format.html { redirect_to @birthday, notice: "Birthday was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @birthday.destroy!

    flash[:success] = "Birthday was successfully deleted."
    redirect_to birthdays_path
  end

  private

    def set_birthday
      @birthday = Birthday.find(params.expect(:id))
    end

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
