class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |user| user.to_pleasant_string }.join("\n")
  end

  def login
    email = params[:email]
    password = params[:password]
    user = User.any? { |user| user.email == email and user.password == password }
    render plain: user
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    new_user = User.create!(name: name,
                            email: email,
                            password: password)
    response_text = "your login credentials are created !  #{new_user.name}"
    render plain: response_text
  end
end
