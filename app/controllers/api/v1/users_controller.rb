class Api::V1::UsersController < ApplicationController

  def index
    users = User.all.select{|user| user.name.is_a? String}
    usernames = users.map { |user|  user.name}
    render json: usernames
  end

  # def create
  #   # byebug
  # 	user = User.find_or_create_by(name: user_params[:name])
  #   user.email = user_params[:email]
  #   user.high_score = user_params[:high_score]
  #   user.save
  # 	render json: user
  # end
  #
  # private
  # def user_params
  # 	params.require(:users).permit(:name, :email, :high_score)
  # end

end
