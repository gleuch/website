
# Get updates social stats
every :day, at: '03:00am', roles: [:db, :stage_db] do
  rake 'social_stats:fetch', output: 'log/social_stats.log'
end

every 15.minutes, roles: [:db, :stage_db] do
  rake 'tweets:fetch', output: 'log/tweets.log'
end

# # Clear cache daily
# every :day, at: '03:10am', roles: [:db, :stage_db] do
#   rake 'cache:clear'
# end