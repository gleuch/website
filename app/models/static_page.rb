class StaticPage

  # include ActionDispatch::Routing::UrlFor
  # include Rails.application.routes.url_helpers


  def initialize(*args)
    set_options(*args)
  end

  def set_options(*args)
    @options = ActiveSupport::HashWithIndifferentAccess.new.merge(view_path: 'static_pages', format: 'html').merge(args.extract_options!)
    @page       = @options[:id]
    @format     = @options[:format]
    @view_path  = @options[:view_path]
  end

  def matches?(r)
    return false if r.path_parameters[:id].blank?
    set_options(r.path_parameters)
    self.exists?
  end

  def file; (!self.page.blank? ? File.join(self.view_path, self.page) : nil).downcase; end
  def page; (@page || '').gsub(/\-/m, '_').downcase; end
  def format; @format; end
  def view_path; @view_path; end

  def exists?(format=nil)
    return false if self.page.blank?
    fpath = File.join(Rails.root, 'app/views', self.view_path, "#{self.page}.#{self.format}.haml")
    return false unless fpath.match(/\/app\/views\//) # dirup hack prevention
    File.exists?(fpath) && File.readable?(fpath)
  end

  def self.available_pages(f=:html)
    Dir.glob(File.join('app/views', self.view_path, "*.#{f.to_s}.haml")).map{|f| File.basename(f).split('.')[0]}
  end


protected


end
