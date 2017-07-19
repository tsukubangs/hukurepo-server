require 'slack'

Slack.configure do |config|
  config.token = ENV['SLACK_KEY']
end
