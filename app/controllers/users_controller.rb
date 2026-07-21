class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def index
    @users = User.all
    @user = Current.user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  
    unless @user == Current.user      #他人の編集画面へ入れないように
      redirect_to user_path(Current.user)
    end
  end

  def update
    @user = User.find(params[:id])
  
    unless @user == Current.user
      redirect_to user_path(Current.user)
      return
    end
  
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    if request.path == new_user_path
      redirect_to sign_up_path and return
    end
  
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for(@user)
      redirect_to user_path(@user), notice: "Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email_address,
      :password,
      :password_confirmation,
      :introduction,
      :profile_image
    )
  end
end