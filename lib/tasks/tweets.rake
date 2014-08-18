namespace :tweets do

  task fetch: :environment do
    time_start = Time.now
    tokens = YAML.load_file(File.join(Rails.root, 'config', 'secrets.yml'))[Rails.env].symbolize_keys rescue nil

    if tokens[:twitter].present?
      puts "", "TWITTER", ""
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        = tokens[:twitter]['api_key']
        config.consumer_secret     = tokens[:twitter]['secret_key']
      end

      username = tokens[:twitter]['username']

      begin
        # Get user's latest non-reply tweet
        tweets = @twitter.user_timeline(username, exclude_replies: true) rescue nil
        raise "No tweets returned" if tweets.blank?

        tweet = tweets.first
        html = tweet.text.gsub(/(\@([a-z0-9_]+))/im, '<a href="https://twitter.com/\2" target="_blank" rel="nofollow">\1</a>')
        tweet.urls.each{|v| html.gsub!(v['url'], "<a href=\"#{v['expanded_url']}\" target=\"_blank\" rel=\"nofollow\">#{v['display_url']}</a>") }

        Setting.about_latest_tweet = {
          'id'              => tweet.id,
          'text'            => tweet.text,
          'html'            => html,
          'reweet_count'    => tweet.retweet_count,
          'favorite_count'  => tweet.favorite_count,
          'url'             => tweet.uri
        }

        # CACHE CLEAR (/about page)
        Rails.cache.delete_matched('page/.*/about/.*') rescue nil

        puts "Congrats! @#{username} recently tweeted: #{Setting.about_latest_tweet['text']}",""

      rescue => err
        puts "ERROR: Unable to fetch Twitter info. #{err}"
      end
    end



  end

end