class StaticPagesController < ApplicationController

  force_ssl if: :ssl_configured?

  before_filter :load_resource, only: [:show]
  before_filter :static_pages_init


  def index
    load_resource(id: 'home', format: request.format.symbol.to_s)
    impressionist(@static_page) unless request_is_self?
    @featured_projects = t('projects.featured_list')
    @featured_works = t('client_works.featured_list')
    show_static_page(@static_page)
  end

  def show
    impressionist(@static_page) unless request_is_self?
    show_static_page(@static_page)
  end


protected

  def static_pages_init
    #
  end

  def load_resource(*args)
    opts = {}.merge(args.extract_options!).merge(static_page_params)
    @static_page = StaticPage.new(opts)
    raise ActiveRecord::RecordNotFound unless @static_page.exists?
  end

  def static_page_params
    params.permit(:id, :format)
  end

end