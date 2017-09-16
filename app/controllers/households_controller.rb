class HouseholdsController < ApplicationController
  before_action :set_household, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create, :new]

  # GET /households
  # GET /households.json
  def index
    @households = Household.all
  end

  # GET /households/1
  # GET /households/1.json
  def show
  end

  # GET /households/new
  def new
    @household = Household.new
    @household.name = @user.surname + " Household"
    @household.user_id = current_user.id
  end

  # GET /households/1/edit
  def edit
  end

  # POST /households
  # POST /households.json
  def create
    @household = Household.new(household_params)
    respond_to do |format|
      if @household.save
        @user.update_attributes(:household_id => @household.id)
        format.html { redirect_to @household, notice: 'Household was successfully created.' }
        format.json { render :show, status: :created, location: @household }
      else
        format.html { render :new }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /households/1
  # PATCH/PUT /households/1.json
  def update
    respond_to do |format|
      if @household.update(household_params)
        format.html { redirect_to @household, notice: 'Household was successfully updated.' }
        format.json { render :show, status: :ok, location: @household }
      else
        format.html { render :edit }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1
  # DELETE /households/1.json
  def destroy
    @household.destroy
    respond_to do |format|
      format.html { redirect_to households_url, notice: 'Household was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_household
      @household = Household.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def household_params
      params.require(:household).permit(:name, :user_id)
    end

    def set_user
      if logged_in? && current_user?(current_user)
        @user = current_user
      else
        @user = nil
        redirect_back_or(root_url)
      end

    end
end
