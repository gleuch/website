module TablelessPageable
  extend ActiveSupport::Concern

  included do

    # Use ActiveRecord-tableless, add id column
    has_no_table database: :pretend_success
    column :id, :string

    alias_method :slug, :id

  end


  # Hack to trick impressionist into saving on a tableless record
  def new_record?; false; end

end