class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter :app_init

  rescue_from Gleuch::Unauthorized, with: :unauthorized_request


  # Initialize variables and other items for use on page.
  def app_init
    @body_classes, @breadcrumbs = [], []
    @_static_page_options = {cache: true}.with_indifferent_access
    @page_title = t(:name)
  end

  # Enable force_ssl where required
  def ssl_configured?
    Rails.env.production? || Rails.env.staging?
  end

  def unauthorized_request
    render file: "public/401.html", layout: false, status: :unauthorized
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


  def render_not_found
    raise ActiveRecord::RecordNotFound
  end

  # Render actions for showing an available static page
  def show_static_page(page=nil, *args)
    @_static_page_options.merge!(args.extract_options!)

    respond_to do |format|
      format.html {
        results = -> {
          begin
            send(page.page)
          rescue ActiveRecord::RecordNotFound => err
            raise err
          rescue => err
            nil
          end if respond_to?(page.page)

          @body_classes << "page-#{page.page.gsub(/\/|\-/m, '_').gsub(/("|')/m, '')}"

          render_to_string page.file, @_static_page_options
        }
        
        if @_static_page_options[:cache]
          cache_key = @_static_page_options[:cache_key] unless @_static_page_options[:cache_key].blank?
          cache_key ||= ['page',page.class.to_s.underscore, page.id, page.format]
          html = cache(cache_key, expires_in: @_static_page_options[:cache_expires_in]) { results.call }
        else
          html = results.call
        end

        render text: html, layout: false
      }
      format.any { render_not_found }
    end
  end


  # Check if the request was referred by self
  def request_is_self?
    (request.url == request.referer) rescue false
  end


end
