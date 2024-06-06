require 'line/bot'

class PushLineJob < ApplicationJob
  queue_as :default

  def perform(*args)
    limit_seven_days = Date.today..Time.now.end_of_day + (7.days)
    users = User.all
    users.each do |user|
        if user.line_alert == true
            message = {
                type: 'text',
                text: "こんにちは、ご利用ありがとうございます."
            }
            response = line_client.push_message(user.uid, message)
            logger.info "PushLineSuccess"
        end
    end
  end

  private

  def line_client
    Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
