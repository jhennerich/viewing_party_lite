# frozen_string_literal: true

class DiscoverController < ApplicationController
  def index
    binding.pry
    @user = User.find(current_user.id)
  end
end
