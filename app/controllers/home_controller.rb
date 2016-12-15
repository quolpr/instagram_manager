class HomeController < ApplicationController
  def index
    render json: HomeSerializer.new({}).to_hash
  end
end
