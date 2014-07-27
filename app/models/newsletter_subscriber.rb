class NewsletterSubscriber < ActiveRecord::Base

  include Uuidable

  enum list: {
    general:      0
  }

  enum status: {
    waiting:      0,
    subscribed:   1,
    unsubscribed: 2,
    errored:      3
  }


  validates :email, presence: true, email: true

  after_create :subscribe!


  def subscribe!
    # return false unless Rails.configuration.mailchimp
    # 
    # response = Rails.configuration.mailchimp.lists.subscribe({id: newsletter_list_id, email: { email: email }, double_optin: false})
    # 
    # if response['status'] == 'error'
    #   self.errored!
    # else
    #   self.subscribed!
    # end
  end

private

  # Corresponding list id for matched list enum
  def newsletter_list_id
    ''
    # case self.list
    #   else;                 nil
    # end
  end
        


end
