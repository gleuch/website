class CreateContactMessages < ActiveRecord::Migration

  def change
    create_table :contact_messages do |t|
      t.string    :uuid
      t.string    :session_id
      t.integer   :subject,         default: 0
      t.string    :name
      t.string    :email
      t.string    :phone
      t.text      :message
      t.string    :ip_address
      t.string    :browser
      t.string    :referrer
      t.timestamps
    end

    add_index :contact_messages, [:uuid], unique: true
  end

end
