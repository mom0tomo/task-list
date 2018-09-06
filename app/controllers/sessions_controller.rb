class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]

    if login(email, password)
      flash[:success]
      redirect_to @user
    else
      render :new
    end
  end

  def update
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to login_url
  end

  private

    def login(email, password)
      @user = User.find_by(email: email)
      if @user && @user.authenticate(password)
        session[:user_id] = @user.id
        true
      else
        false
      end
    end
end
