module TablelessPageable
  extend ActiveSupport::Concern

  included do

    # Use ActiveRecord-tableless, add id column
    has_no_table database: :pretend_success
    column :id, :string

  end


end