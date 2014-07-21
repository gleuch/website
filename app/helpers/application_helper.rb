module ApplicationHelper

  def page_title
    (@page_title.present? && @page_title) || t(:name)
  end

  def page_meta_description
    (@page_meta_description.present? && @page_meta_description) || t('meta.description')
  end

  def page_meta_keywords
    (@page_meta_keywords.present? && @page_meta_keywords) || t('meta.keywords')
  end

  def page_meta_robots
    'index,follow' # TODO
  end

  def page_meta_image
    '' # TODO
  end

  def page_canonical_url
    (@canonical_url.present? && @canonical_url) || request.url
  end

  def page_share_title
    @page_share_title
  end

  def page_share_description
    @page_share_description
  end

  def page_category
    ''
  end

  def page_is_nsfw?
    @page_nsfw || false
  end

  def page_type_is?(type)
    about_types, article_types = %w(about profile), %w(project client_work post work lab)
    case type.to_s
      when 'profile'
        about_types.include?(@page_type)
      when 'article'
        article_types.include?(@page_type)
      else #when 'website'
        !(about_types + project_types).include?(@page_type)
    end
  end

end
