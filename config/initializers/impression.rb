
# List of user agent wildcard matches
WT_WILD_CARDS = [
  'flipboard',
  'facebookexternalhit',
  'spider'
]

# List of specific user agent strings
WT_LIST = [ ]


WT_WILD_CARDS.each {|wc| Impressionist::Bots::WILD_CARDS << wc }
WT_LIST.each {|wl| Impressionist::Bots::LIST << wl }


Impressionist::Impressionable.module_eval do
  def get_impression_count(options={})
    # Uses these options as defaults unless overridden in options hash
    options.reverse_merge!(filter: :request_hash, start_date: nil, end_date: Time.now, action_name: nil, controller_name: nil)

    # If a start_date is provided, finds impressions between then and the end_date. Otherwise returns all impressions
    imps = options[:start_date].blank? ? impressions : impressions.where("created_at >= ? and created_at <= ?", options[:start_date], options[:end_date])

    # Conditions
    imps = imps.where("impressions.message = ?", options[:message]) if options[:message]
    imps = imps.where("impressions.action_name = ?", options[:action_name]) if options[:action_name]
    imps = imps.where("impressions.controller_name = ?", options[:controller_name]) if options[:controller_name]

    # Count all distinct impressions unless the :all filter is provided.
    options[:filter] != :all ? imps.select(options[:filter]).distinct.count : imps.count
  end
end


# # One line change, but have to include some of this so it doesn't raise errors.... ugh
# 
# module ImpressionistController
#   module ClassMethods
#     def impressionist(opts={})
#       before_filter { |c| c.impressionist_subapp_filter(opts)}
#     end
#   end
# 
#   module InstanceMethods
#     def self.included(base)
#       base.before_filter :impressionist_app_filter
#     end
# 
#     def impressionist(obj,message=nil,opts={})
#       if should_count_impression?(opts)
#         if obj.respond_to?("impressionable?")
#           if unique_instance?(obj, opts[:unique])
#             obj.impressions.create(associative_create_statement({message: message}))
#           end
#         else
#           # we could create an impression anyway. for classes, too. why not?
#           raise "#{obj.class.to_s} is not impressionable!"
#         end
#       end
#     end
# 
#     def impressionist_app_filter
#       @impressionist_hash = Digest::SHA2.hexdigest(Time.now.to_f.to_s+rand(10000).to_s)
#     end
# 
#     def impressionist_subapp_filter(opts = {})
#       if should_count_impression?(opts)
#         actions = opts[:actions]
#         actions.collect!{|a|a.to_s} unless actions.blank?
#         if (actions.blank? || actions.include?(action_name)) && unique?(opts[:unique])
#           Impression.create(direct_create_statement)
#         end
#       end
#     end
# 
#     protected
# 
#     # creates a statment hash that contains default values for creating an impression via an AR relation.
#     def associative_create_statement(query_params={})
#       query_params.reverse_merge!(
#         :controller_name => controller_name,
#         :action_name => action_name,
#         :user_id => user_id,
#         :request_hash => @impressionist_hash,
#         :session_hash => session_hash,
#         :ip_address => request.remote_ip,
#         :referrer => request.referer
#         )
#     end
# 
#     private
# 
#     def bypass
#       Impressionist::Bots.bot?(request.user_agent)
#     end
# 
#     def should_count_impression?(opts)
#       !bypass && condition_true?(opts[:if]) && condition_false?(opts[:unless])
#     end
# 
#     def condition_true?(condition)
#       condition.present? ? conditional?(condition) : true
#     end
# 
#     def condition_false?(condition)
#       condition.present? ? !conditional?(condition) : true
#     end
# 
#     def conditional?(condition)
#       condition.is_a?(Symbol) ? self.send(condition) : condition.call
#     end
# 
#     def unique_instance?(impressionable, unique_opts)
#       return unique_opts.blank? || !impressionable.impressions.where(unique_query(unique_opts)).exists?
#     end
# 
#     def unique?(unique_opts)
#       return unique_opts.blank? || !Impression.where(unique_query(unique_opts)).exists?
#     end
# 
#     # creates the query to check for uniqueness
#     def unique_query(unique_opts)
#       full_statement = direct_create_statement
#       # reduce the full statement to the params we need for the specified unique options
#       unique_opts.reduce({}) do |query, param|
#         query[param] = full_statement[param]
#         query
#       end
#     end
# 
#     # creates a statment hash that contains default values for creating an impression.
#     def direct_create_statement(query_params={})
#       query_params.reverse_merge!(
#         :impressionable_type => controller_name.singularize.camelize,
#         :impressionable_id=> params[:id]
#         )
#       associative_create_statement(query_params)
#     end
# 
#     def session_hash
#       # # careful: request.session_options[:id] encoding in rspec test was ASCII-8BIT
#       # # that broke the database query for uniqueness. not sure if this is a testing only issue.
#       # str = request.session_options[:id]
#       # logger.debug "Encoding: #{str.encoding.inspect}"
#       # # request.session_options[:id].encode("ISO-8859-1")
#       request.session_options[:id]
#     end
# 
#     #use both @current_user and current_user helper
#     def user_id
#       user_id = @current_user ? @current_user.id : nil rescue nil
#       user_id = current_user ? current_user.id : nil rescue nil if user_id.blank?
#       user_id
#     end
#   end
# end
