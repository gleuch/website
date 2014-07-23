class ClientWorksController < ApplicationController

  before_filter :load_resource, only: [:show]
  before_filter :client_works_init

  # layout 'post'


  def index
    load_resource(id: 'home', format: request.format.symbol.to_s)
    impressionist(@client_work) unless request_is_self?
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
  end

  def load_resource(*args)
    opts = {view_path: 'client_works'}.merge(args.extract_options!).merge(client_work_params)
    @client_work = ClientWork.new(opts)
    raise ActiveRecord::RecordNotFound unless @client_work.exists?
  end

  def client_work_params
    params.permit(:id, :format)
  end

end