require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  task :setup => :environment do
    require 'resque'
    require 'resque_scheduler'
    Dir[File.join(Rails.root, 'app', 'jobs', '*.rb')].each { |file| require file }

    rails_env = ENV['RAILS_ENV'] || Rails.env
    app_config = ENV['APP_CONFIG'] || YAML.load_file(File.join(Rails.root, 'config', 'application.yml'))[rails_env]
    Resque.redis = app_config['redis']['url']
    Resque.schedule = YAML.load_file(File.join(Rails.root, 'config', 'resque_schedule.yml'))
  end
end