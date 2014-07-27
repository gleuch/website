class CreateNewsletterSubscribers < ActiveRecord::Migration

  def change
    create_table :newsletter_subscribers do |t|
      t.string    :uuid
      t.integer   :list,          default: 0
      t.string    :email
      t.string    :first_name
      t.string    :last_name
      t.string    :referral
      t.integer   :status,        default: 0
      t.timestamps
    end

    add_index :newsletter_subscribers, [:uuid], unique: true
    add_index :newsletter_subscribers, [:list, :email], unique: true
  end

end
