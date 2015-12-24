class ListController < ApplicationController
  def index
    @list = ListJob.all.order('date DESC')
  end
  
end