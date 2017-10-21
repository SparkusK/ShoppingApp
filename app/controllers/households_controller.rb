class HouseholdsController < ApplicationController
  before_action :set_household, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create, :new, :leave, :leave_member]
  before_action :confirm_user_is_head, only:
     [:leave_with_delete,
      :leave_with_transfer,
      :kick_member,
      :close_household,
      :open_household]
  before_action :confirm_member_belongs_to_current_household, only: [:kick_member]

  # GET /households
  # GET /households.json
  def index
    @households = Household.all.paginate(page: params[:page])
  end

  # GET /households/1
  # GET /households/1.json
  def show
  end

  # GET /leave_household/<user.id>
  def leave
    respond_to do |format|
      format.html {
        # If there's only one user in the household, confirm that the household will be deleted
        if @user.household.users.count == 1
          render 'leave_with_delete'
        else
          # If there are more members and the leaving user is the head, transfer the ownership to another member
          if @user.household.user_id == @user.id
            render 'leave_with_transfer'
          else
            # Just remove the member.
            if @user.update_attributes(household_id: nil)
                flash[:success] = "Household left."
                redirect_to root_url
            else
                flash[:error] = "Household wasn't left."
                redirect_back_or(root_url)
            end
          end
        end
      }
      format.json {}
    end
  end

  # GET /search?
  def search
    @households = Household.where(joinable: true).paginate(page: params[:page])
    render 'search'
  end


  # POST /leave_with_delete/:id
  def leave_with_delete
    respond_to do |format|
      # Note that we also destroy all pending applications and invitations to that household, since bads will happen
      # if, eg, another household gets created with a previously-deleted household's ID - in this case, the new household
      # will inherit all of the old household's invitations and applications, which might be accepted, meaning that
      # a user completely unrelated to that household suddenly becomes part of it.
      house_id = @user.household.id
      if (@user.update_attributes(household_id: nil) && Household.find_by(id: house_id).destroy! && Invitation.where(household_id: house_id).delete_all) && ShoppingList.find_by(household_id: house_id).delete!
        format.html {
          flash[:success] = "Household left and deleted, pending invitations and applications also destroyed."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Household wasn't deleted or left, previous invitations and applications weren't destroyed."
          render 'leave_with_delete'
        }
      end
    end
  end

  # POST /leave_with_transfer/:old/:new
  def leave_with_transfer
    respond_to do |format|
      if @user.household.update_attributes(user_id: params[:new]) && @user.update_attributes(household_id: nil)
        format.html {
          flash[:success] = "Household left and ownership thereof transfered."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Household ownership wasn't transferred and household wasn't left."
          render 'leave_with_transfer'
        }
      end
    end
  end

  # POST /kick_member/:id
  def kick_member
    # don't kick yourself -- for people trying to be smart
    if @member.id != current_user.id && @membership
      respond_to do |format|
        if @member.update_attributes(household_id: nil)
          format.html {
            flash[:success] = "Member successfully removed."
            redirect_to root_url
          }
        else
          format.html {
            flash[:error] = "Member couldn't be removed."
            redirect_to root_url
          }
        end
      end
    end
  end

  # POST /leave_member/:id
  def leave_member
    respond_to do |format|
      if @user.update_attributes(household_id: nil)
        format.html {
          flash[:success] = "Household left."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Household wasn't left."
          redirect_back_or(root_url)
        }
      end
    end
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
    @household.user_id = current_user.id
    @household.joinable = true
    @shoppinglist = ShoppingList.create(items: [])
    respond_to do |format|
      if @household.save && @user.update_attributes(:household_id => @household.id) && @shoppinglist.update_attributes(household_id: @household.id)
        # If the user created a new household and became the head of that household,
        # we want to clear the database of applications to households from that particular user,
        # because if the head of one of the households decides to then accept the application from
        # the user that created the new one, undesired results will happen:
        # What if the new household has other members in it when the other household decides to accept
        # the old application? Should the household be deleted? Should ownership be moved?
        # There are too many variables. Just delete the applications.
        #
        # On the other hand, invitations should stay, because the user that created the new household
        # can control the side-effects as if they're just leaving the household.
        Invitation.where(user_id: @user.id, is_invitation: false).delete_all
        format.html {
          flash[:success] = "Household created, you became a member, and you got assigned as the head. All your previous household applications were also automatically rescinded."
          redirect_to root_url
        }
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

  def open_household
    respond_to do |format|
      if Household.find_by(id: params[:household_id]).update_attributes(joinable: true)
        format.html {
          flash[:success] = "Other members can now apply to join the household."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Could not open the household for other members to join."
          redirect_to root_url
        }
      end
    end
  end

  def close_household
    respond_to do |format|
      if Household.find_by(id: params[:household_id]).update_attributes(joinable: false)
        format.html {
          flash[:success] = "Other members can not apply to join the household anymore."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Could not close member applications."
          redirect_to root_url
        }
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
      params.require(:household).permit(:name)
    end

    def set_user
      if logged_in? && current_user?(current_user)
        @user = current_user
      else
        @user = nil
        redirect_back_or(root_url)
      end

    end

    def confirm_user_is_head
      if logged_in? && current_user?(current_user) && current_user.id == current_user.household.user.id
        @user = current_user
      else
        @user = nil
        redirect_back_or(root_url)
      end
    end

    def confirm_member_belongs_to_current_household
      @member = User.find_by(id: params[:member_id])
      @membership = @member.household_id == current_user.household_id
    end
end
