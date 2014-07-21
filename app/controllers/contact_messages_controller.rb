class ContactMessagesController < ApplicationController

  before_filter :block_spam_forms
  before_filter :load_new_resource
  before_filter :contact_messages_init

  # layout 'post'


  def index
    render :index
  end

  def new
    render :index
  end

  def create
    @contact_message.assign_attributes(contact_messages_params)
    if @contact_message.save
      flash[:alert] = t('.success')
      redirect_to contact_messages_url
    else
      render :index
    end
  end



protected

  def contact_messages_init
    #
  end

  def load_new_resource
    @contact_message = ContactMessage.new(referrer: request.referrer)
  end

  def contact_messages_params
    params.require(:contact_message).permit(:subject, :name, :email, :phone, :message, :referrer).merge(
      ip_address: request.remote_ip,
      browser:    request.user_agent,
      session_id: session[:id]
    )
  end

  def block_spam_forms
    ips = []
    raise Gleuch::Unauthorized if ips.include?(request.remote_ip)
  end

end