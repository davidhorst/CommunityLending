class TransactionsController < ApplicationController
  def lender
    @current_user = User.find(session[:user_id])
    @needs = Request.all
    @loans = Transaction.where(lender:current_user)
  end

  def borrower
      @current_user = current_user
      user = User.find(session[:user_id])
      @transactions = Transaction.where(borrower: user)
      @request = Request.where(user: user).limit(1)
  end

  def create
    loanparams = params.require(:loan).permit(:amount, :to, :for)
    borrower = User.find(loanparams[:to])
    request = Request.find(loanparams[:for])
    Transaction.create(lender:current_user, borrower:borrower, request:request, amount: loanparams[:amount])
    newval = User.find(session[:user_id]).money - loanparams[:amount].to_f
    User.find(session[:user_id]).update(money: newval)
    redirect_to '/transactions/lender/' + session[:user_id].to_s
  end
end
