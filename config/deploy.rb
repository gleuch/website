lock '3.2.1'

set :application, 'Gleuch'
set :repo_url, 'git@github.com:gleuch/website.git'
set :rvm_type, :user
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :scm, :git
set :format, :pretty
set :log_level, :debug

set :linked_files, %w{config/database.yml config/secrets.yml} # config/s3.yml config/redis.yml config/sidekiq.yml config/mailchimp.yml 
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system} # public/sitemaps

set :keep_releases, 5


# --- DEPLOY ------------------------------------------------------------------
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  # after :restart, 'airbrake:deploy'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

end
