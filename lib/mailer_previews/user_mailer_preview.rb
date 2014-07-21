if ['test','development'].include?(Rails.env)

  class UserMailerPreview < ActionMailer::Preview

    def admin_contact_message
      with_transaction do
        @contact_message = FactoryGirl.create :contact_message
        UserMailer.admin_contact_message(@contact_message)
      end
    end

  private

    def with_transaction(&block)
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
      begin
        require "factory_girl"
        FactoryGirl.reload
        (yield block).tap { DatabaseCleaner.clean }
      rescue Exception => e
        DatabaseCleaner.clean
        raise e
      end
    end
  end

end