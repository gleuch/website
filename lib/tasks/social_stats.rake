namespace :social_stats do

  task fetch: :environment do
    time_start = Time.now
    tokens = YAML.load_file(File.join(Rails.root, 'config', 'secrets.yml'))[Rails.env].symbolize_keys rescue nil


    # GITHUB
    if tokens[:github].present?
      puts "", "GITHUB"
      repos_ct, commits_ct = 0, 0
      username = tokens[:github]['username']

      lists = []
      lists << {} # Seed with empty hash so that repo list calls /user/repos instead of /user/:user/repos, as latter does not include privately contributed repos from list.

      @github = Github.new(oauth_token: tokens[:github]['oauth_token'])

      # Get all user's organizations
      @github.orgs.list(auto_pagination: true, user: username).each{|org| lists << {org: org.login}}

      # Get repos by list type (user or org)
      lists.each do |list|
        puts '','-'*80,(s = list.to_a.join(': ')).present? ? s : username,''

        @github.repos.list(list.merge(type: :all, auto_pagination: true)).each do |repo|
          begin
            repo_user, repo_name = repo.full_name.split('/')

            @github.repos.stats.contributors(type: :all, auto_pagination: true, user: repo_user, repo: repo_name).each do |contrib|
              next unless contrib.author.login == username
              puts "#{repo.full_name}: #{contrib.total}"
              commits_ct += contrib.total
            end

            repos_ct += 1
          rescue => err
            "ERROR: Unable to access #{repo.name}. #{err}"
          end
        end
      end

      Setting.stats_github_repos = repos_ct
      Setting.stats_github_commits = commits_ct

      puts "","","Congrats! You've commited #{Setting.stats_github_commits} times into #{Setting.stats_github_repos} repos.",""
    end

    # TWITTER
    if tokens[:twitter].present?
      puts "", "TWITTER", ""
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        = tokens[:twitter]['api_key']
        config.consumer_secret     = tokens[:twitter]['secret_key']
      end

      username = tokens[:twitter]['username']

      begin
        user = @twitter.user(username)
        Setting.stats_tweets = user.statuses_count || 0
        Setting.stats_favorited_tweets = user.favorites_count || 0
      rescue => err
        puts "ERROR: Unable to fetch Twitter info. #{err}"
      end

      puts "Congrats! You've tweeted #{Setting.stats_tweets} times and favorited #{Setting.stats_favorited_tweets} times.",""
    end


    # CACHE CLEAR (/about page)
    Rails.cache.delete_matched('page/.*/about/.*') rescue nil


    # DONE!
    puts "", "Done! (#{(Time.now-time_start).to_f} sec)",""

  end

end