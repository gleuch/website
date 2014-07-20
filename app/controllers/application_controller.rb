class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter :app_init


  # Initialize variables and other items for use on page.
  def app_init
    @body_classes = []
    @_static_page_options = {}.with_indifferent_access
    @page_title = t(:name)
  end

  # Enable force_ssl where required
  def ssl_configured?
    false # Rails.env.production?
  end


private

  def set_session
    # R1 = first time referrer
    session[:id] = SecureRandom.hex(16)
    session[:r1] = case request.referrer
      when /facebook\.com|fb\.me/i;   "facebook"
      when /twitter\.com|t\.co/i;     "twitter"
      when /youtu\.be|youtube\.com/i; "youtube"
      when /plus\.google\.com/i;      "gplus"
      when /google\.([a-z\.])+|bing\.com|yahoo\.(([a-z\.])+)/; "search"
      when /\w+/;   "web"
      else;         "direct"
    end
  end

  def store_location(u=nil)
    uri ||= request.get? ? request.request_uri : request.referer
    session[:return_to] = uri
  end

  def redirect_back_or_default(uri, *args)
    opts = args.extract_options!
    redirect_to(session.delete(:return_to) || request.referer || uri, opts)
  end


  # Load a static page item
  def load_static_page_resource(*args)
    opts = (args.extract_options!).merge(params)
    @static_page = StaticPage.new(opts)
    raise ActiveRecord::RecordNotFound unless @static_page.exists?
  end

  # Render actions for showing an available static page
  def show_static_page(page=nil, *args)
    @_static_page_options.merge!(args.extract_options!)

    respond_to do |format|
      format.html {
        begin
          send(page.page)
        rescue ActiveRecord::RecordNotFound => err
          raise err
        rescue => err
          nil
        end if respond_to?(page.page)

        @body_classes << "page-#{page.page.gsub(/\/|\-/m, '_').gsub(/("|')/m, '')}"
        render page.file, @_static_page_options
      }
      format.any { render_not_found }
    end
  end

  # Method to lad and show a static page
  def load_and_show_static_page(*args)
    load_static_page_resource(*args)
    show_static_page(@static_page)
  end


  # Check if the request was referred by self
  def request_is_self?
    (request.url == request.referer) rescue false
  end


end
