class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :app_init
  
  
  def app_init
    @body_classes = []
    @_static_page_options = {}.with_indifferent_access
    @page_title = t(:name)
  end



private

  def load_and_show_static_page(*args)
    load_static_page_resource(*args)
    show_static_page
  end

  def load_static_page_resource(*args)
    opts = (args.extract_options!).merge(params)
    @static_page = StaticPage.new(opts)
    raise ActiveRecord::RecordNotFound unless @static_page.exists?
  end
  

  def show_static_page(*args)
    @_static_page_options.merge!(args.extract_options!)

    respond_to do |format|
      format.html {
        begin
          send(@static_page.page)
        rescue ActiveRecord::RecordNotFound => err
          raise err
        rescue => err
          nil
        end if respond_to?(@static_page.page)

        @body_classes << 'static-page' << "page-#{@static_page.page.gsub(/\/|\-/m, '_').gsub(/("|')/m, '')}"
        render @static_page.file, @_static_page_options
      }
      format.any { render_not_found }
    end
  end

end
