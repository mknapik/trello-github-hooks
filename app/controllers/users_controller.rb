class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.select {|user| can? :view, user}
  end

  # GET /users/1
  # GET /users/1.json
  def show
    access_denied! 'cannot.view.user', users_path if cannot? :edit, @user
  end

  # GET /users/1/edit
  def edit
    access_denied! 'cannot.edit.user', users_path if cannot? :edit, @user
  end

  # GET /users/1/edit
  def edit_token
    @user = User.find(params[:user_id])
    access_denied! 'cannot.edit.user', users_path if cannot? :edit, @user

    @user.trello_token = params[:token] unless params[:token].blank?
    redirect_to @user, notice: 'Fill up API key first!' if @user.trello_api_key.blank?
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    access_denied! 'cannot.edit.user', users_path if cannot? :edit, @user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1/token
  # PATCH/PUT /users/1/token.json
  def update_token
    @user = User.find(params[:user_id])
    access_denied! 'cannot.edit.user', users_path if cannot? :edit, @user

    respond_to do |format|
      if @user.update(params.require(:user).permit(:trello_token))
        format.html { redirect_to @user, notice: 'Token was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit_token' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    access_denied! 'cannot.delete.user', users_path if cannot? :edit, @user

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def profile
    @user = current_user
    access_denied! 'cannot.view.user', users_path if cannot? :edit, @user

    render :show
  end

  def edit_profile
    @user = current_user
    access_denied! 'cannot.edit.user', profile_path if cannot? :edit, @user

    render :edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :trello_api_key)
    end
end
