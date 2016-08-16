class UsersController < ApplicationController
  before_action :require_correct_user, only: [:edit, :update]
    def new
    end

    def createlender
      userparams = params.require(:user).permit(:first_name, :last_name, :email, :money, :password, :password_confirmation)
      userparams[:status] = "lender"
      user = User.new(userparams)
      if user.valid? && user.save
        session[:user_id] = user.id
        user = User.find(session[:user_id])
        redirect_to '/transactions/lender/' + session[:user_id].to_s
      else
      # If user's login doesn't work, send them back to the login form.
        flash[:notice] = user.errors.full_messages
        redirect_to '/users/new'
      end
    end

    def createborrower
      userparams = params.require(:user).permit(:first_name, :last_name, :email, :money, :password, :password_confirmation)
      userparams[:status] = "borrower"
      requestparams = params.require(:request).permit(:title, :description, :amount)
      user = User.new(userparams)
      if user.valid? && user.save
        session[:user_id] = user.id
        user = User.find(session[:user_id])
        Request.create(user:user, title: requestparams[:title], description:requestparams[:description], amount: requestparams[:amount])
        redirect_to '/transactions/borrower/' + session[:user_id].to_s
      else
      # If user's login doesn't work, send them back to the login form.
        flash[:notice] = user.errors.full_messages
        redirect_to '/users/new'
      end
    end
end
