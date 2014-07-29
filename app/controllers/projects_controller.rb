class ProjectsController < ApplicationController

  before_filter :load_resource, only: [:show]
  before_filter :projects_init


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

  def load_resource(*args)
    opts = {view_path: 'projects'}.merge(args.extract_options!).merge(project_params)
    @project = Project.new(opts)
    raise ActiveRecord::RecordNotFound unless @project.exists?
  end

  def project_params
    params.permit(:id, :format)
  end

end