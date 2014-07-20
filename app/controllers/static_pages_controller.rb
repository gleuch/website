class StaticPagesController < ApplicationController

  before_filter :load_static_page_resource, only: [:show]

  # layout 'post'

  def index
    load_and_show_static_page(id: 'home', format: request.format.symbol.to_s)
  end

  def show
    show_static_page(@static_page)
  end

  # Livestream page for Samsung + WT contest.
  # def hope4children
  #   @_static_page_options[:layout] = false
  #   @_hide_ads = true
  # end


protected


end