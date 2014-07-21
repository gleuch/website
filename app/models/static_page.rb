class StaticPage

  # Act like a static page
  include Pageable

  # Tableless records, so that we can use impressionist
  include TablelessPageable

  # Impressionist
  is_impressionable


protected


end
