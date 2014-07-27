class ContactMessage < ActiveRecord::Base

  include Uuidable
  extend FriendlyId

  enum subject: {
    hello:          1,
    question:       2,
    collaboration:  3,
    work:           5,
    hate:           9,
  }

  friendly_id :uuid, use: [:finders]


  has_many :impressions, primary_key: 'session_id', foreign_key: 'session_id'

  attr_accessor :newsletter_subscribe


  validates :subject,   presence: true
  validates :email,     presence: true,     email: true
  validates :name,      presence: true,     length: {in: 2..200}
  validates :phone,     allow_blank: true,  length: {in: 2..200}, format: {with: /\A[\d\s\.\-\+\(\)]+\Z/}
  validates :message,   presence: true,     length: {in: 2..5000}

  after_create :subscribe_to_newsletter
  after_create :send_admin_email


  def self.subjects_text
    subjects.map{|k,v| [I18n.t(k, scope: 'activerecord.enums.contact_message.subject'),k] }.to_h
  end

  def subject_text
    I18n.t(self.subject, scope: 'activerecord.enums.contact_message.subject')
  end


private

  def subscribe_to_newsletter
    NewsletterSubscriber.create(list: :general, email: self.email, referral: :contact_form) if self.newsletter_subscribe
  end

  def send_admin_email
    UserMailer.admin_contact_message(self)
  end

end
