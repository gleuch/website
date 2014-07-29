
# Get updates social stats
every :day, at: '03:00am', roles: [:db, :stage_db] do
  rake 'social_stats:fetch', output: 'log/social_stats.log'
end

# # Clear cache daily
# every :day, at: '03:10am', roles: [:db, :stage_db] do
#   rake 'cache:clear'
# end