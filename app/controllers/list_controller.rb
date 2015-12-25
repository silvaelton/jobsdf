class ListController < ApplicationController
  
  def index
    @list = ListJob.all.order('date DESC')
  end
    
  def sync
    ::Collector::collect!
    redirect_to action: 'index'
  end
end