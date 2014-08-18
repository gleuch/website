class ClientWork < ActiveRecord::Base

  # Act like a static page
  include Pageable

  # Tableless records, so that we can use impressionist
  include TablelessPageable

  # Impressionist
  is_impressionable


  def self.view_path; 'client_works'; end


protected


end
