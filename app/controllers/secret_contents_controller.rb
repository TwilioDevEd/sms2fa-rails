class SecretContentsController < ApplicationController
  before_action :authenticate!

  def show
    render 'users/top_secret'
  end
end
