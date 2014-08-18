class ProjectsController < ApplicationController

  force_ssl if: :ssl_configured?

  before_filter :load_resource, only: [:show]
  before_filter :projects_init
  before_filter :project_init, only: [:show]


  def index
    load_resource(id: 'home', format: request.format.symbol.to_s)
    impressionist(@project) unless request_is_self?
    show_static_page(@project)
  end

  def show
    impressionist(@project) unless request_is_self?
    show_static_page(@project)
  end


  # Custom Project Pages
  def all
    @projects_list = t('projects.full_list')
  end


protected

  def projects_init
    @section, @page_meta_type = :projects, :project
    @breadcrumbs << {name: t('breadcrumbs.projects'), url: projects_url}
  end

  def project_init
    @body_classes << 'project'
    @canonical_url = project_url(@project.slug, host: 'gleu.ch', port: nil)
  end

  def load_resource(*args)
    opts = {view_path: Project.view_path}.merge(args.extract_options!).merge(project_params)
    @project = Project.new(opts)
    raise ActiveRecord::RecordNotFound unless @project.exists?
  end

  def project_params
    params.permit(:id, :format)
  end

end