class StaticPagesController < ApplicationController

  before_filter :load_static_page_resource, only: [:show]

  # layout 'post'

  def index
    load_static_page_resource(id: 'home', format: request.format.symbol.to_s)
    impressionist(@static_page) unless request_is_self?
    show_static_page(@static_page)
  end

  def show
    impressionist(@static_page) unless request_is_self?
    show_static_page(@static_page)
  end


protected


end