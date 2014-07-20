
# List of user agent wildcard matches
IMPRESSIONIST_WILD_CARDS = [
  'flipboard',
  'facebookexternalhit',
  'spider'
]

# List of specific user agent strings
IMPRESSIONIST_LIST = [ ]


IMPRESSIONIST_WILD_CARDS.each {|wc| Impressionist::Bots::WILD_CARDS << wc }
IMPRESSIONIST_LIST.each {|wl| Impressionist::Bots::LIST << wl }


# Impressionist::Impressionable.module_eval do
#   def get_impression_count(options={})
#     # Uses these options as defaults unless overridden in options hash
#     options.reverse_merge!(filter: :request_hash, start_date: nil, end_date: Time.now, action_name: nil, controller_name: nil)
# 
#     # If a start_date is provided, finds impressions between then and the end_date. Otherwise returns all impressions
#     imps = options[:start_date].blank? ? impressions : impressions.where("created_at >= ? and created_at <= ?", options[:start_date], options[:end_date])
# 
#     # Conditions
#     imps = imps.where("impressions.message = ?", options[:message]) if options[:message]
#     imps = imps.where("impressions.action_name = ?", options[:action_name]) if options[:action_name]
#     imps = imps.where("impressions.controller_name = ?", options[:controller_name]) if options[:controller_name]
# 
#     # Count all distinct impressions unless the :all filter is provided.
#     options[:filter] != :all ? imps.select(options[:filter]).distinct.count : imps.count
#   end
# end
