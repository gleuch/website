class ClientWorksController < ApplicationController

  force_ssl if: :ssl_configured?

  before_filter :load_resource, only: [:show]
  before_filter :client_works_init
  before_filter :client_work_init, only: [:show]


  def index
    load_resource(id: 'home', format: request.format.symbol.to_s)
    impressionist(@client_work) unless request_is_self?
    @body_classes << 'work' << 'client-work' << 'work-home'
    @featured_works = t('client_works.featured_list').reject{|v| v[:hide]}
    show_static_page(@client_work)
  end

  def show
    impressionist(@client_work) unless request_is_self?
    show_static_page(@client_work)
  end


  # Custom Project Pages
  def all
    @client_works_list = t('client_works.full_list')
  end


protected

  def client_works_init
    @section, @page_meta_type = :client_work, :work
    @breadcrumbs << {name: t('breadcrumbs.works'), url: client_works_url}
  end

  def client_work_init
    @body_classes << 'work' << 'client-work'
    @canonical_url = client_work_url(@client_work.slug, host: 'gleu.ch', port: nil)
  end

  def load_resource(*args)
    opts = {view_path: ClientWork.view_path}.merge(args.extract_options!).merge(client_work_params)
    @client_work = ClientWork.new(opts)
    raise ActiveRecord::RecordNotFound unless @client_work.exists?
  end

  def client_work_params
    params.permit(:id, :format)
  end

end