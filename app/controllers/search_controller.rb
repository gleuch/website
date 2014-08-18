class SearchController < ApplicationController

  force_ssl if: :ssl_configured?


  def index
    @search_results, @search_query = [], params[:q]

    @section, @page_meta_type = :projects, :project
    @breadcrumbs << {name: t('breadcrumbs.search'), url: search_url}

    if @search_query.present? && @search_query.length > 2
      @page_meta_robots = 'noindex,nofollow'
      @breadcrumbs << {name: @search_query}

      # Cache this result since it does not change much
      cache_key = ['search_results', @search_query.strip.downcase]
      @search_results = cache(cache_key, expires_in: 1.month) do
        search_results, search_regexp = [], Regexp.new(@search_query.strip.downcase, true)

        # Search through list with weighted ranking
        search_list.compact.each do |k,v|
          begin
            rank = 0
            rank += 5 if v[:page_title].match(search_regexp)
            rank += 4 if v[:meta].present? && (v[:meta][:description] || '').match(search_regexp)
            rank += 3 if %w(description solution explanation statement about).map{|a| v[a.to_sym] || nil}.compact.join('').match(search_regexp)
            rank += 2 if v[:tags].present? && (v[:tags] || []).join('').match(search_regexp)
            rank += 1 if v.reject{|k,v| %w(page_title meta tags description solution explanation statement about).include?(k.to_s)}.to_s.match(search_regexp)
            (search_results << v.merge(id: k, rank: rank)) if rank > 0
          rescue
            next
          end
        end

        # Sort through list, rank desc, name asc
        search_results.compact.uniq.sort do |a,b|
          res = b[:rank] <=> a[:rank] # rank score desc
          res = a[:page_title] <=> b[:page_title] if res == 0 # page title asc if rank is equal
          res
        end
      end
    end

    respond_to do |format|
      format.html { render :index }
      format.any { render_not_found }
    end
  end

  def tags
    @search_results, @search_query = [], params[:id]

    @section, @page_meta_type = :projects, :project
    @breadcrumbs << {name: t('breadcrumbs.tag'), url: search_url}

    if @search_query.present? && @search_query.length > 2
      @page_meta_robots = 'noindex,nofollow'
      @breadcrumbs << {name: @search_query}

      # Cache this result since it does not change much
      cache_key = ['search_tags', @search_query.strip.downcase]
      @search_results = cache(cache_key, expires_in: 1.month) do
        search_results, search_regexp = [], Regexp.new(@search_query.strip.downcase, true)

        # Search through list with weighted ranking
        search_list.compact.each do |k,v|
          begin
            (search_results << v.merge(id: k)) if v[:tags].present? && (v[:tags] || []).join('').match(search_regexp)
          rescue
            next
          end
        end

        # Sort through list alphabetically
        search_results.compact.uniq.sort{|a,b| a[:page_title] <=> b[:page_title] }
      end
    end

    # Do not render page if tag does not exist, therefore render 404
    raise ActiveRecord::RecordNotFound if @search_results.blank?

    respond_to do |format|
      format.html { render :tags }
      format.any { render_not_found }
    end
  end


protected

  # Get list of pages to search through. Merged together from client work and projects, tagged accordingly
  def search_list
    ignored = [:all, :index, :home, :footer, :headings, :full_list]
    projects_list = I18n.t('projects')
    works_list = I18n.t('client_works')
    pages_list = I18n.t('static_pages')

    projects_list = projects_list.select{|v| Project.new(id: v, view_path: Project.view_path).exists? }.each{|k,v| projects_list[k][:type] = 'project'}
    works_list = works_list.select{|v| ClientWork.new(id: v, view_path: ClientWork.view_path).exists? }.each{|k,v| works_list[k][:type] = 'client_work'}
    pages_list = pages_list.select{|v| StaticPage.new(id: v).exists? }.each{|k,v| pages_list[k][:type] = 'static_page'}

    {}.merge(projects_list).merge(works_list).merge(pages_list).reject{|k,v| ignored.include?(k.to_sym) }
  end

end
