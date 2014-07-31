module Pageable
  extend ActiveSupport::Concern

  included do
    # include ActionDispatch::Routing::UrlFor
    # include Rails.application.routes.url_helpers
  end

  attr_accessor :view_path, :format


  def initialize(*args)
    set_options(*args)
    super
  rescue ArgumentError
    # a bit hacky, but defined?(super) doesn't work properly with some classes, causes ArgumentError
  end

  def set_options(*args)
    @options    = ActiveSupport::HashWithIndifferentAccess.new.merge(view_path: 'static_pages', format: 'html').merge(args.extract_options!)
    @id         = @options[:id]
    @format     = @options[:format]
    @view_path  = @options[:view_path]
  end

  # Routing check
  def matches?(r)
    return false if r.path_parameters[:id].blank?
    set_options(r.path_parameters)
    self.exists?
  end

  # Setups for filename, page, format, and view path folder
  def file; (!self.page.blank? ? File.join(self.view_path, self.page) : nil).downcase; end
  def page; (@id || '').parameterize.underscore; end
  def format; @format; end
  def view_path; @view_path; end

  # Check if page exists
  def exists?(format=nil)
    return false if self.page.blank?
    fpath = File.join(Rails.root, 'app/views', self.view_path, "#{self.page}.#{self.format}.haml")
    return false unless fpath.match(/\/app\/views\//) # dirup hack prevention
    File.exists?(fpath) && File.readable?(fpath)
  end

  # Generate list of available pages
  def self.available_pages(f=:html)
    Dir.glob(File.join('app/views', self.view_path, "*.#{f.to_s}.haml")).map{|f| File.basename(f).split('.')[0]}
  end

end