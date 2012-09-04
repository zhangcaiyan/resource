# coding: utf-8 
#
class AdminController < ApplicationController

  before_filter :authenticate_user!

  def index
  end

end
