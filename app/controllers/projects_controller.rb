class ProjectsController < ApplicationController

  before_filter :load_resource, only: [:show]
  before_filter :projects_init

  # layout 'post'

  def index
    load_and_show_static_page(id: 'home', format: request.format.symbol.to_s, view_path: 'projects')
  end

  def list
    @projects_list = t('projects.full_list')
  end

  def show
    show_static_page
  end


protected

  def projects_init
    # @_static_page_options[:layout] = 'projects'
  end

  def load_resource
    load_static_page_resource(view_path: 'projects')
  end

end