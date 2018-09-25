class UsersController < Clearance::UsersController

  def index
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    render 'users/show'
  end

  def edit
    @user = User.find(params[:id])
    render 'users/edit'
  end

  def new
    @user = User.new
    render "users/new"
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render "users/new"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    flash[:success] = "Successfully edited profile!"
    redirect_to user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :name, :avatar)
  end
end
