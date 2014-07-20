class Project < ActiveRecord::Base

  # Act like a static page
  include Pageable

  # Tableless records, so that we can use impressionist
  has_no_table database: :pretend_success
  column :id, :string

  # Impressionist
  is_impressionable



  # Hack to trick impressionist into saving on a tableless record
  def new_record?; false; end


protected


end
