class HomesController < ApplicationController

  allow_unauthenticated_access only: [:top, :about]

  def top
    #puts "TOP ACTION"
  end

  def about
  end
end
